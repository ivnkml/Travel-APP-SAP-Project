CLASS zbp_i_pet_booking DEFINITION PUBLIC ABSTRACT FINAL FOR BEHAVIOR OF zi_pet_trav_def.
ENDCLASS.

CLASS zbp_i_pet_booking IMPLEMENTATION.
ENDCLASS.




--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


CLASS lhc_Booking DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS calculateBookingID FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Booking~calculateBookingID.

    METHODS calculateTotalPrice FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Booking~calculateTotalPrice.

ENDCLASS.

CLASS lhc_Booking IMPLEMENTATION.

  METHOD calculateBookingID.

    DATA max_bookingid TYPE /dmo/booking_id.
    DATA update TYPE TABLE FOR UPDATE ZI_PET_TRAV_DEF\Booking.

    " Für die angeforderten Buchungen werden alle zugehörigen Reisen gelesen.
    " Falls mehrere Buchungen derselben Reise betroffen sind, wird die Reise nur einmal zurückgegeben.
    READ ENTITIES OF ZI_PET_TRAV_DEF IN LOCAL MODE
    ENTITY Booking BY _Travel
      FIELDS ( TravelUUID )
      WITH CORRESPONDING #( keys )
      RESULT DATA(travels).

    " Für jede betroffene Reise: alle Buchungen lesen, max. BookingID ermitteln und freie IDs vergeben.
    LOOP AT travels INTO DATA(travel).
      READ ENTITIES OF ZI_PET_TRAV_DEF IN LOCAL MODE
        ENTITY Travel BY _Booking
          FIELDS ( BookingID )
        WITH VALUE #( ( %tky = travel-%tky ) )
        RESULT DATA(bookings).

      " Maximal verwendete BookingID für diese Reise bestimmen
      max_bookingid = '0000'.
      LOOP AT bookings INTO DATA(booking).
        IF booking-BookingID > max_bookingid.
          max_bookingid = booking-BookingID.
        ENDIF.
      ENDLOOP.

      " Vergabe einer neuen BookingID (inkrementiert um 10) für Buchungen ohne ID
      LOOP AT bookings INTO booking WHERE BookingID IS INITIAL.
        max_bookingid += 10.
        APPEND VALUE #( %tky      = booking-%tky
                        BookingID = max_bookingid
                      ) TO update.
      ENDLOOP.
    ENDLOOP.

    " Aktualisierung der BookingID für alle relevanten Buchungen
    MODIFY ENTITIES OF ZI_PET_TRAV_DEF IN LOCAL MODE
    ENTITY Booking
      UPDATE FIELDS ( BookingID ) WITH update
    REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).

  ENDMETHOD.

  METHOD calculateTotalPrice.

    " Für die angeforderten Buchungen alle zugehörigen Reisen lesen.
    READ ENTITIES OF ZI_PET_TRAV_DEF IN LOCAL MODE
    ENTITY Booking BY _Travel
      FIELDS ( TravelUUID )
      WITH CORRESPONDING #( keys )
      RESULT DATA(travels)
      FAILED DATA(read_failed).

    " Neuberechnung des Gesamtpreises für jede betroffene Reise anstoßen
    MODIFY ENTITIES OF ZI_PET_TRAV_DEF IN LOCAL MODE
    ENTITY Travel
      EXECUTE recalcTotalPrice
      FROM CORRESPONDING #( travels )
    REPORTED DATA(execute_reported).

    reported = CORRESPONDING #( DEEP execute_reported ).

  ENDMETHOD.

ENDCLASS.

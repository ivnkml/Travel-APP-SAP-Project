CLASS zcl_pet_eml001 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_pet_eml001 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

* --- Verschiedene EML-Lese-Beispiele (READ ENTITIES) für Travel und untergeordnete Buchungen ---
* 1. Lesen einer Travel-Instanz anhand der UUID
*  READ ENTITIES OF zi_pet_trav_def
*    ENTITY Travel
*        FROM VALUE #( ( TravelUUID = 'B88DCC1013F9DF6B1900182EFBE2EBA6' ) )
*    RESULT DATA(travels).
*  out->write( travels ).

* 2. Lesen bestimmter Felder (AgencyID, CustomerID)
*  READ ENTITIES OF zi_pet_trav_def
*    ENTITY Travel
*        FIELDS ( AgencyID CustomerID )
*    WITH VALUE #( ( TravelUUID = 'B88DCC1013F9DF6B1900182EFBE2EBA6' ) )
*    RESULT DATA(travels).
*  out->write( travels ).

* 3. Lesen aller Felder für eine Travel-Instanz
*  READ ENTITIES OF zi_pet_trav_def
*    ENTITY Travel
*       ALL FIELDS
*    WITH VALUE #( ( TravelUUID = 'B88DCC1013F9DF6B1900182EFBE2EBA6' ) )
*    RESULT DATA(travels).
*  out->write( travels ).

* 4. Lesen aller Buchungen (Bookings) einer Travel-Instanz via Assoziation
*  READ ENTITIES OF zi_pet_trav_def
*    ENTITY Travel BY \_Booking
*       ALL FIELDS
*    WITH VALUE #( ( TravelUUID = 'B88DCC1013F9DF6B1900182EFBE2EBA6' ) )
*    RESULT DATA(travels).
*  out->write( travels ).

* 5. Fehlerbehandlung beim Lesen (FAILED/REPORTED-Tabellen)
*  READ ENTITIES OF zi_pet_trav_def
*    ENTITY Travel
*       ALL FIELDS
*    WITH VALUE #( ( TravelUUID = '11111111111111111111111111111111' ) )
*    RESULT DATA(travels)
*    FAILED DATA(failed)
*    REPORTED DATA(reported).
*  out->write( travels ).
*  out->write( failed ).
*  out->write( reported ).

* --- Beispiel: Update einer Reisebeschreibung ---
*  MODIFY ENTITIES OF zi_pet_trav_def
*    ENTITY Travel
*       UPDATE
*           SET FIELDS WITH VALUE #( ( TravelUUID = 'B88DCC1013F9DF6B1900182EFBE2EBA6'
*                                      Description = 'I LOVE SAP' ) )
*    FAILED DATA(failed)
*    REPORTED DATA(reported).
*  out->write( 'Update was successful' ).
*
*  COMMIT ENTITIES
*    RESPONSE OF zi_pet_trav_def
*    FAILED DATA(failed_commit)
*    REPORTED DATA(reported_commit).

* --- Beispiel: Neue Reise anlegen (CREATE) ---
*  MODIFY ENTITIES OF zi_pet_trav_def
*    ENTITY Travel
*       CREATE
*           SET FIELDS WITH VALUE #( ( %cid = 'My_new_content'
*                                      AgencyID = '33333'
*                                      CustomerID = '14'
*                                      BeginDate = cl_abap_context_info=>get_system_date( )
*                                      EndDate = cl_abap_context_info=>get_system_date( ) + 10
*                                      Description = 'GIVE ME JOB' ) )
*    MAPPED DATA(mapped)
*    FAILED DATA(failed)
*    REPORTED DATA(reported).
*  out->write( mapped-travel ).
*
*  COMMIT ENTITIES
*    RESPONSE OF zi_pet_trav_def
*    FAILED DATA(failed_commit)
*    REPORTED DATA(reported_commit).
*   out->write( 'Create complete' ).

  " Beispiel: Löschen einer Reise (DELETE)
  MODIFY ENTITIES OF zi_pet_trav_def
    ENTITY Travel
       DELETE FROM
           VALUE #( ( TravelUUID = 'AACCD46AA3D71FE08EE60CE0E11EDAE3' ) )
    FAILED DATA(failed)
    REPORTED DATA(reported).

  COMMIT ENTITIES
    RESPONSE OF zi_pet_trav_def
    FAILED DATA(failed_commit)
    REPORTED DATA(reported_commit).

  out->write( 'Delete complete' ).

  ENDMETHOD.
ENDCLASS.

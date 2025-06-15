# Travel-APP-SAP-Project

! img/travel_app11.png

## Kurze Projektbeschreibung
Dieses Projekt demonstriert die Umsetzung einer Business-Anwendung im SAP ABAP Cloud Umfeld auf Basis des ABAP RESTful Application Programming Model (RAP).
Der Fokus liegt auf der Modellierung und Entwicklung von BO-Strukturen (Business Objects) inklusive CDS-Views, Behavior Definitions, Validierungen, Aktionen, Berechtigungsprüfungen und der Integration in Fiori Elements.
Das Projekt entstand im Rahmen von Lern- und Übungsaufgaben und dient als Beleg für mein praktisches Verständnis des RAP-Konzepts.

## Technologien und Komponenten
ABAP Cloud / RAP (RESTful Application Programming Model)
Core Data Services (CDS): Root- und Projection-Views für Travel & Booking, Assoziationen, Value Helps
Behavior Definitions: Draft-Handling, Actions, Validierungen, Instanz-spezifische Features
EML (Entity Manipulation Language): Lesen, Ändern, Erstellen und Löschen von Daten via BO-API
Fiori Elements Annotations: UI-Positionierung und Sichtbarkeit
ABAP-Klassen: Eigene Handler (Logik, Berechtigungen, Validierungen), Hilfsklassen zur Testdaten-Generierung, Exception-Handling
Access Control (CDS Rollen)
Testdaten-Generierung: Automatisierte Befüllung von Beispiel-Daten

## Projektstruktur & Architektur
/Authorizations
  /Authorization Default (TADIR)
    ├─ AD32B098FXXXXX0916CCBBDE710HT
    ├─ B870D00AXXXXXXXX1C52A68700DHT
  /Authorization Fields
    ├─ ZOSTAT0001
  /Authorizations Object
    ├─ ZOSTAT0001
/Business Services
  /Service Bindings
    ├─ ZUI_PET_TRAVEL_02_1
  /Service Definitions
    ├─ ZUI_PET_TRAVEL_1
/Cloud Communication Management
  /Invound Services
    ├─ ZUI_PET_TRAVEL_02_1_IWSG
/Core Data Services
  /Access Controls
    ├─ ZC_PET_TRAVEL_1
    ├─ ZI_PET_TRAV_DEF    
  /Behavior Definitions 
    ├─ ZC_PET_TRAVEL_1
    ├─ ZI_PET_TRAV_DEF    
  /Data Definitions
    ├─ ZC_PET_BOOK_1
    ├─ ZC_PET_TRAVEL_1
    ├─ ZI_PET_BOOK_DEF
    ├─ ZI_PET_TRAV_DEF
  /Metadata Extensions
    ├─ ZC_PET_BOOK_1
    ├─ ZC_PET_TRAVEL_1
/Dictionary
  /Data Elements
    ├─ ZOSTAT_PET_TRAVEL001
  /Database Tables
    ├─ ZPET_BOOKDAT
    ├─ ZPET_DBOOK
    ├─ ZPET_DTRAV
    ├─ ZPET_TRAVDAT
/Identity and Access Management
  /Authorization Object Extensions
    ├─ ZOSTAT0001
  /IAM Apps
    ├─ ZUI_PET_TRAVEL_02_1_IWSG_IBS
/Others
  /Gateway Vocabulary Annotations V2
    ├─ ZUI_PET_TRAVEL_02_1_VAN
  /OAuth 2.0 Scopes
    ├─ ZUI_PET_TRAVEL_02_1_0001
  /SAP Gateway Models Metadata
    ├─ ZUI_PET_TRAVEL_02_1_0001_BE
  /SAP Service Groups Metadata
    ├─ ZUI_PET_TRAVEL_02_1_0001
/Source Code Library
  /Classes
    ├─ ZBP_I_PET_BOOKING
    ├─ ZBP_I_PET_TRAVEL
    ├─ ZCL_GENERATE_DATA_01
    ├─ ZCL_PET_EML001
    ├─ ZCM_PET_001
/Texts
  /Message Classes
    ├─ ZPET_MSG_001
/img
  ├─ Screenshots


## Funktionsumfang
Anlegen, Anzeigen, Bearbeiten und Löschen von Reisen (Travel) und Buchungen (Booking) im Fiori Elements UI
Draft-Modus für Business Objects (Entwurfsfunktion)
### Business-Validierungen:
Prüfen von Datumsintervallen (Ende nach Beginn, Beginn nicht in der Vergangenheit)
Existenzprüfung für Kunden und Agenturen
Detailliertes Fehlermessaging über eigene Exception-Klasse
### Geschäftslogik:
Automatische Vergabe von BookingID
Berechnung von Gesamtpreis (TotalPrice) inkl. Währungsumrechnung
### Actions: Reise annehmen/ablehnen (Accept/Reject)
Berechtigungsprüfungen (Authorizations) für Operationen
### EML-Beispiele (Entity Manipulation Language):
Komplexe Lese- und Schreiboperationen über mehrere Tabellen

## Technische Highlights
CDS-Views bilden die gesamte BO-Struktur mit Vererbungen, Assoziationen und Projektionen ab.
Behavior Definitions steuern erlaubte Aktionen, Draft/Lock-Verhalten, Validierungen und Instanz-Autorisierung.
Handler-Klassen (lhc_Travel, lhc_Booking) enthalten sämtliche Geschäftslogik und Validierungsregeln.
zcl_generate_data_01 erzeugt Testdaten für ein schnelles Onboarding und Demos.
zcl_pet_eml001 zeigt verschiedene EML-Szenarien (CRUD, Error-Handling etc.).
zcm_pet_001 kapselt Business-Fehler als eigene Exception inkl. T100-Message-Unterstützung.

## Hinweis für Arbeitgeber / Reviewer
Der Code wurde komplett eigenständig im Rahmen eines Lernprojekts entwickelt und begleitet meine Weiterbildung in RAP/ABAP Cloud.
Der Fokus liegt auf Klarheit der Struktur, Nachvollziehbarkeit, sauberer Modularisierung und modernen SAP-Standards (RAP, CDS, Fiori, EML).
Das Repository dient als Portfolio-Beleg meiner praktischen Erfahrungen im SAP Cloud Umfeld.


Adds a validated "Belgian National Insurance Number" element to the Webform module that masks input and checks the rijksregisternummer / numero de registre national modulo-97 checksum.

---

The Belgian national number (RRN/NRN) is an 11-digit identifier whose digits encode a birth date, a daily sequence number, and a two-digit modulo-97 check. This module registers a Webform form element (`webform_belgian_national_insurance_number`) that renders as a masked text field (`999999-999-99`, using Webform's built-in inputmask library) and rejects any value whose check digits do not match — testing both the pre-2000 and post-2000 encodings of the birth-date portion. Site builders add it from the Webform element picker like any other element, supplying their own error message; there is no site-wide configuration, no permissions, and no database schema of its own. It depends only on the Webform module.

---

- Collect a Belgian national number (rijksregisternummer) on a webform.
- Validate the RRN/NRN modulo-97 checksum at submit time.
- Catch transcription typos in an 11-digit identifier before they are stored.
- Reject a syntactically invalid Belgian national number.
- Show a masked input field in the `999999-999-99` format to guide data entry.
- Add the element from the Webform build UI (Add element) without writing code.
- Configure a custom, translatable error message per element instance.
- Accept post-2000 birth dates via the module's dual check-digit logic.
- Accept pre-2000 birth dates via the standard modulo-97 remainder.
- Build a Belgian public-sector intake form that needs a national number.
- Build a healthcare or insurance webform requiring the INSZ/NISS number.
- Mark the element required or optional like any other Webform element.
- Skip validation automatically when an optional field is left empty.
- Reuse Webform's conditional states (states_wrapper) to show/hide the field.
- Store the entered number in Webform submission data for later export.
- Include the RRN element in a multi-step (wizard) webform.
- Pre-fill or default the field through standard Webform element properties.
- Localise the field label and messages via the shipped nl/fr translations.
- Combine RRN validation with Webform's email/handler workflow on submit.
- Provide inline format guidance to reduce support requests on Belgian forms.

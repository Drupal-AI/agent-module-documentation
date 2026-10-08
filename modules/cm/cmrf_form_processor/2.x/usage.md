<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CiviMRF Form Processor connects Drupal Webforms to CiviCRM's Form Processor extension over a CiviMRF connection, adding a Webform handler that maps submissions to Form Processor API calls.

---

Sites that run CiviCRM alongside Drupal often collect data in Webforms that must flow into CiviCRM. This module adds a Webform **handler** ("CiviCRM Form Processor with CiviMcRestFace (CMRF)") that, on the submission states you choose, maps each Webform field to a Form Processor parameter and posts it to CiviCRM through the `cmrf_core` connection layer — so no direct HTTP call to CiviCRM is made from this module. Beyond one-way submission it can pre-fill a form with **default values** retrieved from CiviCRM (turning a form into an edit form, optionally showing "page not found"/"access denied" when CiviCRM returns nothing), run server-side **validation** against the Form Processor, perform live **calculations** over AJAX, follow a **redirect** URL returned by CiviCRM (handy for payment flows), and exchange **files** between Webform and CiviCRM. It can also synchronise the Form Processor's input fields into the Webform as elements. Two submodules extend it: `cmrf_form_processor_display` (a display-only Webform element) and `cmrf_form_processor_mollie` (defers the Form Processor call to the Mollie payment webhook). Requires the `cmrf_core` and `webform` modules, plus the Form Processor extension on the CiviCRM side. Submission data is personal data forwarded to CiviCRM, and the CiviMRF connection credentials are secrets held by `cmrf_core`.

---

- Submit Webforms to the CiviCRM Form Processor.
- Map submission fields to Form Processor parameters.
- Send on chosen Webform states (draft, completed, updated, deleted…).
- Pre-fill forms with CiviCRM default values.
- Turn a form into an edit form for existing CiviCRM data.
- Show page-not-found / access-denied when no data is returned.
- Validate submissions server-side via the Form Processor.
- Run live calculations over AJAX.
- Follow a CiviCRM-supplied redirect (e.g. to payment).
- Sync Form Processor input fields into the Webform.
- Choose per-field submission formats.
- Exchange files between Webform and CiviCRM.
- Add a display-only element with the display submodule.
- Defer processing to the Mollie webhook with the Mollie submodule.
- Configure the CiviMRF connection in cmrf_core.
- Keep CiviMRF connection credentials secure.
- Handle forwarded submission data as PII.
- Install the Form Processor extension on CiviCRM.
- Test the mapping before production.
- Review handler configuration after upgrades.

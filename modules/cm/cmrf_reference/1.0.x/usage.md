<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CMRF Reference Field

Provides Webform elements (a reference autocomplete and a radios variant) that look up values live from CiviCRM via a CiviMRF (CMRF) connection.

- Lets Webform builders add fields whose options/matches come from a CiviCRM data processor or API search.
- Renders an autocomplete widget that queries CiviCRM server-side as the user types.
- Useful for contact pickers, membership/type selectors and other CRM-driven form inputs.
- Keeps CiviCRM as the source of truth instead of hard-coding option lists in the form.

---

## Installation & configuration

- Depends on `webform` and `cmrf_core`; install via Composer and enable with `drush en cmrf_reference`.
- Requires a configured CiviMRF connection plus a CiviCRM data processor / search to reference.
- Add the "CMRF Reference" or "CMRF Radios" element to a Webform in the Webform element UI.
- Configure the connection, data processor, search, display field and return field on the element.
- Set autocomplete match length and result limit per element as needed.

---

## Usage & API

- Autocomplete route: `/cmrfreference/{webform}/autocomplete/{key}`, guarded by `_entity_access: 'webform.submission_page'`.
- `CMRFReferenceController::autocomplete()` reads the `q` query parameter and returns JSON matches.
- Access to the autocomplete endpoint is tied to the ability to view the webform's submission page.
- `#autocomplete_match` (default 3) enforces a minimum query length before a lookup runs.
- `#autocomplete_limit` (default 10) caps the number of returned suggestions.
- `CMRFReferenceUtils::matches()` performs the CiviCRM lookup via the CMRF connection.
- Provides render elements `CMRFReference` and `CMRFRadios` plus matching Webform element plugins.
- Values are resolved through CiviCRM's API/data processor, not stored locally as options.
- The `current_selection` parameter supports pre-populating already-selected references.
- No SQL is built from user input; queries go through the CMRF connection abstraction.
- Suitable for public webforms where an element must reference live CRM records.
- The display field controls the human-readable label; the return field controls the stored value.
- Works with Webform's standard submission and export pipeline.
- Ensure the referenced CiviCRM search/data processor is permissioned appropriately in CiviCRM.
- Test the element on a draft webform before exposing it publicly.
- Autocomplete results reflect whatever the CiviCRM data processor is allowed to return.

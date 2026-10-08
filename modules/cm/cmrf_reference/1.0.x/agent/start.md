<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Agent orientation: cmrf_reference

**What:** Webform elements that reference CiviCRM data via CMRF with autocomplete.

**Key files:**
- `src/Controller/CMRFReferenceController.php` — autocomplete endpoint (`q` param → JSON).
- `src/CMRFReferenceUtils.php` — CiviCRM match lookup via CMRF connection.
- `src/Element/*`, `src/Plugin/WebformElement/*` — CMRFReference / CMRFRadios.

**Route:** `/cmrfreference/{webform}/autocomplete/{key}` gated by `_entity_access: webform.submission_page`.

**Deps:** `webform`, `cmrf_core`. **Security:** access bound to webform submission-page access; lookups go through CMRF (no raw SQL).

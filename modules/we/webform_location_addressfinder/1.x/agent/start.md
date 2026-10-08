<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Location AddressFinder (webform_location_addressfinder) — agent index

**Adds AddressFinder (AU/NZ) address autocomplete/verify elements to Webform, mapping results into composite address sub-fields.**

- **Version:** 1.x
- **Core:** ^8 || ^9 || ^10 || ^11 — dep `webform:webform`
- **Elements:** composite `webform_location_addressfinder` (~30 sub-fields, extends WebformLocationBase) and single-textfield `webform_location_addressfinder_fulladdressonly`.
- **Settings:** `/admin/config/webform_location_addressfinder` (`src/Form/Settings.php`) — stores `api_key`, `is_nz`, `no_postal`. Permission: `access administration pages`.
- **JS:** local behavior + external widget `https://api.addressfinder.io/assets/v3/widget.js`; all lookups happen in the browser.

**Security:** No security findings. No server-side HTTP/SQL/deserialization/exec, no hardcoded secrets. The API key is pushed to `drupalSettings` for the browser widget (by design — public/referrer-scoped key): composite `src/Element/WebformLocationAddressFinder.php:85-89`, save `Settings.php:99`. Notes: settings route gated by broad `access administration pages`; the config **schema keys don't match** the flat keys the form actually stores (`api_key`/`is_nz`/`no_postal`).

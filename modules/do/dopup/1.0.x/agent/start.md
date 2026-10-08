<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dopup (dopup) — agent index

**Displays a Webform inside a configurable, trigger-based popup block for lead generation and marketing.**

- **Version:** 1.0.x
- **Core:** ^8 || ^9 || ^10 || ^11 · **Depends on:** webform
- **Config form:** `/admin/config/system/dopup/{block}` — permission `administer dopup configuration` (restrict access).
- **Autocomplete route:** `/dopup/autocomplete-webform` — permission `access content`.
- **Block plugin:** `DopupBlock`; settings stored in `dopup.settings` keyed by block id.
- **Security:** RECORDED FINDING (Danger 1) — `/dopup/autocomplete-webform` (`DopupAutoCompleteController::build`, `access content`) runs a webform entity query with `accessCheck(FALSE)`, letting anonymous users enumerate all webform ids/titles. Admin config route is properly permission-gated.

See [configure/setup.md](configure/setup.md)

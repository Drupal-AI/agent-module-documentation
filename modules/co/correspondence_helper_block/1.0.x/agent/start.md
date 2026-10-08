<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# correspondence_helper_block — agent orientation

Small block module. Shows admin-configured correspondence + support text plus the **current** user's email.

- Config route: `/admin/config/correspondence_helper_block` (perm `administer correspondence_helper_block settings`).
- Config object: `correspondence_helper_block.settings` (keys `communication_text`, `support_text`).
- Block plugin: `src/Plugin/Block/CorrespondenceHelperBlock.php`; form: `src/Form/AdminSettingsForm.php`.
- Only exposes the logged-in user's own email — no cross-user disclosure.
- No web-facing routes other than the admin form; no security-sensitive surface.

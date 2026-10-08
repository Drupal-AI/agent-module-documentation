<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Autosave — agent index

Auto-saves webform submissions as drafts on input change, with optional optimistic locking. Enabled
per webform via **third-party settings** (no config route, no `configure`). Works by clicking a hidden
draft-submit button through Webform's own AJAX — no custom route/controller/REST. Depends on `webform`
+ `webform_submission_log`. No permissions, no Drush.

- **Third-party settings keys + how to enable (UI / Drush / config)** →
  [configure/settings.md](configure/settings.md)
- **`webformautosave.helper` service, the form-alter/presave hooks, optimistic-locking flow, JS** →
  [api/helper.md](api/helper.md)

Key facts:
- Settings (schema `webform.third_party.webformautosave`): `auto_save` (bool),
  `auto_save_time` (int ms, default 5000), `optimistic_locking` (bool). Stored both on the webform and
  in global `webform.settings` third-party settings.
- `hook_webform_submission_form_alter` injects a hidden disabled draft button; `js/webformautosave.js`
  clicks it after debounce on input/change → standard Webform draft AJAX save.
- Access = core Webform submission/draft-token access; module adds no endpoint (old REST removed in
  `webformautosave_update_8002`). Drafts are not exposed cross-user by this module.
- `hook_ENTITY_TYPE_presave` auto-enables drafts + purge (default 182 days) and submission log when
  autosave/locking is on.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Google reCaptcha — agent index

Attaches Google reCAPTCHA (v2 checkbox / v3 invisible) to forms whose IDs you list. No
per-form code — configure form IDs and keys, and `hook_form_alter` does the rest. Needs
Google reCAPTCHA keys to actually verify. No Drush. No module dependencies (core only).

- **Settings: config object, keys, form-ID matching, v2 vs v3** →
  [configure/settings.md](configure/settings.md)
- **Service API, the attach/validate mechanism, bypass permission & hook** →
  [api/api.md](api/api.md)
- **Per-webform reCAPTCHA** → submodule
  [`../../modules/simple_recaptcha_webform/1.0.x/agent/start.md`](../../modules/simple_recaptcha_webform/1.0.x/agent/start.md)

Quick reference:
- **Config object `simple_recaptcha.config`** (NOTE: the route is `simple_recaptcha.settings`,
  but the config object is `simple_recaptcha.config`). Path `/admin/config/services/simple_recaptcha`.
- Keys: `form_ids` (CSV, `*` wildcard), `recaptcha_type` (`v2`|`v3`), `site_key`/`secret_key`
  (v2), `site_key_v3`/`secret_key_v3` (v3), `v3_score` (int, default 80),
  `recaptcha_use_globally` (bool), `hide_badge_v3` (bool). Default `form_ids`:
  `user_pass,user_register_form`.
- Service `simple_recaptcha.form_manager` (`SimpleReCaptchaFormManager`).
- Permissions: `administer simple_recaptcha`, `bypass simple_recaptcha`.
- Alter hook: `hook_simple_recaptcha_bypass_alter(&$form, &$result)`.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Google reCAPTCHA — Webform integration (agent index)

Submodule of `simple_recaptcha`. Adds ONE Webform handler plugin (`simple_recaptcha`) so Google
reCAPTCHA (v2 checkbox or v3 invisible) can be turned on for an individual webform, instead of the
parent module's global form-ID matching. Depends on `simple_recaptcha` (site/secret keys + the
verification service) and `webform`.

No settings form of its own. `configure` in info.yml points at the PARENT route
`simple_recaptcha.settings` (`/admin/config/services/simple_recaptcha`), where the keys live.
No permissions of its own (it reuses the parent's `bypass simple_recaptcha`), no Drush, no hooks
implemented. It defines no plugin type — it provides one plugin *instance* of Webform's handler type.

- **Add reCAPTCHA to one webform, and all handler settings (v2/v3, score, message, badge)** →
  [configure/webform-handler.md](configure/webform-handler.md)

Key facts:
- Plugin class `Drupal\simple_recaptcha_webform\Plugin\WebformHandler\SimpleRecaptchaWebformHandler`,
  `@WebformHandler(id = "simple_recaptcha", label = "reCAPTCHA", category = "simple_recaptcha",
  cardinality = CARDINALITY_SINGLE, results = RESULTS_IGNORED)`.
- Handler config keys (schema `webform.handler.simple_recaptcha`): `recaptcha_type` (`v2`|`v3`,
  default `v2`), `v3_score` (1–100, default `90`), `v3_error_message` (string), `hide_badge_v3` (bool).
- Stored inside the host webform config `webform.webform.<id>` → `handlers.<key>` with `id: simple_recaptcha`.
- Site/secret keys are NOT on the handler — they come from parent config `simple_recaptcha.config`
  (`site_key`/`secret_key` for v2, `site_key_v3`/`secret_key_v3` for v3): see
  [`../../../../1.0.x/agent/configure/settings.md`](../../../../1.0.x/agent/configure/settings.md).
- Rendering + server-side verification are delegated to the parent service `simple_recaptcha.form_manager`
  (`SimpleReCaptchaFormManager::addReCaptchaCheckbox()` / `addReCaptchaInvisible()`).

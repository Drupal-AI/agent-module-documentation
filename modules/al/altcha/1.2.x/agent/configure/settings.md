<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ALTCHA settings

- **Form route:** `altcha.settings` → `/admin/config/people/captcha/altcha`
  (a tab under the CAPTCHA settings; base route is `captcha_settings`).
- **Permission:** `administer altcha`.
- **Config object:** `altcha.settings` (has schema + `config/install` defaults).

## Integration type (`integration_type`)

`self_hosted` (default) · `sentinel_api` · `saas_api`.

- **self_hosted** — Drupal issues challenges at `/altcha/v1/challenge` and verifies solutions
  locally using an HMAC **secret key** in State `altcha-hmac-key`
  (`SecretManager::generateSecretKey()`, created on install; regenerate via the form's
  *Regenerate secret key* button). `hook_requirements()` errors if the key is missing.
- **sentinel_api** — needs `sentinel_api_url`, `sentinel_api_key`, `sentinel_api_secret`;
  verified by `altcha.sentinel_solution_verification`. `sentinel_fallback_enabled` falls back
  to self-hosted when the API fails.
- **saas_api** (deprecated) — needs `saas_api_key` (must start `key_`/`ckey_`) and
  `saas_api_region` (`eu` → https://eu.altcha.org, `us` → https://us.altcha.org).

## Key settings (`altcha.settings`)

| Key | Meaning |
|---|---|
| `max_number` | Proof-of-work **complexity** (1000–1000000; default fallback 20000). Higher = more work for bots (and clients). |
| `expire` / `delay` | Challenge expiry / artificial delay (seconds). |
| `auto_verification` | `off` \| `onfocus` \| `onload` \| `onsubmit` — when the widget auto-solves. |
| `floating_enabled` | Invisible/**floating** widget mode. |
| `floating_mode` | `auto` \| `top` \| `bottom`; with `floating_anchor` (CSS selector, default `input[name="op"]`) and `floating_offset`. |
| `hide_logo` / `hide_footer` | Hide the ALTCHA branding. |
| `library_override` / `i18n_library_override` | Point the JS at a custom/CDN build (stream wrapper, URL, or path). |
| `i18n_method` + label keys (`verify`, `verifying`, `error`, `footer`, `label`, `aria`, …) | Override widget text per language (see `AltchaSettingsForm::getLabelMap()`). |
| `obfuscate_reveal_text` / `obfuscate_max_number` / `obfuscate_library_override` | Used by the **altcha_obfuscate** submodule. |

Set via Drush:
```bash
drush cset altcha.settings integration_type self_hosted
drush cset altcha.settings max_number 50000
```

The secret key is **not** in config — it is State. Read/generate it in code:
```php
$key = \Drupal::service('altcha.secret_manager')->getSecretKey();      // string|null
\Drupal::service('altcha.secret_manager')->generateSecretKey();        // create/rotate
```

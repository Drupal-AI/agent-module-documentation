<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — Acquia Web Governance settings

Route `acquia_optimize.admin_settings` → `/admin/config/content/acquia-optimize`, gated by
`administer acquia optimize`. Form: `Drupal\acquia_optimize\Form\SettingsForm` (a `ConfigFormBase`
editing `acquia_optimize.settings`).

## Fields (`config/schema/acquia_optimize.settings.yml`)
| Key | Type | Notes |
| --- | --- | --- |
| `api_key` | string | Bearer token. Rendered as a `textarea`, **masked** on display. |
| `api_url` | string | API base URL. Validated: must be a valid URL, HTTPS, host `monsido.com` or `*.monsido.com`; trailing slash trimmed. |
| `accessibility` | string | WCAG target from `Utilities::ACCESSIBILITY_GUIDELINES` (`WCAG2-A`…`WCAG22-AAA`). |
| `debug_mode` | boolean | Enables JS-console debug logging. |

## API key masking (important to understand)
- `buildForm()` shows `maskedApiKey($config->get('api_key'))` — all but the last 4 chars become `*`.
- On submit, if the posted value equals the mask of the stored key (`isApiKeyMasked()`), the stored
  key is kept; otherwise the posted value is saved verbatim (`trim`ed).
- Masking is display-only. The real key is persisted in the `acquia_optimize.settings` config
  object, so it appears in config exports (`drush cex`), the config repo and DB dumps. There is no
  Key-module / env-provider integration. For a secret-free config export, put the token in an
  environment variable and override `acquia_optimize.settings:api_key` from `settings.php`.

## Connection validation on save
`validateForm()` → `checkApiConnection()` builds an `ApiClient` with the entered credentials and
calls `validateApiConnection()` (`GET {api_url}/account`). Any error string in the response blocks
the save with a form error, so bad credentials cannot be stored. On success the module replaces the
default "saved" message with "settings saved and API connection established successfully."

## URL allowlist (SSRF-relevant)
`validateApiUrlElement()` rejects non-HTTPS URLs and any host that is not `monsido.com` or a
`.monsido.com` subdomain. This is the only place the allowlist is enforced — the JSON settings
endpoint `POST /acquia-optimize/api/settings` (`AcquiaOptimizeController::updateSettings`) writes
`api_url`/`api_key` with **no such validation**, but it is gated by `administer acquia optimize`.

## Alternative: JSON settings endpoints (React/Canvas)
- `GET /acquia-optimize/api/settings` (`scan acquia optimize`) — returns settings with `api_key`
  replaced by the literal `[API key set]` (never the real key) plus a CSRF token.
- `POST /acquia-optimize/api/settings` (`administer acquia optimize`) — updates `api_key`,
  `api_url`, `accessibility` from the JSON body.
- `POST /acquia-optimize/api/validate-connection` (`administer acquia optimize`) — validates
  supplied credentials without saving.

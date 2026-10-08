<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BotBuster — install, configuration, routes

## Install / enable

`drush en botbuster`. **Mandatory:** a private file system. `botbuster_requirements()`
(`botbuster.install`, `#[LegacyRequirementsHook]`) returns `REQUIREMENT_ERROR` at both `install`
and `runtime` phases when `Settings::get('file_private_path')` is empty — the challenge files must
live under `private://`. Add to `settings.php`:

```php
$settings['file_private_path'] = '/path/to/private/files';
```

On uninstall, `botbuster_uninstall()` calls `ChallengeFileGenerator::removeChallengeFile()` to delete
`private://botbuster/challenge.html` + `botbuster.json` (and the dir if empty).

## Route / access

- `botbuster.settings` → `/admin/config/system/botbuster`, `_form: \Drupal\botbuster\Form\SecuritySettingsForm`,
  requirement `_permission: 'administer site configuration'` (`botbuster.routing.yml`).
- Menu link `botbuster.settings` under `system.admin_config_system`, weight 10 (`botbuster.links.menu.yml`).
- `configure: botbuster.settings` in `botbuster.info.yml`. **No** `*.permissions.yml` — the module
  defines no permissions of its own.

## Config object `botbuster.settings`

Schema in `config/schema/botbuster.schema.yml`; install defaults in `config/install/botbuster.settings.yml`.
Two mappings:

**`ddos_protection`**
- `enabled` (boolean, default `true`) — master on/off.
- `protected_paths` (string, default `''`) — newline-separated wildcard patterns. `*` → `.*`.
  Examples: `/search`, `/search/*`, `/api/*/results`, `*facet*`. Matched against **both**
  `getPathInfo()` and `getRequestUri()` (so query strings can match), anchored `^…$`.
- `token_lifetime` (integer seconds, default `86400`) — form offers 3600 / 21600 / 43200 / 86400 / 604800.
- `cookie_name` (string, default `botbuster_token`) — the verification cookie; `SecuritySettingsForm::validateForm()`
  requires it and enforces the RFC cookie-name charset `^[A-Za-z0-9!#$%&'*+\-.^_`|~]+$`.

**`challenge_page`** (all rendered into the 503 page template)
- `title`, `heading`, `loading_text`, `error_title` (type `label`); `description`, `error_text` (type `text`).
  Defaults are the "Browser Verification" strings in `config/install/botbuster.settings.yml`.

## How config reaches runtime

The form (`SecuritySettingsForm::submitForm()`) writes `botbuster.settings`. On `ConfigEvents::SAVE`,
`ConfigSubscriber::onConfigSave()` calls `ChallengeFileGenerator::generateChallengeFile()` +
`generateConfigFile()`. `hook_cache_flush()` (`botbuster.module`) regenerates both on every cache clear.
So editing config directly (`drush cset`) without a save event/cache clear leaves the on-disk files stale —
run `drush cr` to regenerate. The middleware reads only `private://botbuster/botbuster.json`, never the
config object.

## Proxy/CDN warning

`SecuritySettingsForm::getReverseProxyIndicators()` inspects request headers (`Via`, `X-Forwarded-For`,
`X-Varnish`, `CF-Ray`, `Fastly-Client-IP`, `X-Platform-Cluster`), env vars (`PLATFORM_PROJECT`,
`FASTLY_SERVICE_ID`) and `Settings::get('reverse_proxy')` purely to show an operator warning to forward
the token cookie to origin (with a DDEV false-positive note). These headers are **not** used for any
security decision.

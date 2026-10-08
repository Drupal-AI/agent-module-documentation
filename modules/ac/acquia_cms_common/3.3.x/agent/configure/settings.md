<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure acquia_cms_common

There is no umbrella settings page (info.yml declares no `configure:`). Behavior is driven by one config
object plus a tiny HTTPS toggle form.

## Config object `acquia_cms_common.settings`

| Key | Type | Default (config/install) | Used by |
| --- | --- | --- | --- |
| `user_login_redirection` | boolean | `true` | `acquia_cms_common_form_user_login_form_alter()` attaches `RedirectHandler::submitForm` when true, redirecting privileged roles after login (contributors → their moderation dashboard, developers → `cohesion.settings`, user admins → user collection). |
| `starter_kit_name` | string | `no_starter_kit` | `AcmsUtilityService::getStarterKit()`, telemetry, status-report block. One of `acquia_cms_enterprise_low_code`, `acquia_cms_headless`, `acquia_cms_community`, `acquia_cms_existing_site`, `no_starter_kit`. |
| `acquia_cms_https` | boolean | (unset) | `HttpsRedirectSubscriber` — when true, non-localhost HTTP requests are 301/308-redirected to HTTPS. Managed by the form below; **not present in config/schema** (schema-less key). |

Schema (`config/schema/acquia_cms_common.schema.yml`) defines only `user_login_redirection` and
`starter_kit_name` under `acquia_cms_common.settings`.

## HTTPS toggle form

- Route `acquia_cms_common.https_config_form` → path `/admin/config/system/https`, permission `administer site configuration`.
- Menu link `acquia_cms_common.https` ("HTTPS Configuration") under System config.
- Form `Drupal\acquia_cms_common\Form\HttpsRedirectForm` (id `acquia_cms_https_config_form`), a `ConfigFormBase` editing `acquia_cms_common.settings`. Single checkbox `acquia_cms_https` → "Enable enforced HTTPS redirects."

## Set values without the UI

```php
\Drupal::configFactory()->getEditable('acquia_cms_common.settings')
  ->set('acquia_cms_https', TRUE)
  ->set('user_login_redirection', FALSE)
  ->set('starter_kit_name', 'acquia_cms_existing_site')
  ->save();
```

```bash
drush config:set acquia_cms_common.settings acquia_cms_https 1 -y
```

## Reset ACMS config back to shipped defaults

Use the drush command `acms:config-reset` (alias `acr`) to re-import a module's canonical `config/install`
+ `config/optional` — see [../drush/commands.md](../drush/commands.md).

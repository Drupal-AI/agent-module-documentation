# Settings & the render gate (configure)

## Settings form

Route `ignition.settings` → `/admin/config/development/ignition`
(`Drupal\ignition\Form\IgnitionSettingsForm`, `getFormId()` = `ignition_settings`), gated by
`administer site configuration`. Menu link `ignition.settings` under
`system.admin_config_development`. Editable config object: **`ignition.settings`**.

Config keys (schema `config/schema/ignition.schema.yml`, defaults `config/install/ignition.settings.yml`):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `enabled` | boolean | `true` | Master switch. When off, Drupal handles errors even if the module is installed. |
| `dark_mode` | boolean | `false` | Ignition theme: `dark` when true, else `auto` (`IgnitionFactory::getDefaultConfig()`). |
| `store_settings_file` | boolean | `true` | Store per-user display prefs in `~/.ignition.json` (server home dir) instead of user/session data. |
| `open_ai` | boolean | `false` | Enable the OpenAI solution provider. |
| `open_ai_key` | string | `null` | OpenAI API key (shown/required only when `open_ai` is checked; stored plaintext in config). |

The form disables/annotates any key that is overridden (e.g. in `settings.php`) via
`$config->hasOverrides($key)`; overridden values are also unset in `validateForm()` so they are never
written back. If the optional `coi` (Config Override Inspector) module is installed, each element gets
a `#config` hint (`ignition.settings:<key>`, `secret => TRUE`).

Set from Drush/code:

```bash
drush cset ignition.settings enabled 1 -y
drush cset ignition.settings dark_mode 1 -y
```

## When the Ignition page actually renders (the four-part gate)

`src/EventSubscriber/ErrorHandlerSubscriber.php::shouldHandleException()` returns TRUE — and Ignition
takes over the response — **only if all four hold**; otherwise it returns and Drupal's default
handler runs:

1. `$this->account->hasPermission('view ignition error page')` — the current user holds the permission.
2. `ignition.settings.enabled == TRUE`.
3. `system.logging.error_level === ERROR_REPORTING_DISPLAY_VERBOSE` (the constant is `'verbose'`, i.e.
   **"All messages, with backtrace information"** at `/admin/config/development/logging`). A standard
   site defaults `error_level` to `hide`, so this is off until an admin sets it.
4. `error_displayable($error)` is TRUE (core's own error-displayability check).

So to see Ignition on a dev site: enable the module setting, set the logging level to verbose, and
grant `view ignition error page` to the relevant role. To keep it off on production, leave any one of
these unset — the module's README recommends forcing `error_level` to `hide` in `settings.php` for
prod:

```php
if (SITE_IS_PROD) {
  $config['system.logging']['error_level'] = 'hide';
}
```

## Per-user display preferences

The cog menu on the error page (theme/editor) POSTs to `ignition.update_config`
(`/_ignition/update-config`). Where the prefs land depends on config:
`store_settings_file` on → `~/.ignition.json`; else authenticated user → `user.data`
(module `ignition`, name `config`); else → session key `ignition_config`. On the read side
`IgnitionFactory::getUserConfig()` merges the same source over the sitewide defaults. See
[../api/services-and-solutions.md](../api/services-and-solutions.md).

## OpenAI provider

With `open_ai` on and `open_ai_key` set, `OpenAISolutionProvider::canSolve()` becomes true and the
provider asks OpenAI (through `openai-php/client`) to explain the current throwable; responses are
cached in the `open_ai_solution` cache bin via `Cache\SimpleCacheBridge`. Store the key via an
environment variable / Key entity rather than pasting a long-lived secret into the form where
possible. Keep this to local development.

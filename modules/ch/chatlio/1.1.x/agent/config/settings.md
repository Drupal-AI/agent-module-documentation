<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Chatlio — settings, config object & visibility

## Install / enable

`drush en chatlio -y`. No external module or Composer dependencies (info.yml declares none).
On install, `config/install/chatlio.settings.yml` seeds the config object below.
Configure at `/admin/config/services/chatlio` (link under *Configuration → Web services*).

## Route & access

- Route **`chatlio.settings`** (`chatlio.routing.yml`): path `/admin/config/services/chatlio`,
  `_form: \Drupal\chatlio\Form\ChatlioSettings`, requirement
  **`_permission: 'administer site configuration'`**. This is the only route the module defines.
- `info.yml` declares `configure: chatlio.settings`.

## Config object `chatlio.settings`

Schema: `config/schema/chatlio.schema.yml`. Install defaults: `config/install/chatlio.settings.yml`.

| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `chatlio_enable` | boolean | `true` | Master on/off. When false, `render()` returns NULL (nothing injected). |
| `chatlio_enable_admin` | boolean | `false` | If false, widget is suppressed on admin routes (`AdminContext::isAdminRoute()`). |
| `chatlio_mobile` | boolean | `false` | Passed to JS as `disable_mobile`; hides the widget on iPhone/iPad/Android. |
| `chatlio_code` | string | `''` | The Chatlio.com JS embed snippet, pasted verbatim; injected into page markup. |
| `user_identify` | boolean | `false` | When true (and user logged in), adds uid/name/mail/loggedinas to drupalSettings. |
| `show_user_name` | boolean | `false` | When true, `user_name` (token-replaced) is exposed as the identify name. |
| `user_name` | string | `[current-user:name]` | Token string for the identify name. |
| `show_user_email` | boolean | `false` | When true, `user_email` (token-replaced) is exposed as the identify email. |
| `user_email` | string | `[current-user:mail]` | Token string for the identify email. |
| `visibility` | sequence | `{}` | Map of condition-plugin id → plugin config (`condition.plugin.[id]`). |

## Settings form `ChatlioSettings` (`src/Form/ChatlioSettings.php`)

`ConfigFormBase`; form id `chatlio_settings`; editable config `['chatlio.settings']`. Injected
services: `config.factory`, `plugin.manager.condition`, `context.repository`, `language_manager`.
`buildForm()` sets `#tree = TRUE` and assembles three fieldsets:

- **`buildSettingsInterface()`** — checkboxes for `chatlio_enable`, `chatlio_mobile`,
  `chatlio_enable_admin`, and the `chatlio_code` textarea (placeholder `<!-- begin chatlio code -->`).
- **`buildUserInfoInterface()`** — `user_identify`, `show_user_name`, `user_name`,
  `show_user_email`, `user_email`, wired with `#states` so name/email fields appear only when
  identify + the matching show-checkbox are ticked. (Note: `show_user_email`'s checkbox
  `#default_value` reads `show_user_name` — a minor UI default bug, harmless to config.)
- **`buildVisibilityInterface()`** — vertical tabs built from the condition manager, **restricted**
  to an allow-list: `request_path`, `user_role`, `entity_bundle:node`,
  `entity_bundle:taxonomy_term`, plus `language` only when `LanguageManager::isMultilingual()`.
  The comment explains the allow-list avoids `ContextException` from context-dependent conditions
  on pages lacking the required entity. Per-condition tweaks relabel titles and convert the
  `request_path` negate into radios ("Show for the listed pages" / "Hide for the listed pages").

Submit path splits into `submitSettings()`, `submitUserInfo()`, `submitVisibility()` (each writes
`chatlio.settings`). `validateForm()` → `validateVisibility()` casts each condition's `negate` to
bool and delegates to the condition's own validator via `SubformState`. Visibility is saved as
`visibility[$condition_id] = $condition->getConfiguration()`.

## Tokens

`user_name` / `user_email` are run through the `token` service (`Token::replace(..., ['clear' => TRUE])`)
in `ChatlioEmbedRender::__construct()`. Any token available to the global/user context works;
defaults use `[current-user:name]` and `[current-user:mail]`.

## Config export example

```yaml
# chatlio.settings
chatlio_enable: true
chatlio_enable_admin: false
chatlio_mobile: true
chatlio_code: "<script ...chatlio embed...></script>"
user_identify: true
show_user_name: true
user_name: '[current-user:name]'
show_user_email: true
user_email: '[current-user:mail]'
visibility:
  request_path:
    id: request_path
    pages: "/contact\n/support"
    negate: false
    context_mapping: {  }
  user_role:
    id: user_role
    roles: { authenticated: authenticated }
    negate: false
    context_mapping: {  }
```

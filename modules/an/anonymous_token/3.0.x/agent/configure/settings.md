# Configure Anonymous Token

Tiny settings surface: one boolean and one permission.

## Settings form

- Route: `anonymous_token.settings_form` → `/admin/config/system/anonymous-csrf-token`.
- Permission required: `administer anonymous csrf token`.
- Form class: `\Drupal\anonymous_token\Form\SettingsForm` (a `ConfigFormBase`).

## Config

```
anonymous_token.settings:
  force_single_use: false   # boolean, default false (config/install)
```

Schema: `anonymous_token.settings` → `force_single_use` (boolean). When `true`, a successfully
validated token from an anonymous user rotates the session CSRF seed (`stampNew()`), making the
token single-use; see [../api/csrf.md](../api/csrf.md).

Set it with Drush instead of the UI:

```bash
drush config:set anonymous_token.settings force_single_use true -y
```

## Permission

| Permission | Gates |
|---|---|
| `administer anonymous csrf token` | The settings form only. |

There are no other permissions and no Drush commands. The permission is not
`restrict access: true`, but it only toggles this single hardening flag.

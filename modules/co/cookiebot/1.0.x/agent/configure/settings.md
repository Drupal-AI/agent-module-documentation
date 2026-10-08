# Configure Cookiebot

Single config object **`cookiebot.settings`**. UI form `CookiebotForm` at
`/admin/config/cookiebot` (route `cookiebot.admin_settings_form`, permission
`administer cookiebot settings`). The module does nothing until `cookiebot_cbid` is set.

## Settings keys (with shipped defaults)

| Key | Type | Default | Effect |
|---|---|---|---|
| `cookiebot_cbid` | string | `""` | Domain Group ID (CBID), a UUID. Injected as `data-cbid`. **Required** — empty = module inert. |
| `cookiebot_block_cookies` | bool | `true` | Adds `data-blockingmode="auto"` (auto-block cookies until consent). |
| `cookiebot_iab_enabled` | bool | `false` | Adds `data-framework="IAB"`. |
| `cookiebot_drupal_culture` | bool | `false` | Send current Drupal langcode as `data-culture` (else browser autodetect). |
| `cookiebot_disable_async_loading` | bool | `false` | If true, omits `async` on the script tag. |
| `cookiebot_show_declaration` | bool | `false` | Render the full cookie declaration on a node (see theming doc). |
| `cookiebot_show_declaration_node` | string | `""` | Node ID whose page shows the declaration. |
| `exclude_paths` | string | `""` | Newline path patterns to skip (`*` wildcard, `<front>`). Matched against path and alias. |
| `exclude_admin_theme` | bool | `false` | Skip injection on admin routes. |
| `disabled_for_roles` | sequence | *(unset)* | Role IDs for which Cookiebot is not loaded. |
| `message_placeholder_cookieconsent_optout_marketing_show` | bool | `false` | Show placeholder for blocked marketing elements. |
| `message_placeholder_cookieconsent_optout_marketing` | text_format | *(default markup)* | `{value, format}` placeholder message. |

## CBID format

Validated in `CookiebotForm::validateForm()` against
`/^[0-9a-z]{8}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{4}-[0-9a-z]{12}$/` (a lowercase UUID). Invalid
values are rejected; whitespace is trimmed.

## What gets injected

`hook_page_attachments_alter()` prepends to `<head>`:
```html
<script type="text/javascript" id="Cookiebot" src="https://consent.cookiebot.com/uc.js"
  data-cbid="<CBID>" [data-blockingmode="auto"] [async] [data-framework="IAB"] [data-culture="<lang>"]></script>
```
Injection is skipped when the current user has a role in `disabled_for_roles`, the path matches
`exclude_paths`, or `exclude_admin_theme` is on and the route is admin. Output carries cache tags
`cookiebot:cbid` and `cookiebot:iab_enabled`.

## Drush / scripting

```bash
# read
drush cget cookiebot.settings cookiebot_cbid

# set the CBID and enable auto-blocking
drush cset cookiebot.settings cookiebot_cbid "12345678-1234-1234-1234-123456789012" -y
drush cset cookiebot.settings cookiebot_block_cookies 1 -y

# exclude admin + a path
drush cset cookiebot.settings exclude_admin_theme 1 -y
drush cset cookiebot.settings exclude_paths "/blog/*" -y
```

`disabled_for_roles` is a sequence — set it with `php:eval`:
```php
\Drupal::configFactory()->getEditable('cookiebot.settings')
  ->set('disabled_for_roles', ['anonymous'])->save();
```

Saving via the form invalidates cache tags `cookiebot:cbid`, `cookiebot:show_declaration`,
`cookiebot:iab_enabled`.

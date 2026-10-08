# Configure Read Only Mode

No dedicated route: the UI is added to the **core Maintenance mode** form,
`system.site_maintenance_mode` → `/admin/config/development/maintenance` (a "Read Only Mode"
details section). All values persist to the `readonlymode.settings` config object.

## Config keys (`readonlymode.settings`)

| Key | Type | Meaning |
|---|---|---|
| `enabled` | int `0`/`1` | Master switch. When `1`, blocked forms are stripped/rejected. |
| `url` | string | Optional internal redirect path; if set, edit attempts are redirected here instead of showing the warning. Must be internal (validated). |
| `messages.default` | string | Warning shown on a page containing a blocked form (token-replaced). |
| `messages.not_saved` | string | Error shown when a blocked form is submitted (token-replaced). |
| `forms.default.edit` | sequence | Shipped always-submittable form IDs (login, `user_pass`, search, `system_site_maintenance_mode`, `views_exposed_form`, …). |
| `forms.default.view` | sequence | Shipped view-only allow-list (`node_admin_content`, `comment_admin_overview`). |
| `forms.additional.edit` | string | Your extra submittable form IDs, one per line; `*` wildcard allowed (e.g. `webform*`). |
| `forms.additional.view` | string | Your extra view-only form IDs, one per line; `*` allowed. |

## Enable / disable

```bash
drush cset readonlymode.settings enabled 1 -y     # turn ON
drush cset readonlymode.settings enabled 0 -y     # turn OFF
```

## Allow extra forms while locked

`forms.additional.edit` / `forms.additional.view` are **newline-separated strings** (not YAML
sequences). A wildcard `*` becomes a loose regex match, so `webform*` matches every webform.

```bash
drush cset readonlymode.settings forms.additional.edit $'webform*\ncontact_message_feedback_form' -y
```

## How the lock behaves (mechanism)

- `hook_form_alter()` calls `_readonlymode_form_check()`. If read-only is on and the form is not
  allowed (and the user lacks `readonlymode access forms`), the form's children are removed —
  unless a `url` is set, in which case the request is redirected there.
- A `#validate` handler (`readonlymode_check_form_validate`) rejects any blocked submission with
  `messages.not_saved` (covers forms started before the lock was enabled).
- Users with `readonlymode access forms` bypass all of this; users with
  `readonlymode access messages` see the warnings/notices.

## Block

A block plugin `readonlymode_block` ("Read Only Mode") renders the maintenance message (site name
+ notice) when `enabled` is on. Place it via Block layout like any block.

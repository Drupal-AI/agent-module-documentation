# Configure redirects & settings

## Manage individual redirects (UI)

Routes (all `/admin/config/search/redirect/...`):

| Route | Path | Purpose |
|---|---|---|
| `redirect.list` | `/` | List all redirects (`administer redirects`) |
| `redirect.add` | `/add` | Add a redirect |
| `entity.redirect.edit_form` | `/edit/{redirect}` | Edit |
| `entity.redirect.delete_form` | `/delete/{redirect}` | Delete one |
| `entity.redirect.multiple_delete_confirm` | `/delete` | Bulk delete |
| `redirect.settings` | `/settings` | Global settings (`administer redirect settings`) |

A redirect record holds a **source path** (+ optional query), a **destination URL**, an
**HTTP status code**, and a language.

The list at `/admin/config/search/redirect` (empty on a fresh install) with the filter and
"Add redirect" action:
![Redirect list](../../../../../../../screenshots/redirect/1.13.x/redirect-list.png)

The add form (`/add`): **Path** (source, relative to the site root), **To** (destination — a
content autocomplete, internal path, external URL, or `<front>`/`<nolink>`/`<button>`),
**Enabled**, and **Redirect status** (defaults to 301):
![Add URL redirect](../../../../../../../screenshots/redirect/1.13.x/redirect-add-form.png)

## Global settings — `redirect.settings`

Edit at `/admin/config/search/redirect/settings` or via `drush cset redirect.settings <key>`.
Defaults shown:

![Redirect settings form](../../../../../../../screenshots/redirect/1.13.x/redirect-settings.png)

| Key | Default | Meaning |
|---|---|---|
| `auto_redirect` | `true` | Auto-create a redirect when an entity's URL alias changes |
| `default_status_code` | `301` | Status code used for new redirects |
| `passthrough_querystring` | `true` | Keep the incoming query string on redirect |
| `warning` | `false` | Show users a message when they are redirected |
| `ignore_admin_path` | `false` | If false, admin paths are not redirected |
| `access_check` | `false` | Check destination route access before redirecting |
| `route_normalizer_enabled` | `true` | Enforce clean/canonical URLs (trailing slash, alias→canonical) |

Config schema: `config/schema/redirect.schema.yml`. Settings are a config object, so they
export/deploy with `drush config:export`. Changing them invalidates cached redirects via the
`redirect.settings_cache_tag` subscriber.

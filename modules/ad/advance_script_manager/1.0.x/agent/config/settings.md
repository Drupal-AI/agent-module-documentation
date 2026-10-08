<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advance Script Manager — configuration & operation

## Install / enable

`drush en advance_script_manager`. No dependencies beyond core. On install
`hook_install()` calls `advance_script_manager_update_8001()` which adds the `weight` column, so
the `advance_script_manager` table is created (via `hook_schema()` in
`advance_script_manager.install`) with the full column set including `weight`.

## Permission (the only one)

`advance_script_manager.permissions.yml`:

- `advance_script_manager_settings` — `restrict access: TRUE`. Grants the ability to add/edit/
  delete/reorder snippets. **Every** module route requires exactly this permission
  (`advance_script_manager.routing.yml`), so it fully controls who can author injected markup.

## Storage (DB table, not config/entity)

Table `advance_script_manager` (`advance_script_manager.install`), one row per snippet:

| column | meaning |
| --- | --- |
| `id` | serial PK; passed as `?num=` (edit) / `{id}` (delete) |
| `script_name` | admin label shown in the list/order tables |
| `script_code` | raw JS/HTML markup emitted into the page |
| `css_code` | raw CSS/link markup (Header region only) |
| `visibility_section` | `Header` \| `Body` \| `Footer` |
| `pages_settings` | `all` (all except listed) \| `only` (only listed) |
| `visibility_pages` | newline-separated Drupal paths; `<front>` supported |
| `content_type` | comma-joined node-type machine names (collected, stored) |
| `user_roles` | comma-joined role ids (collected, stored) |
| `status` | `1` = Active, `2` = Disabled (default 2) |
| `weight` | ASC order applied at output and in the order form |

Note: only `status`, `visibility_section`, `visibility_pages`/`pages_settings`, and `weight`
actually affect output. The `content_type` and `user_roles` columns are captured by
`ScriptsForm` but are **not** consulted by the render hooks — visibility is path-based only.

## Routes & forms

All under `/admin/config/development/advance-script-manager`, `_admin_route: TRUE`,
`_permission: advance_script_manager_settings`.

- `AdvanceScriptController::build` (base path) — renders `SearchscriptsForm` + `ListscriptsForm`.
- `ScriptsForm` (`/scripts`, `?num={id}` edits) — fields: name, enable radios (Active=1/Disabled=2),
  `script_code`, `css_code`, visibility section select, pages textarea + `all`/`only` radios,
  role checkboxes, content-type checkboxes. `submitForm()` `insert`/`update`s the table (all
  parameterized query builders) then clears plugin caches and redirects to the base route.
- `ListscriptsForm` (`/manage-scripts`) — `tableselect` + bulk `bulk_action_type`
  (activate / disable / move to header|body|footer) via `condition('id', $ids, 'IN')` updates; a
  Delete button redirects to the multi-delete confirm form with `?ids=a|b|c`.
- `SearchscriptsForm` (`/search-form`) — filter by `visibility`/`status`, redirects back with those
  as route params; `ListscriptsForm::getRecords()` applies them as query conditions with a 20-row pager.
- `ScriptsOrderForm` (`/scripts-order-form`) — draggable `#tabledrag` weight editor; `submitForm()`
  writes each row's `weight`.
- `ScriptsFormDelete` (`/…/delete/{id}`) and `ListScriptsFormDeleteMultiple` (`/…/delete_multiple?ids=`)
  — `ConfirmFormBase` subclasses; delete by `id` after confirmation.

Menu link: `advance_script_manager.links.menu.yml` (under `system.admin_config_development`).
Action links (`links.action.yml`): "Add scripts", "Configure order".

## Config objects

`config/install/advance_script_manager.{scripts,listscripts,track}.yml` with matching
`config/schema/advance_script_manager.schema.yml` entries typed `type: ignore`. These are
placeholder config objects (`ScriptsForm` extends `ConfigFormBase` and declares
`advance_script_manager.scripts` editable) but the actual snippet data is the DB table — the
config objects hold no meaningful snippet state.

## Output / render path (`advance_script_manager.module`)

`advance_script_manager_fetch_scripts($section)` selects rows where `status = 1` for the given
`visibility_section`, ordered by `weight ASC`.

- **Header** — `hook_page_attachments_alter()` splits `script_code` on `</script>|</noscript>|</meta>`
  and `css_code` on `</style>|/>`, reconstructs tag name + attributes, and appends
  `#type => html_tag` render elements (value via `Markup::create(htmlspecialchars_decode(...))`)
  to `$attachments['#attached']['html_head']`.
- **Body** — `hook_page_top()` concatenates active Body snippets' `script_code` and emits it as
  `#markup => new FormattableMarkup($html, [])`.
- **Footer** — `hook_page_bottom()` does the same for Footer snippets.

Visibility for each snippet is decided by `advance_script_manager_check_visibility($paths, $pages_settings)`
using `path.current`, `path_alias.manager`, and `path.matcher`; `only` shows on matching/`<front>`
paths, `all` shows everywhere except matching/`<front>` paths. Empty path list → always shown.

## Operating notes

- New snippets default to **Disabled** (`status = 2`); set to Active and confirm the region before
  expecting output.
- After any change the forms call `plugin.cache_clearer`; a full cache rebuild may still be needed
  before injected markup appears.
- Header supports both `script`/`noscript`/`meta` and `style`/`link` markup; Body/Footer emit
  `script_code` only (CSS there is ignored).

# Configure the My Workbench dashboard

## Pages / tabs (from `workbench.routing.yml`)

| Route | Path | Controller method | Permission | Purpose |
|---|---|---|---|---|
| `workbench.content` | `/admin/workbench` | `WorkbenchContentController::content` | `access workbench` | "My Workbench" overview (3 regions) |
| `workbench.my_edited` | `/admin/workbench/content/edited` | `::editedContent` | `access workbench` | "My edits" full list |
| `workbench.all_content` | `/admin/workbench/content/all` | `::allContent` | `access workbench` | "All recent content" full list |
| `workbench.create_content` | `/admin/workbench/create` | `::addPage` | `access workbench` + `_node_add_access` | "Create content" (emulates `node/add`, **not** a View) |
| `workbench.admin` | `/admin/config/workflow/workbench` | `WorkbenchSettingsForm` | `administer workbench` | Settings form (maps Views to regions) |

A "Workbench" toolbar tab (added by `hook_toolbar()`) links to `workbench.content` for anyone
with `access workbench`.

## Regions and the shipped Views

The dashboard is entirely Views-driven. There are **five regions**; each is set to a
`view_id:display_id` string. Defaults (from `config/install/workbench.settings.yml`):

| Region key | Default `view:display` | Where it renders |
|---|---|---|
| `overview_left` | `workbench_current_user:block_1` | Overview left column (35% width) — current user profile |
| `overview_right` | `workbench_edited:block_1` | Overview right column (65%) — your most recent edits |
| `overview_main` | `workbench_recent_content:block_1` | Overview main — recent content |
| `edits_main` | `workbench_edited:embed_1` | "My edits" page body |
| `all_main` | `workbench_recent_content:embed_1` | "All recent content" page body |

Three Views ship in `config/optional/` (tag **Workbench**), each requiring the
`access workbench` permission:

- `workbench_current_user` — "Workbench: Current user" (info about the current user).
- `workbench_edited` — "Workbench: Edits by user" (content edited by the user; displays `block_1`, `embed_1`).
- `workbench_recent_content` — "Workbench: Recent content" (content overview; displays `block_1`, `embed_1`).

## Change which View powers a region

**UI:** go to `/admin/config/workflow/workbench`. Each of the five regions is a `<select>`
listing every View display on the site (`label : display_title`); pick one and save.

**Config / drush:** the mapping lives in the `workbench.settings` config object (config
schema in `config/schema/workbench.schema.yml`, so it exports with `drush config:export`).
Values are colon-joined `view_id:display_id`:

```
drush cset workbench.settings overview_main my_custom_view:block_1
```

To add a **custom tab/region View**: build a normal View with the display you want, then
assign it to one of the five region keys above (UI or `drush cset`). The controller calls
`views_embed_view($view_id, $display_id)` for each region; if the configured View does not
exist the raw render array is used instead. Regions can also be replaced entirely in code —
see [hooks/hooks.md](../hooks/hooks.md). The "Create content" tab is not a View and is not
configurable here (alter it with `hook_workbench_create_alter()`).

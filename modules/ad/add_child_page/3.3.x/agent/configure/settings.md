# Configure Add Child Page

## Settings form

Route `add_child_page.configuration_form` → `/admin/config/content/add-child-page`, permission
`administer content types` (`AddChildPageConfigurationForm`). Config object `add_child_page.settings`
(defaults from `config/install/add_child_page.settings.yml`):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `node_types` | sequence (machine names) | `{}` | Content types that show the feature and pass the access check. |
| `node_types_selector` | bool | `true` | Show a content-type chooser (modal) before creating the child; if false, link straight to `add_child_page.add_child`. |
| `default` | bool | `false` | Use a fixed default content type for the child instead of the parent's type. |
| `default_content` | string | `''` | The default child content type machine name (when `default`). |
| `show_on_node_view` | bool | `false` | Show the "Add Child Page" action on the node view page. |
| `show_on_node_edit` | bool | `true` | Show it on the node edit page. |
| `show_on_node_tab` | bool | `false` | Show it as a primary local task (tab). |
| `show_on_node_form` | bool | `false` | Add an "Add Child Page" button next to Save/Preview on the node form. |
| `show_child_pages_tab` | bool | `true` | Show the "Child Pages" tab/section listing menu children. |

Config schema: `add_child_page.settings` (all keys above).

## Routes

| Route | Path | Access | Purpose |
|---|---|---|---|
| `add_child_page.add_child` | `node/{node}/child` | `access add child page` + `AddChildPage::access` | Redirect to node add with menu parent. |
| `add_child_page.add_child_select` | `node/{node}/child/select` | same | Content-type selector (`AddChildPageSelectForm`), modal. |
| `add_child_page.node_children` | `node/{node}/children` | `access add child page,administer menu` + access | Child-pages overview (`ChildPagesMenuListForm`). |
| `add_child_page.node_children_menu` | `node/{node}/children/{menu}` | same | Child pages for one menu (`ChildPagesForm`). |
| `add_child_page.configuration_form` | `admin/config/content/add-child-page` | `administer content types` | Settings. |

`AddChildPage::access($node)` allows only when the node's bundle is in `node_types` (else forbidden).
Permission `access add child page` (`add_child_page.permissions.yml`) is the base gate for all content
routes.

## How the child is created (`AddChildPage::manage`)

1. Loads the node's menu links (`menu.link.manager` → `loadLinksByRoute('entity.node.canonical', ['node' => id])`).
   If none, errors ("Content is not assigned to any menu"). If several, uses the first and adds a warning.
2. Reads the parent menu link's `menu_name` and entity id (`plid`).
3. Chooses the target type: `default_content` when `default` is on, else the parent's bundle.
4. Redirects to `node.add/{node_type}` with query `plid=<parent uuid>` and `menu=<menu_name>` (removing any
   `destination` first).
5. On the node add form, `add_child_page_form_alter()` matches `node_<type>_form` against the configured
   types, resolves the parent uuid via `_add_child_page_get_plid()`, and pre-sets `menu[enabled]`,
   `menu[link][menu_parent]` (`<menu>:menu_link_content:<uuid>`), and a `weight` after existing siblings.

## Placement hooks

`hook_entity_operation()`, action links (`*.links.action.yml`), local tasks (`*.links.task.yml`), and
`hook_form_node_form_alter()` add the entry points; `hook_menu_local_actions_alter()` /
`hook_local_tasks_alter()` / `hook_menu_local_tasks_alter()` remove or retarget them based on the
`show_on_*` and `node_types_selector` settings, and build the per-menu Child Pages sub-tabs. Entry points
also check `access add child page` before rendering.

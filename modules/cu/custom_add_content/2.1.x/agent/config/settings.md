<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring & operating Custom Add Content Page

## Install & enable

```bash
composer require drupal/custom_add_content   # no composer.json in the package; also installable by download
drush en custom_add_content -y
```

No declared module dependencies. Functionally it needs core **node** (content types) and
**menu_link_content** (menu links) — both in standard installs.

### What install/uninstall do

`custom_add_content_install()` (`custom_add_content.install`):

1. Creates the `menu` config entity **`custom-add-content-page`** (label *"Custom add content page"*).
2. Loads all `NodeType`s and creates one `MenuLinkContent` per type — title = the type's name,
   link = `internal:/node/add/<machine_name>`, `menu_name = custom-add-content-page`, `expanded = TRUE`.
3. `module_set_weight('custom_add_content', 15)` so it runs after node/i18n.

`custom_add_content_uninstall()` deletes the `custom-add-content-page` menu (its links go with it),
restoring the standard `/node/add` page.

## The route override (how /node/add changes)

`Routing\CustomAddContentRouteSubscriber::alterRoutes()` fetches the existing `node.add_page` route and
calls `$route->setDefault('_controller', '…\CustomAddContentController::addPage')`. It changes **only the
controller** — the route's path (`/node/add`) and all access requirements stay exactly as core defines
them. Registered in `custom_add_content.services.yml` with the `event_subscriber` tag.

## The controller

`Controller\CustomAddContentController extends NodeController` (core), `implements ContainerInjectionInterface`.
Injected services (`create()`): `menu.link_tree`, `config.factory` (reads `custom_add_content.config`),
`renderer`. `addPage()`:

- `menu_name = 'custom-add-content-page'`, max depth 5.
- Loads the tree, then `transform()`s it with manipulators
  `menu.default_tree_manipulators:checkAccess` and `…:generateIndexAndSort` — so **each link is
  access-checked** and sorted before render.
- If `custom_add_content_renderer == 0` → `renderer->render($menu)` (core menu markup).
- Else (default `1`) → returns a render array `#theme => 'custom_add_content_page_add'` with
  `#menu_name`, `#items`, and `#attached` library `custom_add_content/custom_add_content`.
- If the menu has no links, renders `<p>Please, make sure custom_add_content_page menu has links.</p>`.

## Configuration form & config object

Route **`custom_add_content.config`** → `path: admin/config/user-interface/custom_node_add`,
`_form: Form\AddContentConfigurationForm`, requirement `_permission: 'administer site configuration'`
(`custom_add_content.routing.yml`). Admin menu link under *system.admin_config_ui*
(`custom_add_content.links.menu.yml`).

`Form\AddContentConfigurationForm extends ConfigFormBase`, `getFormId() = add_content_configuration_form`,
editable config = `custom_add_content.config`. One field:

| Config key | Type | Default | Meaning |
|---|---|---|---|
| `custom_add_content_renderer` | int (select 0/1) | `1` (`config/install/custom_add_content.config.yml`) | `0` = Drupal's core menu renderer; `1` = module's custom Twig renderer. |

Drush equivalent:

```bash
drush cset custom_add_content.config custom_add_content_renderer 0 -y   # switch to core renderer
drush cr
```

There is **no `config/schema/`** in the module, so this object is unschemaed. It only ever holds the
integer chosen in the select, so it saves and loads correctly; strict schema validators may warn.

## Keeping the menu in sync (hooks in .module)

`custom_add_content_form_alter()` attaches submit handlers:

- `node_type_add_form` → appends `custom_add_content_new_node_type_add()`, which creates a
  `MenuLinkContent` (`internal:/node/add/<type>`, `expanded = TRUE`) in `custom-add-content-page`.
- `node_type_delete_form` → prepends `custom_add_content_new_node_type_rem()`, which reads the current
  path, takes the type machine name (`explode('/', path)[5]`), loads the matching `menu_link_content`
  by `link__uri` and deletes it.

Both handlers wrap their work in try/catch and log failures via `\Drupal::logger('custom_add_content')`.
Manual menu edits (reorder, rename, hide, nest, add headings) are done at **Structure → Menus →
Custom add content page**.

## Theming

`hook_theme()` registers `custom_add_content_page_add` with variables `menu_name`, `items`. The Twig
template `templates/custom-add-content-page-add.html.twig` renders the tree with a recursive macro,
wrapping the top level in `<ul class="admin-list">` and each item as `{{ link(item.title, item.url) }}`
(link text is autoescaped by Twig; URLs come from the access-checked menu tree). Copy the template into
your theme to override it. The attached library `custom_add_content/custom_add_content` loads
`libraries/custom_add_content.css` (styles `.admin-list li span`).

## Recommended companion modules (optional)

- **special_menu_items** — unlinkable / separator entries in the menu.
- **menu_item_visibility** — show/hide individual links per role/condition.

# The `AdminToolbarContent` plugin type

Everything this module adds to the toolbar is produced by `AdminToolbarContent` plugins — one per
content area. The module ships six; other modules can add their own.

- Discovery: annotation `@AdminToolbarContentPlugin` (`src/Annotation/AdminToolbarContentPlugin.php`),
  namespace `Plugin/AdminToolbarContent`.
- Manager service: `admin_toolbar_content.manager` =
  `Drupal\admin_toolbar_content\AdminToolbarContentPluginManager` (alter hook
  `admin_toolbar_content_plugins_info`, cache bin key `admin_toolbar_content_plugins`).
- Interface `AdminToolbarContentPluginInterface`; base class `AdminToolbarContentPluginBase`
  (`ContainerFactoryPlugin`, injects language manager, current user, entity type manager, route
  provider, module handler, config factory, entity repository).

## Built-in plugins

| id | Class | `entity_type` | Adds to the toolbar |
|---|---|---|---|
| `content` | `AdminToolbarContentContentPlugin` | `node_type` | Rebuilds the core **Content** menu (`system.admin_content`): a child per content type (filtered listing), an **Add new** link, and a per-type **Recent items** list + **More**. Can hide non-content items and hide types by view/permission. |
| `categories` | `AdminToolbarContentCategoriesPlugin` | `taxonomy_vocabulary` | New **Categories** root (`entity.taxonomy_vocabulary.collection`); each vocabulary links to its term overview with an **Add new** term link. Repoints the tools module's vocabulary overview link to the edit form. |
| `media` | `AdminToolbarContentMediaPlugin` | `media_type` | New **Media** root (Media Library `view.media_library.page` or `view.media.media_page_list`), a **Files** link (`view.files.page_1`), a child per media type + **Add**. |
| `menus` | `AdminToolbarContentMenusPlugin` | `menu` | New **Menus** root (`entity.menu.collection`); a child per menu (edit form) + **Add**. |
| `webform` | `AdminToolbarContentWebformsPlugin` | `webform` | New **Webform submissions** root (`entity.webform_submission.collection`); each webform links to its results. |
| `drupal` | `AdminToolbarContentDrupalMenuPlugin` | — | Adds **My account** (`user.page`) and/or **Edit my account** (`entity.user.edit_form`) under the Drupal icon (`admin_toolbar_tools.help`), per `account_links`. |

## How the menu is built

1. `admin_toolbar_content.links.menu.yml` declares one static link plus the deriver
   `admin_toolbar_content.menu_links` (`Plugin\Derivative\AdminToolbarContentMenuLinks`).
2. The deriver instantiates every **enabled** plugin and calls `initialize()` then
   `createMenuLinkItems()`; each plugin appends link definitions via the base helpers
   `createRootLink()`, `createCollectionLinks()`, `createItemLinks()`, `createItemAddLinks()`.
3. `hook_menu_links_discovered_alter` → `AdminToolbarContentPluginManager::menuLinksDiscoveredAlter()`
   lets each plugin `alterDiscoveredMenuLinks()` (e.g. `content` removes the stock
   `admin_toolbar_tools` "add content" links it replaces; `media` removes duplicated media links).
4. `hook_preprocess_menu` (admin menu only) → `preprocessMenu()` → each plugin's `filterMenuItem()`
   drops empty collections and, for `content`, hides content-type items per
   `hide_content_type_items` and prunes empty "Recent items"/"More" placeholders.
5. `hook_preprocess_menu_local_action` rewrites the generic "Add content"/"Add media" button on
   `admin/content` (and media add pages) to "Add <type>" for the current `?type=`, and forbids it
   when `Url::access()` fails. `hook_preprocess_block` appends the type label to the page title.
6. `hook_element_info_alter` registers `AlternativeContentView::preRender`: when a
   `content_<type>` view exists it is rendered in place of the core `content` view, giving each
   content type custom exposed filters.

### Rebuilds
`hook_entity_insert/update/delete` → `menuLinkRebuild($entity)`. A plugin decides via
`needsMenuLinkRebuild()` whether that entity change requires a menu rebuild (the `content` plugin
rebuilds on any node change when recent items are on; `menus` on any `menu` change). Rebuilds are
skipped for `paragraph` entities and during maintenance mode.

## Recent-items behavior (the `content` plugin)

- At build time `createItemRecentContentEditLinks()` queries nodes of the type with
  `accessCheck(FALSE)` **only** to decide whether the list and a "More" link are worth creating; it
  then emits `number_of_items` *placeholder* links (entity id `0`) of class
  `Plugin\Menu\RecentMenuLinkEntity`. It does **not** bake specific node links into the shared menu.
- At render time each placeholder resolves per viewer: `RecentMenuLinkEntity::create()` runs the
  same query **with** `accessCheck()` (default on) and `range(n, 1)` to fetch the n-th node *that
  user may see*, and adds the `user` cache context. A viewer therefore only ever sees edit/view
  links for nodes their account can access; placeholders with no resolvable node are pruned in
  `filterMenuItem()`. The `link` setting selects the target route
  (`entity.node.edit_form` / `entity.node.canonical` / `layout_builder.overrides.node.view`).

## Write your own plugin

Add `src/Plugin/AdminToolbarContent/MyPlugin.php` in your module, extend
`AdminToolbarContentPluginBase`, annotate it, and implement `createMenuLinkItems()`:

```php
/**
 * @AdminToolbarContentPlugin(
 *   id = "my_things",
 *   name = @Translation("My things"),
 *   description = @Translation("Adds a 'My things' menu."),
 *   entity_type = "my_thing_type"
 * )
 */
class MyPlugin extends AdminToolbarContentPluginBase {
  public function createMenuLinkItems(): void {
    $this->createRootLink($this->t('My things'), 'entity.my_thing.collection', [], -4);
    $this->createCollectionLinks('entity.my_thing.collection');
    $this->createItemLinks('entity.my_thing.collection', 'type');
    $this->createItemAddLinks('entity.my_thing.add_form');
  }
}
```

Override `alterDiscoveredMenuLinks()` to remove links you are replacing, `needsMenuLinkRebuild()` to
control rebuild triggers, `buildConfigForm()` to add fields to the settings tab, and
`filterMenuItem()` to hide items at render. Enable the plugin under `plugins.my_things.enabled`.
The `entity_type` annotation drives the default `getItems()` (`loadMultiple()`) and makes the plugin
self-disable when that entity type is absent.

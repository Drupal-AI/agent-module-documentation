<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The menu_items LinkProvider plugin

This submodule contributes a **JSON:API Hypermedia** LinkProvider (it does *not* define a new plugin
type — `jsonapi_hypermedia` owns the `@JsonapiHypermediaLinkProvider` plugin type).

## The plugin

`Drupal\jsonapi_menu_items_hypermedia\Plugin\jsonapi_hypermedia\LinkProvider\MenuItemsLinkProvider`

```
@JsonapiHypermediaLinkProvider(
  id = "jsonapi_menu_items.top_level.menu_items",
  deriver = "…\Plugin\Derivative\MenuItemsLinkProviderDeriver",
  link_relation_type = "menu_items",
)
```

`getLink($context)` (context is the JSON:API root `JsonApiDocumentTopLevel`) returns an
`AccessRestrictedLink::createLink()` that is:

- **access:** `AccessResult::allowed()` (always shown),
- **url:** `Url::fromRoute('jsonapi_menu_items.menu', ['menu' => $pluginDefinition['link_context']['menu_name']])`
  — i.e. the parent module's menu-items endpoint for that menu,
- **relation type:** `menu_items`.

## The deriver (one plugin per menu)

`MenuItemsLinkProviderDeriver` loads every `menu` entity (`entity_type.manager` → `menu` storage) and
creates a derivative for each:

```php
$this->derivatives[$menu] = array_merge($base_plugin_definition, [
  'link_key' => "menu_items--{$menu}",
  'link_context' => [
    'top_level_object' => 'entrypoint',
    'menu_name' => $menu,
  ],
]);
```

So for menus `main`, `admin`, `footer`, … the `/jsonapi` root document gains links keyed
`menu_items--main`, `menu_items--admin`, `menu_items--footer`, each pointing to
`/%jsonapi%/menu_items/<menu>`. Adding a new menu automatically yields a new link (derivatives are
rebuilt from menu storage; clear caches after adding a menu).

## Requirements & install

Needs both `jsonapi_menu_items` and `jsonapi_hypermedia` enabled. The parent module's
`jsonapi_menu_items_update_8001()` auto-installs this submodule when `jsonapi_hypermedia` is present.
There is nothing to configure — enabling the module is enough for the links to appear at `/jsonapi`.

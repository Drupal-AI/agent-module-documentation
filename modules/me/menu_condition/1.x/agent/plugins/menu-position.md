# The `menu_position` condition plugin

`src/Plugin/Condition/MenuPosition.php` — a `@Condition(id = "menu_position", label = "Menu
position")` extending `ConditionPluginBase`. This is a **plugin instance** of core's Condition
plugin type; the module does **not** define a new plugin type of its own.

## Configuration value

One key, `menu_parent`, a string:

```
"<menu_name>:<link_plugin_id>"   e.g. "main:standard.front_page"
"<menu_name>:"                    a whole menu selected (empty link id)
""                                nothing selected
```

The config form (`buildConfigurationForm`) renders a single "Menu parent" select built from
`menu.parent_form_selector` (every menu + link), prefixed with a `- None -` option. Description:
"Show the block on this menu item and all its children."

## Evaluation logic (`evaluate()`)

1. Empty `menu_parent` → returns **TRUE** (no restriction).
2. Splits into `[$menu_name, $link_plugin_id]`.
3. Gets the active trail: `menu.active_trail`->`getActiveTrailIds($menu_name)`.
4. If a link id is set → TRUE when that id is in the active trail (so: the selected item **and
   all its descendants**).
5. If only a menu is set → TRUE when any item of that menu is in the trail
   (`array_filter($active_trail_ids)`).

`summary()` returns "The menu item @title is either active or is in the active trail." (specific
link) or "The active menu item is in the @menu menu." (whole menu).

## Where the value lives (block visibility)

A block placement stores the condition under its plugin id:

```yaml
# block.block.<id>
visibility:
  menu_position:
    id: menu_position
    menu_parent: 'main:'      # or 'main:standard.front_page'
    negate: false
    context_mapping: {}
```

Set it via the block UI (*Structure → Block layout → Configure block → Visibility → Menu
position*) or in config/PHP by writing that `visibility.menu_position` array. Read back:
`drush cget block.block.<id> visibility.menu_position`.

## Cacheability (handled for you)

- `getCacheContexts()` adds `route.menu_active_trails:<menu_name>`.
- `getCacheTags()` adds `config:system.menu.<menu_name>`.

So blocks using the condition vary correctly per active trail without extra work.

## Programmatic use

Being a normal condition, you can instantiate it via `plugin.manager.condition`:

```php
$condition = \Drupal::service('plugin.manager.condition')
  ->createInstance('menu_position', ['menu_parent' => 'main:']);
$show = $condition->execute();   // respects negate
```

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Menu Position rules & settings

## Routes / UI

| Route | Path | Permission | What |
|---|---|---|---|
| `entity.menu_position_rule.order_form` (**`configure`**) | `/admin/structure/menu-position` | `administer menu positions` | Rule list + tabledrag ordering + enable checkboxes |
| `entity.menu_position_rule.add_form` | `/admin/structure/menu-position/add` | `administer menu positions` | Add rule |
| `entity.menu_position_rule.edit_form` | `/admin/structure/menu-position/{menu_position_rule}` | `administer menu positions` | Edit rule |
| `entity.menu_position_rule.delete_form` | `/admin/structure/menu-position/{menu_position_rule}/delete` | `administer menu positions` | Delete rule |
| `menu_position.settings` | `/admin/structure/menu-position/settings` | `administer site configuration` | The one global setting |

Admin menu: *Structure → Menu position rules* (+ a *Settings* child).

## The global setting

```yaml
# menu_position.settings
link_display: parent   # 'parent' | 'child' | 'none'
```

| Value | Effect when a rule matches |
|---|---|
| `parent` (default) | The rule's **parent menu item** is marked active (highlighted, and it drives breadcrumbs). |
| `child` | The `menu_position_link:<rule_id>` menu link is **inserted into the tree** under the parent and shows the current page's title. |
| `none` | No menu item is marked active. |

```bash
drush config:get menu_position.settings link_display
drush config:set menu_position.settings link_display child -y
```

Changing it needs a router/menu-link rebuild (`drush cr`) because the derived links' `enabled`
flag is computed from it.

## The rule config entity

`menu_position.menu_position_rule.<id>` — `config_export`:
`id, label, enabled, conditions, menu_name, parent, menu_link, weight`.

```yaml
# drush config:get menu_position.menu_position_rule.articles_news
id: articles_news
label: 'Articles under News'
menu_name: main               # the menu the rule targets
parent: standard.front_page   # the PARENT menu link plugin id (no menu prefix here)
menu_link: 'menu_position_link:articles_news'   # derived link for this rule
enabled: true
weight: 0
conditions:
  'entity_bundle:node':
    id: 'entity_bundle:node'
    negate: false
    context_mapping:
      node: '@node.node_route_context:node'
    bundles:
      article: article
```

Notes:

- In the **form**, "Parent menu item" is one select whose value is `"<menu_name>:<parent_link_id>"`;
  `MenuPositionRuleForm::submitForm()` splits it into the separate `menu_name` and `parent`
  values. Selecting a bare menu (empty parent) is rejected by validation.
- `menu_link` is always `menu_position_link:<rule id>`; the form sets it on first save and then
  calls `$menu_link_manager->rebuild()` so the deriver produces the link.
- **A rule with no conditions always matches.**

## Conditions are core Condition plugins

There is no menu-position condition plugin type. The rule form lists everything from
`plugin.manager.condition` that is satisfiable by the available contexts, so you get core's
`entity_bundle:node` (relabelled "Content types"), `request_path` ("Pages", with a
show/hide radio for `negate`), `user_role` ("Roles"), `current_theme`, `language`, plus any
condition plugin a contrib module adds. Each condition's configuration is stored verbatim
under `conditions.<plugin_id>`.

## Create a rule programmatically

```php
use Drupal\menu_position\Entity\MenuPositionRule;

MenuPositionRule::create([
  'id' => 'articles_news',
  'label' => 'Articles under News',
  'enabled' => TRUE,
  'menu_name' => 'main',
  'parent' => 'standard.front_page',
  'menu_link' => 'menu_position_link:articles_news',
  'weight' => 0,
  'conditions' => [
    'entity_bundle:node' => [
      'id' => 'entity_bundle:node',
      'negate' => FALSE,
      'context_mapping' => ['node' => '@node.node_route_context:node'],
      'bundles' => ['article' => 'article'],
    ],
  ],
])->save();

// Let the deriver build menu_position_link:articles_news.
\Drupal::service('plugin.manager.menu.link')->rebuild();
```

A `request_path` rule instead of a bundle rule:

```php
'conditions' => [
  'request_path' => ['id' => 'request_path', 'negate' => FALSE, 'pages' => "/news\n/news/*"],
],
```

Find valid `parent` ids with:

```bash
drush php:eval '
  foreach (\Drupal::service("plugin.manager.menu.link")->loadLinksByRoute("<front>") as $id => $l) { print $id . "\n"; }'
# or list a whole menu:
drush php:eval '
  foreach (\Drupal::service("plugin.manager.menu.link")->getDefinitions() as $id => $d) {
    if (($d["menu_name"] ?? "") === "main") { print $id . " => " . (string) $d["title"] . "\n"; }
  }'
```

## Ordering, enabling, deleting

- Order = the integer `weight`; the list form saves `enabled` + `weight` per rule and rebuilds
  the router. Lower weight is evaluated first, and **the first active rule wins for a menu**.
- `MenuPositionRule::preDelete()` removes the derived menu link definition before deleting.

```bash
drush config:delete menu_position.menu_position_rule.articles_news   # or delete the entity
```

## Update hooks

`menu_position_update_10001()` renames legacy `node_type` conditions to `entity_bundle:node`
inside every stored rule.

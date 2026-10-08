<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How Menu Position actually places a page (and how to extend it)

## The decorator

```yaml
# menu_position.services.yml
menu_position.menu.active_trail:
  class: Drupal\menu_position\Menu\MenuPositionActiveTrail
  public: false
  decorates: menu.active_trail
  decoration_priority: 9
  arguments: ['@menu_position.menu.active_trail.inner', '@plugin.manager.menu.link',
              '@current_route_match', '@cache.menu', '@lock', '@entity_type.manager', '@config.factory']
  tags: [{ name: needs_destruction }]
```

`MenuPositionActiveTrail extends CacheCollector implements MenuActiveTrailInterface`. It only
overrides `getActiveLink($menu_name)`:

1. Query `menu_position_rule` storage, filtered by `menu_name` when one is given, sorted by `weight`.
2. For each rule call `MenuPositionRule::isActive()` — `FALSE` if `enabled` is off, otherwise every
   condition must `execute()` to `TRUE`. Context-aware conditions get their contexts from
   `context.repository`; a **required** context that cannot be resolved makes the rule inactive.
   A rule with **no** conditions is active.
3. The first active rule decides, according to `menu_position.settings:link_display`:
   - `child` → the rule's own `menu_position_link:<id>` link is the active link;
   - `parent` → `menuLinkManager->createInstance($menu_link->getParent())` is the active link;
   - `none` → `NULL`.
4. If no rule is active it delegates to the decorated core service (`$this->inner->getActiveLink()`).

`getActiveTrailIds()` then walks `getParentIds()` of that link, so **breadcrumbs, main/secondary
theme links and every menu block** follow automatically.

Caching: `getCid()` is `active-trail:route:<route>:route_parameters:<serialized params>` in the
`cache.menu` bin, plus a static per-request cache inside `getActiveLink()`. Rebuild caches after
changing rules or `link_display`.

## The derived menu link

- `menu_position.links.menu.yml` declares the base plugin `menu_position_link` with
  `deriver: \Drupal\menu_position\Plugin\Derivative\MenuPositionLink` and `route_name: '<current>'`.
- The deriver emits one derivative per rule, keyed by the rule id, with `menu_name`/`parent` from
  the rule, `metadata.entity_id = <rule id>` and
  `enabled = (link_display === 'child')`.
- `Drupal\menu_position\Plugin\Menu\MenuPositionLink extends MenuLinkBase`:
  - `getTitle()` returns the **rule label** on admin routes and the **current page title**
    (via `title_resolver`) elsewhere;
  - `isEnabled()` is `TRUE` only when `link_display === 'child'` **and** the rule is currently active;
  - `$overrideAllowed = ['parent' => 1, 'weight' => 1]` — only those two can be overridden;
  - `getEditRoute()` points at the rule entity, and `deleteLink()` is a no-op.
- `menu_position_form_menu_edit_form_alter()` disables (and force-checks) the *Enabled* checkbox
  for these links on the core menu edit form so they cannot be switched off there.

## Extending it

There is **no menu-position plugin type and no `menu_position.api.php` in this release** (the
README mentions one, but the file is not shipped, and the
`plugin.manager.menu_position_condition_plugin.processor` service in `menu_position.services.yml`
points at a class that does not exist — do not use it).

To add new matching logic, write a **core Condition plugin** and it appears on the rule form
automatically:

```php
// src/Plugin/Condition/MyCondition.php
#[Condition(
  id: 'my_condition',
  label: new TranslatableMarkup('My condition'),
  context_definitions: [ 'node' => new ContextDefinition('entity:node', label: new TranslatableMarkup('Node'), required: FALSE) ]
)]
class MyCondition extends ConditionPluginBase { /* buildConfigurationForm(), evaluate(), summary() */ }
```

The rule form lists everything returned by
`plugin.manager.condition::getDefinitionsForContexts($gathered_contexts)`, stores the plugin's
`getConfiguration()` under `conditions.<plugin_id>`, and `MenuPositionRule` hydrates them through a
`ConditionPluginCollection` (`getPluginCollections()` → `['conditions' => …]`).

To change placement behaviour itself, decorate `menu.active_trail` again with a lower
`decoration_priority` than 9, or subclass `MenuPositionActiveTrail`.

## Useful checks

```bash
# which rules exist, in evaluation order
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("menu_position_rule");
  foreach ($s->loadMultiple($s->getQuery()->sort("weight")->accessCheck(FALSE)->execute()) as $r) {
    printf("%s w=%s enabled=%s menu=%s parent=%s conditions=%s\n",
      $r->id(), $r->getWeight(), var_export($r->getEnabled(), TRUE), $r->getMenuName(), $r->getParent(),
      implode(",", array_keys($r->get("conditions"))));
  }'

# did the deriver build the link?
drush php:eval 'var_dump(\Drupal::service("plugin.manager.menu.link")->hasDefinition("menu_position_link:articles_news"));'
```

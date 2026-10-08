<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views Condition (views_condition) — agent index

One core-**condition plugin** that matches based on whether the current page is a view page (and
optionally which view + display). No config of its own, no permissions, no schema, no Drush, no
services. Depends on core `views`. Core: `^9.4 || ^10 || ^11`. Package: `Views`.

- Plugin id `views_condition`, class
  `Drupal\views_condition\Plugin\Condition\ViewsCondition` (extends core
  `ConditionPluginBase`). It is a **consumer** of core's Condition plugin type, not a new plugin
  type — so it works in block visibility, Layout Builder section visibility, the Context module,
  and any code that evaluates conditions.
- Evaluation is route-based and does **not** run or query any view (see security note below).

## What you'd do → where

- **Configure it on a block / understand the three modes, the stored config shape, and the
  evaluate() logic; write a view display it can target** →
  [plugins/views_condition.md](plugins/views_condition.md)

## Key facts (real machine names)

- Condition plugin: `@Condition(id = "views_condition", label = "Views")` — `ViewsCondition`
  implements `ConditionInterface, ContainerFactoryPluginInterface`; injects the **`view`
  entity storage** (`entity_type.manager`→`getStorage('view')`) and **`current_route_match`**.
- Three modes (`application` config key): `''` (Not Restricted → always TRUE), `all_pages`
  (All View Pages), `specific_views` (Specific View Pages, uses the `views` config map).
- Reads route parameters `view_id` / `display_id` (set by Views on its page-display routes).
- `calculateDependencies()` adds `module: views` plus a `config: views.view.{id}` dep per
  selected view.
- Library `views_condition/views_condition` (`js/views_condition.js`) — adds a summary to the
  block-settings vertical tab; no runtime effect.
- Legacy `view_pages` boolean config is migrated to `application` in the constructor.
- No `configure` route; not configured on its own — configured wherever a condition is placed.

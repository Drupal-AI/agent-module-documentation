<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings & the enhanced Usage tab

## Install / enable

```bash
composer require drupal/entity_usage_plus
drush en entity_usage_plus -y
```

Pulls in `drupal/entity_usage ~2.0`. If Entity Usage was not already set up, configure its
tracked source/target entity types and run its **bulk update** first — the unreferenced filter and
the usage tab are only as accurate as the `entity_usage` table.

## Settings form

- Route: **`entity_usage_plus.settings`** → `/admin/config/entity-usage/settings/entity-usage-plus`
  (`entity_usage_plus.routing.yml`), title *"Entity Usage Settings"*, permission
  **`administer entity usage`** (Entity Usage's own permission; the module defines none).
- Form class: `EntityUsagePlusSettingsForm` (`ConfigFormBase` +
  `RedundantEditableConfigNamesTrait`), form id `entity_usage_plus_settings`.
- Appears as a local task tab **"Entity Usage Plus"** under the Entity Usage settings
  (`entity_usage_plus.links.task.yml`, `base_route: entity_usage.settings.form`, weight 15).

One field:

- **`override_tab_display`** (checkbox, *"Override entity usage tab display"*) — written via
  `#config_target` to config object `entity_usage_plus.settings`. Its description warns:
  *"you must clear the cache for changes to take effect."*

Config object **`entity_usage_plus.settings`**:
- Install default (`config/install/entity_usage_plus.settings.yml`): `override_tab_display: false`.
- Schema (`config/schema/entity_usage_plus.schema.yml`): `override_tab_display` boolean.

Drush equivalent:

```bash
drush config:set entity_usage_plus.settings override_tab_display true -y
drush cr
```

![Entity Usage Plus settings form](../../../../../../../screenshots/entity_usage_plus/1.1.x/settings-form.png)

## How the tab override works

`RouteSubscriber` (`src/Routing/RouteSubscriber.php`, service
`entity_usage_plus.route_subscriber`) reads `override_tab_display`. When TRUE, in
`alterRoutes()` it iterates every entity type and, for each existing route
`entity.{type}.entity_usage`, rewrites only its `_controller` to
`LocalTaskUsagePlusController::listUsageLocalTask`. Route **access requirements are left
untouched** (still Entity Usage's). It subscribes to `RoutingEvents::ALTER` at priority **98** so
it runs after Entity Usage's route subscriber (routes must already exist). A **cache rebuild** is
required because route alteration is cached.

`LocalTaskUsagePlusController` extends Entity Usage's `LocalTaskUsageController`. Compared to the
base usage table it:

- Adds a **"Relation"** column and, per row, a relation label: `Parent`, `Current`, or `-- Child`.
- Lists not just parents (`entityUsage->listSources()`) but also **children** of the current
  revision (`entityUsage->listTargets($entity, $revisionId)`); for `paragraph` and `block_content`
  children it recurses to **grandchildren**, flattened with a `"{parent type}: {bundle} > {field}"`
  label.
- Drops the trailing **"Used in"** column when every row only references the default revision.
- Renders through theme hook **`entity_usage_plus_usage_table`**
  (`templates/entity-usage-plus-usage-table.html.twig`, `base hook: table`) — Twig auto-escapes all
  cell content.
- Special-cases **media**: `getSourceEntityLink()` links a media row to its **edit form** (`rel =
  edit-form`) when the user has `edit` access, else plain label.

### Access behavior (important)

Every displayed label/link is access-checked in `getSourceEntityLink()`:
- label shown only if `$entity->access('view label')`, otherwise the literal
  **"- Restricted access -"**;
- a link is produced only if `access('view')` (or, for media, `access('edit')`), otherwise the
  unlinked label is returned;
- block_content links resolve to the host entity via `entityUsage->listSources()`; paragraphs
  resolve to their parent.

So the tab does not expose titles or URLs of entities the current user cannot view; it only adds
child/grandchild rows on top of Entity Usage's existing (already access-gated) parent listing.

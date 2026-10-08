<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Contentish Config (contentishconfig) — agent index

Flags individual **config entities** as "contentish" (site-specific) so they are excluded from
Drupal **config-sync** import/export. No package, **no runtime dependencies** (relies on core's
config-sync transform events), no `require` in composer.json (only `require-dev`). Core
`^8.8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. This is the **2.0.x development branch**
(info.yml carries no `version:` line).

- **The event subscriber, the form checkbox, the `_content_` default, and how ignore actually works** →
  [api/mechanism.md](api/mechanism.md)

## What it actually is (from source)

- One service: `contentishconfig.subscriber` =
  `Drupal\contentishconfig\ContentishConfigTransformationEventSubscriber` (`src/`), tagged
  `event_subscriber`, constructed with `@config.storage` (active storage) and `@entity_type.manager`.
  It subscribes to core **`config.transform.export`** (priority 500) and **`config.transform.import`**
  (priority -500).
- `contentishconfig.module`: `hook_form_alter` adds a **third-party settings → contentishconfig →
  Contentish** checkbox to every config-entity form (except delete forms), plus an
  `#entity_builders` callback `contentishconfig_entity_builder` that sets or unsets the
  `contentish` third-party setting.
- Config schema: `config/schema/contentishconfig.schema.yml` defines
  `*.*.*.third_party.contentishconfig` (boolean `contentish`). The flag lives on each config
  entity's own third-party settings — there is **no module config object**.
- **No routes, no `*.permissions.yml`, no settings form, no Drush, no plugins, no `.install`.**

## Mechanism in one line

Export ⇒ the subscriber **deletes** contentish config names from the export storage; import ⇒ it
**writes the active-storage value back** into the import storage. Default: config id starting with
`_content_` is contentish (`contentishSelectionDefault()`). See
[api/mechanism.md](api/mechanism.md).

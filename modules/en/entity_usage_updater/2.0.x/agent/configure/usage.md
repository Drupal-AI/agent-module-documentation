<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using Entity Usage Updater

## Prerequisite
Install and configure **Entity Usage 5.x** (`drupal/entity_usage:^5.0.1`) and let it track the
reference types you care about — only tracked references can be updated or removed here. The DOM PHP
extension (`ext-dom`) is required for the HTML-link and Linkit updaters.

## Repoint references
1. Grant `update referenced entities` (permission is `restrict access: true`) to trusted admin roles.
2. Go to `/admin/content/update-references` (menu: Content → Update entity references).
3. Choose the entity type, enter the target entity ID to find and the replacement ID, then confirm.
   The module rewrites all tracked references (entity_reference, core link, HTML and Linkit links,
   including those nested in Paragraphs) via a batch. Updates change only the latest revision and are
   applied directly to content — back up first.

You can also reach an embedded update form on an entity's **Usage** tab (provided by Entity Usage),
which pre-fills that entity as the target.

## Remove links
`/admin/config/content/link-remover` takes a list of URLs (one per line), resolves each to an entity
via Entity Usage, and removes links to those entities from content (HTML/Link/Linkit). A confirm
screen lists each matched entity with its active usage count and current moderation/publish state.
Optionally tick **Unpublish content** to also move each affected entity to an unpublished state; for
content-moderation entities you pick the target state per row. Redirect-module entries pointing at the
targets are accounted for.

## Settings
`/admin/config/content/entity-usage-updater` (`administer site configuration`) configures the updater
plugins. The `html_link` plugin exposes a **Convert normal links to Linkit links** option. When
`content_moderation` is enabled, you can set a **default unpublished state** per workflow (stored as a
workflow third-party setting and used to pre-select the state on the Link remover).

## Extend
Add a plugin under `Plugin/EntityUsageUpdater` (attribute `#[EntityUsageUpdater(...)]` or the legacy
annotation) implementing `EntityUsageUpdaterPluginInterface` to support a new reference type; see the
shipped `entity_reference`, `html_link`, `link` and `linkit` plugins. Plugins that implement
`PluginFormInterface` get a section on the settings form automatically.

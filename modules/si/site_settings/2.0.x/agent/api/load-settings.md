<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Loading settings from PHP

## Services

| Service id | Class | Purpose |
|---|---|---|
| `plugin.manager.site_settings_loader` | `SiteSettingsLoaderPluginManager` | Discovers `@SiteSettingsLoader` plugins; `getActiveLoaderPlugin()`, `setActiveLoaderPlugin($id)`, `getLoaderPlugin($id)`. |
| `site_settings.replicator` | `SiteSettingsReplicator` | Batch worker behind the Replicate form (`processBatch()` / `finishBatch()`). |
| `site_settings.twig_extension` | `Twig\TwigExtension` | The six Twig functions (see `../theming/twig-and-blocks.md`). |
| `site_settings.simple_teaser` | `SiteSettingSimpleTeaserService` | `generateTeaser($build)` — the simplified admin teaser. |
| `cache.site_settings` | cache bin | Bin used by the flattened loader. |

## The loader plugin API

```php
/** @var \Drupal\site_settings\SiteSettingsLoaderPluginManager $manager */
$manager = \Drupal::service('plugin.manager.site_settings_loader');
$loader = $manager->getActiveLoaderPlugin();   // FALSE if site_settings.config:loader_plugin is empty
```

`SiteSettingsLoaderInterface`:

| Method | Returns |
|---|---|
| `allowAutoload(): bool` | Whether `hook_preprocess()` may auto-load into templates. `full` returns FALSE; `flattened` returns TRUE. |
| `loadAll(bool $rebuild_cache = FALSE, ?string $langcode = NULL): array` | Every setting. **Shape depends on the plugin** — see below. |
| `loadByGroup(string $group, ?string $langcode = NULL): array` | Settings in one group. |
| `loadByEntityBundleClass(string $class, ?string $langcode = NULL): array` | Settings whose bundle class matches. |
| `getGroups(): array` | The available groups. |
| `rebuildCache($langcode): void` / `clearCache(): void` | Cache control. |

### `full` loader (default, recommended)

Returns **`SiteSettingEntity` objects**, keyed by entity id, straight from
`entity_type.manager` storage (`loadByProperties(['group' => …])` for `loadByGroup()`).

```php
$loader = \Drupal::service('plugin.manager.site_settings_loader')->getActiveLoaderPlugin();
foreach ($loader->loadByGroup('contact_details') as $setting) {
  print $setting->bundle() . ': ' . $setting->get('field_number')->value;
}
```

### `flattened` loader (legacy)

Returns nested arrays `[$group][$type]` of plain values (or arrays of values for multi-value /
multi-field / multiple-entry settings), cached in the `site_settings` bin. It is the only loader
whose `allowAutoload()` is TRUE, so it is what powers `{{ site_settings.group.name }}` in every
template. It loses render arrays and entity metadata — the project README recommends the Twig
functions over it.

```php
$settings = $loader->loadAll();
$phone = $settings['contact_details']['phone_number'] ?? NULL;
```

## Loading entities directly (no plugin)

They are ordinary content entities:

```php
$storage = \Drupal::entityTypeManager()->getStorage('site_setting_entity');
$by_type = $storage->loadByProperties(['type' => 'phone_number']);
$one     = $storage->load(6);
$ids     = $storage->getQuery()->condition('type', 'phone_number')->accessCheck()->execute();
```

Because it is a normal entity type it is also available to Views
(`SiteSettingEntityViewsData`), to entity queries, and to the entity API generally.

## Tokens

`site_settings.tokens.inc` registers two token **types**:

- **`site_settings`** — flattened values, one token per `group--type[--suffix]`, e.g.
  `[site_settings:contact_details--phone_number]`. Built from the **active loader's**
  `loadAll()`, so with the `full` loader the flattened token list can be empty.
- **`site_settings_entity`** — one token per settings type exposing the whole entity's fields,
  e.g. `[site_settings_entity:phone_number:field_number]`. When a type has several entities they
  are indexed: `phone_number-0`, `phone_number-1`, …

```php
$text = \Drupal::token()->replace('[site_settings_entity:phone_number:field_number]');
```

Override the "Setting not found" fallback with
`hook_site_settings_no_setting_token_alter(&$site_settings_no_setting_token)`
(see `site_settings.api.php`).

## Replicating types from code

```php
/** @var \Drupal\site_settings\SiteSettingsReplicator $replicator */
$replicator = \Drupal::service('site_settings.replicator');
```

It is designed to be driven by the batch callbacks `_site_settings_replicate_process_batch()` /
`_site_settings_replicate_finish_batch()` from the Replicate form; for scripted work it is usually
simpler to create `SiteSettingEntityType` entities and duplicate the field configs yourself.

## No Drush commands

The module ships none. Use `drush php:eval` / `drush cget` / `drush cset` as above.

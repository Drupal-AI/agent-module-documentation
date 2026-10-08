<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Writing a MediaLibrarySource plugin

Plugin type that provides a Media Library source tab. Discovery: annotation-based, manager
`plugin.manager.media_library_source`, namespace `Plugin/MediaLibrarySource/`, interface
`MediaLibrarySourceInterface`, annotation `Drupal\media_library_extend\Annotation\MediaLibrarySource`.

## Skeleton
```php
namespace Drupal\my_module\Plugin\MediaLibrarySource;

use Drupal\media_library_extend\Plugin\MediaLibrarySource\MediaLibrarySourceBase;

/**
 * @MediaLibrarySource(
 *   id = "my_source",
 *   label = @Translation("My source"),
 *   source_types = { "image" },
 * )
 */
class MySource extends MediaLibrarySourceBase {
  // Override getResults() and getEntityId(); optionally buildForm(), getCount(),
  // and the plugin config form methods.
}
```

### Annotation keys (`MediaLibrarySource`)
- `id`, `label`.
- `source_types` — array of **media source plugin ids** (e.g. `image`, `oembed:video`) the
  pane supports. A pane is only offered for a field when its media bundle's source plugin id
  is in this list (see `MediaLibrarySourceManager::getApplicablePlugins()`).
- `class` is filled by discovery.

## Methods to implement (interface + base)
Extend `MediaLibrarySourceBase` (already implements `ContainerFactoryPluginInterface`,
`ConfigurableInterface`, `PluginFormInterface`). It injects `entity_type.manager`, `token`,
`file_system`.

- `getResults(): array` — **required.** Return an array of items, each with keys:
  `id` (opaque item id passed back to `getEntityId`), `label`, and `preview` (a render
  array, e.g. an `html_tag` img). Use `$this->getValue('page')` for the current page and
  `$this->configuration['items_per_page']` for the limit.
- `getEntityId(string $selected_id): int` — **required.** Turn a selected item id into a
  real Drupal media entity id, usually by creating the entity and attaching a downloaded
  file. Return the media id, or `-1` on failure.
- `buildForm(array &$form, FormStateInterface $form_state): array` — optional per-request
  **filter** form shown above the results (returns `$form` unchanged for no filters).
- `getCount()` — optional total result count (default `NULL`) for the pager.
- `label()`, `getSummary()` — provided by the base; override `getSummary()` to describe the
  pane's stored configuration in the admin list.

### Base-class helpers
- `createEntityStub($title)` — new (unsaved) media entity of the pane's target bundle.
- `getSourceField()` — the media type's source field name.
- `getUploadLocation()` — prepares and returns the destination directory (uri scheme +
  token-replaced `file_directory`) for saving downloads.
- `getTargetBundle()` / `setTargetBundle()` — the bundle the pane is bound to.
- `setValue()/getValue()` — per-request display state (e.g. page, filter values).

### Plugin configuration form (`ConfigurableInterface` + `PluginFormInterface`)
- `defaultConfiguration()` — base returns `['items_per_page' => 20]`; merge your keys.
- `buildConfigurationForm()` — base adds the `items_per_page` number field (1–50); call
  `parent::` and append your own elements (see `ConfigurableLoremPicsum` adding `grayscale`).
- `submitConfigurationForm()` — base copies matching keys from `$form_state` into config.
- Register a matching schema at `media_library_extend.source_plugin.<plugin_id>`
  (see [configure/panes.md](../configure/panes.md)).

## Example plugins to copy
- `Plugin/MediaLibrarySource/LoremPicsum.php` — filter form supplies grayscale per request.
- `Plugin/MediaLibrarySource/ConfigurableLoremPicsum.php` — grayscale stored as pane config.
Both fetch from `https://picsum.photos` via `http_client`, then in `getEntityId()` download
the chosen image with `file.repository` `writeData()` and attach it to a media entity.

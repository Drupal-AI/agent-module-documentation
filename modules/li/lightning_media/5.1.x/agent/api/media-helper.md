<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — `lightning.media_helper`, input matching, `Override`

## Services (`lightning_media.services.yml`)

| Service | Class | Notes |
|---|---|---|
| `lightning.media_helper` | `Drupal\lightning_media\MediaHelper` | the public API; takes `@entity_type.manager` |
| `lightning_media.route_subscriber` | `Drupal\lightning_media\Routing\RouteSubscriber` | swaps `entity_embed.dialog`'s `_form` for `Drupal\lightning_media\Form\EntityEmbedDialog` |

`LightningMediaServiceProvider` also replaces the class of core's
`library.libraries_directory_file_finder` with
`Drupal\lightning_media\LibrariesDirectoryFileFinder`.

## `InputMatchInterface`

```php
namespace Drupal\lightning_media;

interface InputMatchInterface {
  public function appliesTo($value, MediaTypeInterface $bundle);  // bool
}
```

A **media source plugin** implementing this can claim an arbitrary input value. Two ready
mix-ins ship:

- `FileInputExtensionMatchTrait` — matches a `FileInterface` (or a numeric file ID) whose
  extension is listed in the source field's `file_extensions` setting.
- `ValidationConstraintMatchTrait` — matches a string against the constraint named in the
  plugin definition's `input_match.constraint` when the value would be valid for one of the
  `input_match.field_types`.

That is exactly how the submodules work, e.g. `lightning_media_audio`:

```php
class AudioFile extends CoreAudioFile implements InputMatchInterface {
  use FileInputExtensionMatchTrait;
}
// lightning_media_audio.module
function lightning_media_audio_media_source_info_alter(array &$sources) {
  Override::pluginClass($sources['audio_file'], AudioFile::class);
}
```

## `MediaHelper` (service `lightning.media_helper`)

```php
$helper = \Drupal::service('lightning.media_helper');
```

| Method | Signature | Behaviour |
|---|---|---|
| `getFileExtensions()` | `(bool $check_access = FALSE, array $bundles = [])` | union of `file_extensions` across every media type whose source field item class descends from `FileItem` |
| `getBundlesFromInput()` | `($value, bool $check_access = TRUE, array $bundles = [])` | every `MediaTypeInterface` whose source implements `InputMatchInterface` and returns TRUE for `$value`, sorted by id |
| `getBundleFromInput()` | same args | the single matching type, else throws `Drupal\lightning_media\Exception\IndeterminateBundleException` (the exception carries the candidate list) |
| `createFromInput()` | `($value, array $bundles = [])` | **unsaved** media entity of the matched bundle with its source field set to `$value` |

Static helpers on the same class:

| Static | Purpose |
|---|---|
| `MediaHelper::getSourceField(MediaInterface $entity)` | the source field item list, or NULL |
| `MediaHelper::isPreviewable(MediaInterface $entity)` | TRUE when the source plugin definition has a `preview` key |
| `MediaHelper::useFile(MediaInterface $e, FileInterface $f, $replace = FileSystemInterface::EXISTS_RENAME)` | attaches a file and moves it to the source field's upload location |
| `MediaHelper::prepareFileDestination(MediaInterface $e)` | creates the upload directory and returns its URI |

`$check_access = TRUE` relies on the module's `MediaTypeStorage` override, which adds a
second `$check_access` parameter to `loadMultiple()` and filters by media `createAccess()`.

```php
// "here is a file, give me the right media entity"
try {
  $media = $helper->createFromInput($file);      // unsaved
  $media->setName($file->getFilename())->save();
}
catch (\Drupal\lightning_media\Exception\IndeterminateBundleException $e) {
  // 0 or 2+ media types matched
}
```

`lightning_media_validate_upload(FileInterface $file, array $bundles = [])` (a plain
function in `.module`) builds a media entity from the file and runs the *matched* media
type's own upload validators — `FileNameLength`, whatever the source field declares, plus
`FileIsImage` / `FileImageDimensions` for image fields — returning a constraint violation
list. It deliberately skips `FileExtension` (already checked by the widget) and returns an
empty array when the bundle is indeterminate.

## `Override` (internal, but the pattern to copy)

```php
Drupal\lightning_media\Override::pluginClass(array &$plugin_definition, string $replacement_class);
Drupal\lightning_media\Override::entityForm(EntityTypeInterface $type, string $class, string $op = 'default');
Drupal\lightning_media\Override::entityHandler(EntityTypeInterface $type, string $handler, string $class);
```

Each only swaps the class **when the replacement's immediate parent is the current class** —
so two modules overriding the same plugin do not silently clobber each other.

## Hooks this module implements (what to expect on a live site)

| Hook | Effect |
|---|---|
| `hook_entity_type_alter()` | media form → `lightning_media\Form\MediaForm` (default + edit); `media_type` storage → `MediaTypeStorage`; `show_revision_ui` from `lightning_media.settings:revision_ui` |
| `hook_ENTITY_TYPE_insert()` (`media_type`) | adds `field_media_in_library` + form widget to every new media type |
| `hook_entity_base_field_info_alter()` | makes media `revision_log_message` display-configurable on forms |
| `hook_entity_extra_field_info()` | adds a `preview` pseudo-field to the media form for every source with a `preview` definition key |
| `hook_views_pre_view()` | filters `media_library` widget displays to `field_media_in_library = 1` |
| `hook_entity_browser_widget_info_alter()` | registers the `file_upload` and `embed_code` widgets (needs `inline_entity_form`) |
| `hook_field_widget_third_party_settings_form()` / `_settings_summary_alter()` / `_form_alter()` | image widget `file_links` / `remove_button` |
| `hook_field_widget_WIDGET_TYPE_form_alter()` (`entity_browser_entity_reference`) | wraps current selections in a `<details>` and moves the count into the summary |
| `hook_element_info_alter()` | injects the default-value count into entity browser JS so cardinality can be enforced |
| `hook_preprocess_image_style()` | infers SVG dimensions from the image style's resize effects |
| `hook_form_FORM_ID_alter()` (`entity_embed_dialog`) | defaults the embed view mode to `embedded` for the `media_browser` embed button |
| `hook_js_settings_alter()` / `hook_ajax_render_alter()` | Entity Browser iframe library workarounds; replays CKEditor stylesheets on embed previews |
| `hook_modules_installed()` | grants `use text format rich_text` to the Lightning `creator` content role when `lightning_roles` is installed |

## Live preview

`Drupal\lightning_media\Form\MediaForm` (a `TrustedCallbackInterface`) adds a `preview`
element to the media form that AJAX-refreshes as the source field changes, for any media
type whose **source plugin definition contains a `preview` key**. The submodules set that
key for Instagram and Twitter; `MediaHelper::isPreviewable()` is the runtime check, and
`lightning_media_inline_entity_form_entity_form_alter()` reuses it inside IEF forms.

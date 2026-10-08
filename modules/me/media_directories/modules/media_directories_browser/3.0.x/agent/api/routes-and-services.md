<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Routes, JSON API and services

## Page routes

| Route | Path | Requirement |
|---|---|---|
| `media_directories_browser.admin` | `/admin/content/media-browser` | `access media directories browser` |
| `media_directories_browser.config_form` | `/admin/config/media/media_directories/browser` | `administer site configuration` |
| `media_directories_browser.media_quick_edit` | `/media-directories-browser/{media}/quick-edit` | `_entity_access: media.update` |

`MediaDirectoriesBrowserController::adminPage()` renders the Vue mount point, attaches
`media_directories_browser/media_directories_browser_app` and, when
`experimental_fullscreen` is on, the `fullscreen` library.
`quickEditForm()` builds the media form with the **`media_library`** operation — that form
class is registered by `MediaDirectoriesBrowserHooks::entityTypeAlter()`
(`$entity_types['media']->setFormClass('media_library', MediaForm::class)`) so both the form
class and the matching `media_library` form display resolve. `hook_form_alter()` then wraps
it in `#media-directories-browser-quick-edit-form`
(`MediaDirectoriesBrowserController::QUICK_EDIT_WRAPPER_ID`), makes Save submit via AJAX,
hides Delete and adds an "Open full edit form" link.

## JSON API — `/api/media-directories-browser/...`

**Every** route below requires the `access media directories browser` permission and allows
`_auth: [basic_auth, cookie]`. Controller: `Drupal\media_directories_browser\Controller\ApiController`.

| Method | Path suffix | Controller method |
|---|---|---|
| GET | `media-types` | `getMediaTypes()` |
| GET | `media` | `getMedia()` |
| GET | `media-counts` | `getMediaCounts()` |
| GET | `media-paginated` | `getMediaPaginated()` |
| GET | `media-by-mids` | `getMediaByMids()` |
| GET | `media/{uuid}` | `getMediaItem()` |
| GET | `media/{uuid}/file-url` | `getMediaFileUrl()` |
| GET | `media/{uuid}/styled-url` | `getStyledImageUrl()` |
| GET | `directories` | `getDirectories()` |
| GET | `entity-autocomplete` | `entityAutocomplete()` |
| POST | `upload` | `uploadFiles()` |
| POST | `create-from-url` | `createFromUrl()` |
| POST | `media/update` | `updateMedia()` |
| POST | `media/delete` | `deleteMedia()` |
| POST | `media/move` | `moveMedia()` |
| POST | `media/save-translation` | `saveTranslation()` |
| POST | `directory/create` | `createDirectory()` |
| POST | `directory/rename` | `renameDirectory()` |
| POST | `directory/delete` | `deleteDirectory()` |
| POST | `directory/move` | `moveDirectory()` |
| POST | `directory/reorder` | `reorderDirectories()` |

`media_directories_ai` adds three more under the same prefix
(`ai/alt-text`, `ai/alt-text-from-file`, `ai/translate`).

Quick probe from the CLI:

```bash
drush php:eval '
  $r = \Symfony\Component\HttpFoundation\Request::create("/api/media-directories-browser/directories");
  print \Drupal::service("http_kernel")->handle($r)->getContent();'
```

## Services

Declared in `media_directories_browser.services.yml`. Optional dependencies use `@?` so the
module works without `content_translation`, `focal_point` or `entity_usage`.

| Service id | Class | What it does |
|---|---|---|
| `media_directories_browser.directory_service` | `DirectoryService` | `getVocabulary()`, `resolveUuid($uuid): ?int`, `getSortMode()`, `getDirectories()` (the tree the app renders), `createDirectory($name, $parent_uuid)`, `renameDirectory($tid, $name)`, `deleteDirectory($tid)`, `moveDirectory($tid, $parent_uuid)`, `reorderDirectories(array $order)`, `loadDirectoryTerm($tid)`. Directories are addressed by **term UUID** over the wire. |
| `media_directories_browser.media_service` | `MediaService` | The workhorse (~1000 lines): listing/paging/counting media, uploads, create-from-URL, update/delete/move, thumbnail + image-style URLs, date formatting, optional `entity_usage` links. Depends on the other five services. |
| `media_directories_browser.media_type_service` | `MediaTypeService` | `getSourceFieldName($bundle)`, `hasLocalFile($bundle)`, `getFileBasedBundles()`, `getMediaTypes()` → per-bundle metadata (editable fields, translatable fields, `has_focal_point`, …) used by the app and by `MediaFileLink`. |
| `media_directories_browser.translation_service` | `MediaTranslationService` | `getTranslatableFields()`, `loadTranslations()`, `saveTranslation($uuid, $langcode, $values)`, `saveNewMediaTranslations($mid, $translations)`. No-ops sensibly when `content_translation` is absent. |
| `media_directories_browser.focal_point_service` | `FocalPointService` | `load(File, FieldItem): ?string`, `save(File, FieldItem, string $focal_point)`. Returns/ignores silently without `drupal/focal_point`. |
| `media_directories_browser.entity_autocomplete_service` | `EntityAutocompleteService` | `search($target_type, $q, $bundles = '', $limit = 10)` for reference fields in the edit modal. |
| `Drupal\...\Hook\MediaDirectoriesBrowserHooks1` | hook class | `hook_preprocess_menu` (autowired) |

`Drupal\media_directories_browser\Hook\MediaDirectoriesBrowserHooks` is registered as an
autowired hook class too (via attributes, not the services file).

```php
$dirs = \Drupal::service('media_directories_browser.directory_service')->getDirectories();
$tid  = \Drupal::service('media_directories_browser.directory_service')->createDirectory('Press', $parent_uuid);
$types = \Drupal::service('media_directories_browser.media_type_service')->getFileBasedBundles();
```

## Hooks implemented

| Hook | Purpose |
|---|---|
| `theme` | `media_directories_browser_preview_item` (vars: `mid`, `thumbnail`, `name`, `edit_url`) → `templates/media-directories-browser-preview-item.html.twig` |
| `entity_type_alter` | registers the `media_library` form operation on `media` |
| `form_alter` | AJAX-ifies the quick-edit form, hides Delete, adds "Open full edit form" |
| `page_attachments` | publishes `drupalSettings.mediaDirectoriesBrowser` |
| `menu_links_discovered_alter` (after `navigation`) | repoints `navigation.media` and the admin_toolbar Media link at `media_directories_browser.admin` |
| `menu_local_tasks_alter` | tweaks the content local tasks |
| `editor_js_settings_alter` | removes core's view-mode dropdown from the media toolbar when `ImageOptions` supplies the unified control |
| `ckeditor5_plugin_info_alter` | adjusts CKEditor 5 plugin definitions |
| `preprocess_menu` (in `…Hooks1`) | menu tweaks |

No `*.api.php` — the module invites no hooks of its own.

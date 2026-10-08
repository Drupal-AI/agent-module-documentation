<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Media Directories UI (deprecated)

## `media_directories_ui.settings`

| Key | Type | Default | Effect |
|---|---|---|---|
| `hide_media_library_media_tab` | bool | `false` | `hook_menu_local_tasks_alter()` unsets `$data['tabs'][0]['entity.media.collection']` — core's *Media* tab on `/admin/content`. |
| `hide_media_library_files_tab` | bool | `false` | Unsets `$data['tabs'][0]['views_view:view.files.page_1']` — the *Files* tab. |
| `hide_admin_toolbar_links` | bool | `false` | `hook_menu_links_discovered_alter()` removes `admin_toolbar_tools.extra_links:add_media` and its children; also removes `…:media_page` / `…:view.files` when the two tab settings above are on. |
| `enable_combined_upload` | bool | `false` | Enables the combined upload form (`MediaCombinedUploadForm`). |
| `combined_upload_media_types` | sequence of strings | `{}` | Media type ids included in combined upload. |

**There is no dedicated settings route.** `MediaDirectoriesUiHooks::formMediaDirectoriesConfigFormAlter()`
(`#[Hook('form_media_directories_config_form_alter')]`) appends a *"Media browser UI"*
`details` element to the **parent** module's form at `/admin/config/media/media_directories`.

```bash
drush cget media_directories_ui.settings

drush cset media_directories_ui.settings hide_media_library_media_tab 1 -y
drush cset media_directories_ui.settings hide_admin_toolbar_links 1 -y

drush php:eval '
  \Drupal::configFactory()->getEditable("media_directories_ui.settings")
    ->set("enable_combined_upload", TRUE)
    ->set("combined_upload_media_types", ["image", "document"])
    ->save();'
drush cr   # menu links and local tasks are cached
```

## Permission

```yaml
access media directories ui browser:
  title: 'Access to Media Directories browser'
```

It gates **all ten** AJAX routes:

| Route | Path |
|---|---|
| `media_directories_ui.directory.tree` | `/admin/media_directories/directory/tree` |
| `media_directories_ui.directory.content` | `/admin/media_directories/directory/tree/content` |
| `media_directories_ui.directory.add` | `/admin/media_directories/directory/tree/add` |
| `media_directories_ui.directory.rename` | `/admin/media_directories/directory/tree/rename` |
| `media_directories_ui.directory.delete` | `/admin/media_directories/directory/tree/delete` |
| `media_directories_ui.directory.move` | `/admin/media_directories/directory/tree/move` |
| `media_directories_ui.media.add` | `/admin/media_directories/media/add` |
| `media_directories_ui.media.edit` | `/admin/media_directories/media/edit` |
| `media_directories_ui.media.move` | `/admin/media_directories/media/move` |
| `media_directories_ui.media.delete` | `/admin/media_directories/media/delete` |

The browser page itself is the entity browser route
`entity_browser.media_directories_overview` (menu link + local task *"Media browser"* under
`/admin/content`).

## Shipped config

| Config | Purpose |
|---|---|
| `entity_browser.browser.media_directories_overview` | standalone admin browser |
| `entity_browser.browser.media_directories_modal` | modal browser for reference fields |
| `views.view.media_directories_base` | the media grid the browser renders |
| `image.style.browser_thumbnail` | thumbnail style used in that grid |

## Plugins and services

- `@EntityBrowserWidget(id = "media_directories_browser_widget")` →
  `Drupal\media_directories_ui\Plugin\EntityBrowser\Widget\DirectoryBrowser` — the jsTree
  sidebar + media grid. It branches on the route's `entity_browser_id`
  (`media_directories_overview` vs `media_directories_editor_browser`).
- `@EntityBrowserWidgetValidation` → `TargetBundles`.
- Views argument plugin `StringContainsArgument`.
- Validation constraint `MediaDirectoriesConstraint` + validator.
- AJAX commands `LoadDirectoryContent`, `RefreshDirectoryTree`.
- Service `media_directories_ui.helper` (`MediaDirectoriesUiHelper`):
  `getMediaType(?FileInterface)`, `getValidExtensions()`,
  `termIsAnAnchestor Of(Term, Term)` *(sic — spelled `termIsAnAnchestorOf`)*,
  `termIsAChildOf(Term, $parent)`.
- Hook class `Drupal\media_directories_ui\Hook\MediaDirectoriesUiHooks` implements `theme`,
  `css_alter`, `block_access`, `views_data_alter`, several `preprocess_*` hooks,
  `form_entity_browser_media_directories_overview_form_alter`,
  `form_entity_browser_media_directories_modal_form_alter`,
  `field_widget_single_element_entity_browser_entity_reference_form_alter`,
  `menu_local_tasks_alter`, `menu_links_discovered_alter` and
  `form_media_directories_config_form_alter`.

## Migration note

`media_directories_browser_update_11004()` migrates the *editor* submodule's
`embed_dialog.image_styles` into `media_directories_browser.settings:embed_image_styles`.
There is no automatic migration for `media_directories_ui.settings` — the Vue browser's
equivalent options (`enable_combined_upload`, `combined_upload_media_types`) live in
`media_directories_browser.settings` and must be set there.

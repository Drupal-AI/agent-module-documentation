<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How it works (mechanism)

Two PHP classes, one YAML plugin definition, one JS bundle. No services to call from your own
code beyond the tagged opener.

## `linkit_media_library.ckeditor5.yml`

```yaml
linkit_media_library_link:
  ckeditor5:
    plugins: [linkitMediaLibrary.LinkitMediaLibrary]
    config:
      linkitMediaLibrary:
        openDialog: { func: { name: Drupal.ckeditor5.openDialog, invoke: false } }
        dialogSettings: { height: 75%, dialogClass: media-library-widget-modal, title: 'Add or select media' }
  drupal:
    label: 'LinkIt media library'
    class: Drupal\linkit_media_library\Plugin\CKEditor5Plugin\LinkitMediaLibrary
    library: linkit_media_library/ckeditor5
    elements: ['<a aria-label title class id target="_blank" rel>']
    conditions:
      plugins: [linkit_extension]
```

`conditions.plugins` is why the button never shows unless Linkit's own CKEditor 5 extension is
enabled on that format.

## `LinkitMediaLibrary::getDynamicPluginConfig()`

Marked `@internal`. On every editor build for a format it:

1. Returns the static config unchanged if the editor has no associated filter format.
2. Returns unchanged if the format has no `linkit` filter.
3. Reads the profile id from `$editor->getSettings()['plugins']['linkit_extension']['linkit_profile']`
   and loads that `linkit_profile`.
4. Iterates the profile's matchers, keeping only `entity:media` ones; unions their
   `settings.bundles` into `$bundles` and remembers `settings.substitution_type`.
5. Returns unchanged if no media matcher was found.
6. If `$bundles` is empty, replaces it with **all** media type ids.
7. Builds `MediaLibraryState::create('linkit_media_library.opener.editor', $bundles,
   reset($bundles), 1, ['filter_format_id' => …, 'substitution_plugin' => …])` — note the
   **remaining-slots value of 1**, i.e. single selection.
8. Generates the `media_library.ui` route URL with that state as query and sets it as
   `linkitMediaLibrary.libraryURL` in the plugin config.

Failure modes are all "silently do nothing" — a missing filter, missing matcher or missing profile
just leaves the button unconfigured rather than raising an error.

## `LinkitMediaLibraryEditorOpener` (service `linkit_media_library.opener.editor`)

Tagged `media_library.opener`, implements `MediaLibraryOpenerInterface`.

- **`checkAccess(MediaLibraryState $state, AccountInterface $account)`** — loads the
  `filter_format` named by the state's `filter_format_id` opener parameter; forbidden (with the
  `filter_format_list` cache tag) if it does not exist; otherwise `use` access on the format
  **AND** `filters->has('linkit') && filters->get('linkit')->status === TRUE`.
- **`getSelectionResponse(MediaLibraryState $state, array $selected_ids)`** — loads the first
  selected media entity and returns an `AjaxResponse` with an `EditorDialogSave` command carrying:

```php
['attributes' => [
  'data-entity-bundle'       => $media->bundle(),
  'data-entity-type'         => 'media',
  'data-entity-substitution' => $state->getOpenerParameters()['substitution_plugin'],
  'data-entity-uuid'         => $media->uuid(),
  'href'                     => '/media/' . $media->id(),
  'target'                   => '_blank',
]]
```

The stored `href` is a placeholder — Linkit's **URL converter filter** rewrites it at render time
from `data-entity-type` + `data-entity-uuid` + `data-entity-substitution`, which is why the link
keeps working if the media alias or file changes.

`target="_blank"` is unconditional and not configurable.

## Assets

`linkit_media_library.libraries.yml` → library `ckeditor5`:
`js/build/linkitMediaLibrary.js` (built from `js/ckeditor5_plugins/linkitMediaLibrary/src/index.js`
via webpack) + `css/linkit-media-library.css`, depending on `core/drupal`, `ckeditor5/ckeditor5`,
`ckeditor5/ckeditor5.link` and `editor/drupal.editor.dialog`.

`linkit_media_library.info.yml` sets `container_rebuild_required: true` because of the tagged
service.

## `hook_install()`

Loads the `default` linkit profile, returns early if it already has an `entity:media` matcher,
otherwise creates one from `plugin.manager.linkit.matcher` and saves the profile. It touches only
the `default` profile — any other profile you must configure yourself.

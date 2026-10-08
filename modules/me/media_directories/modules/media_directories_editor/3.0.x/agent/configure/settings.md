<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Media Directories Editor (deprecated)

## `media_directories_editor.settings`

```yaml
embed_dialog:
  image_styles: {}      # sequence of image style ids; EMPTY means "show all styles"
```

Schema: `media_directories_editor.settings` → `embed_dialog` (mapping) → `image_styles`
(sequence of strings).

There is **no route of its own**. `MediaDirectoriesEditorHooks::formMediaDirectoriesConfigFormAlter()`
(`#[Hook('form_media_directories_config_form_alter')]`) adds an *"Editor Settings"* `details`
element (`#tree = TRUE`) to `/admin/config/media/media_directories` containing:

- a *Directories button* fieldset with a pointer to `filter.admin_overview` and a reminder to
  enable the **Embed media** filter, and
- an *Embed dialog* details with a `#multiple` select **"Select images styles to use"**
  bound to `embed_dialog.image_styles`, whose description states that *"if nothing is
  selected, all styles will be shown"*.

It then does `array_unshift($form['#submit'], 'media_directories_editor_config_form_submit')`
— a procedural submit handler in the `.module` file that saves
`$form_state->getValue(['media_directories_editor', 'embed_dialog'])` into the config.

```bash
drush cget media_directories_editor.settings

drush php:eval '
  \Drupal::configFactory()->getEditable("media_directories_editor.settings")
    ->set("embed_dialog.image_styles", ["large", "medium"])
    ->save();'
```

## Shipped config

| Config | Notes |
|---|---|
| `embed.button.media_directories` | label **Media**, `type_id: entity`, `entity_type: media`, `entity_browser: media_directories_editor_browser`, `display_plugins: [entity_reference:media_directories_image_dimensions]`, `entity_browser_settings.display_review: false`, folder SVG icon at `public://embed_buttons/folder.svg`. |
| `entity_browser.browser.media_directories_editor_browser` | iframe browser reusing the UI submodule's `media_directories_browser_widget` Entity Browser widget. |
| `media_directories_editor.settings` | the single setting above. |

`media_directories_editor_install()` (skipped while `\Drupal::isConfigSyncing()`) adds the
`image` and `remote_video` bundles to the button when those media types exist, and appends
`view_mode:media.full` to `type_settings.display_plugins` when the `media.full` view mode
exists. `media_directories_editor_uninstall()` deletes both
`entity_browser.browser.media_directories_editor_browser` and
`embed.button.media_directories`.

Historical updates: `update_8001` repointed the browser's widget id to
`media_directories_browser_widget`; `update_8002` relabelled it *"Media Directories: Editor
widget"* (including config translations); `update_8003` swapped the button icon from PNG to
SVG.

## Field formatter

`media_directories_image_dimensions` —
`Drupal\media_directories_editor\Plugin\Field\FieldFormatter\MediaDirectoriesImageDimensionsFormatter
extends MediaThumbnailFormatter` (`@FieldFormatter`, field types: entity_reference to media).
It renders the media thumbnail at explicit width/height, which is what makes the embed
dialog's resize control meaningful. Its `settingsForm()` and `viewElements()` extend the core
thumbnail formatter's.

## Other hooks

| Hook | Behaviour |
|---|---|
| `form_entity_embed_dialog_alter` | Only when `$storage['embed_button']->id() === 'media_directories'`: replaces `$form['entity']['#markup']` with a linked `image_style` (`media_library`) thumbnail titled *"Selected item"*; JSON-decodes a stringified `data-entity-embed-display-settings` for image media; attaches `$form['entity_browser']['#entity_browser_validators']['target_bundles']` from the button's own `bundles` setting. |
| `preprocess_entity_embed_container` | Unsets `data-entity-embed-display-settings` from the rendered container attributes. |

Libraries: `image-resize` (jQuery-dependent CSS + JS for the dialog's resize UI).

## Migration to the CKEditor 5 path

`media_directories_browser_update_11004()` reads
`media_directories_editor.settings:embed_dialog.image_styles`, keeps only the truthy values
(the old form stored a checkboxes-style `id => id|0` array) and writes them to
`media_directories_browser.settings:embed_image_styles`. Note the semantics change: the old
empty list meant *"show all styles"*, the new one means *"offer no styles at all"*.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Editor Advanced Image on a text format

The module has **no configure route** (`configure: null`) and no standalone settings page. You
configure it per **text format + editor** on the CKEditor 5 configuration form. The settings
are stored inside that format's `editor.editor.<format>` config entity.

## Prerequisites

- The format must use **CKEditor 5** as its text editor.
- The core **Image** CKEditor 5 plugin (`ckeditor5_image`) must be enabled on the toolbar — the
  Editor Advanced Image plugin declares `conditions: plugins: [ckeditor5_image]` and does not
  load without it.

## Where the settings are stored

Config entity: `editor.editor.<format>` (e.g. `editor.editor.full_html`).
Path within it:

```yaml
settings:
  plugins:
    editor_advanced_image_image:
      disable_balloon: false          # true = hide the balloon/form button entirely
      default_class: 'img-fluid'      # class(es) auto-added to newly inserted images ('' = none)
      enabled_attributes:             # which attributes the balloon form offers
        - class
        - title
        - id
```

Schema: `ckeditor5.plugin.editor_advanced_image_image` (`config/schema/editor_advanced_image.schema.yml`).
`enabled_attributes` is a `sequence` validated by a `Choice` constraint against
`EditorAdvancedImage::validChoices()` → only `title`, `class`, `id` are accepted.

Defaults (when the plugin is enabled but unconfigured), from `DEFAULT_CONFIGURATION`:
`disable_balloon: false`, `default_class: ''`, `enabled_attributes: ['class']`.

## Via the UI

1. Go to *Administration → Configuration → Content authoring → Text formats and editors*
   (`/admin/config/content/formats`) and edit a CKEditor 5 format.
2. Make sure the **Image** button is in the active toolbar.
3. Scroll to the **Editor Advanced Image** vertical-tab / details section under
   "CKEditor 5 plugin settings".
4. Tick the attributes to expose (**Title**, **CSS classes**, **ID**), optionally set
   **Default image class(es)**, and optionally tick **Disable Balloon**.
5. Save the format. Editors then see an "Editor Advanced Image" button in the image balloon
   toolbar exposing exactly the allowlisted attributes.

## Via drush (scriptable)

```php
$editor = \Drupal::entityTypeManager()->getStorage('editor')->load('full_html');
$settings = $editor->getSettings();
$settings['plugins']['editor_advanced_image_image'] = [
  'disable_balloon' => FALSE,
  'default_class' => 'img-fluid',
  'enabled_attributes' => ['class', 'title', 'id'],
];
$editor->setSettings($settings)->save();
```

## Read it back

```bash
drush cget editor.editor.full_html settings.plugins.editor_advanced_image_image
```

## Allowed-HTML interaction

`getElementsSubset()` returns `<img title>`, `<img class>`, `<img id>` for each enabled
attribute, so enabling an attribute automatically adds it to the format's allowed-HTML tags;
the plugin also statically declares `<img title class id>`. This is why authored attributes are
not stripped by the filter system.

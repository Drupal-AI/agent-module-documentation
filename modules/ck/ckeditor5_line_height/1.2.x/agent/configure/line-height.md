<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Line Height button

There is **no module settings page**. Everything is configured per text format on the
CKEditor 5 toolbar builder.

## UI steps

1. Go to *Administration > Configuration > Content authoring > Text formats and editors*
   (`/admin/config/content/formats`) and edit a format whose text editor is **CKEditor 5**.
2. In *Toolbar configuration*, drag the **Line Height** button from *Available buttons* into
   the *Active toolbar*.
3. A vertical tab **Line Height Options** appears under *CKEditor 5 plugin settings*. Enter a
   space-separated list of values (e.g. `1 1.5 2`). Leave empty to restore defaults.
4. Save. Make sure the format's filters do not strip the inline `style` attribute the plugin
   writes (e.g. *Limit allowed HTML tags* must allow `style` where you want it).

## Where it is stored

The button and its options live in the **editor config entity**, not in any module config:

```
editor.editor.<format>:
  editor: ckeditor5
  settings:
    toolbar:
      items:
        - lineHeight            # presence of this enables the button
    plugins:
      ckeditor5_line_height_line_height:
        line_height_options:    # the value list (sequence of strings)
          - '1'
          - '1.5'
          - '2'
```

Read/verify with Drush:

```bash
drush cget editor.editor.full_html settings.toolbar.items
drush cget editor.editor.full_html settings.plugins.ckeditor5_line_height_line_height.line_height_options
```

## Behavior / validation (from `LineHeight.php`)

- `const CONFIG_NAME = 'line_height_options'`.
- Default list: `0 0.5 1 1.5 2 2.5 3 3.5 4 4.5 5 5.5 6 6.5`
  (`DEFAULT_CONFIGURATION['line_height_options']`).
- `validateConfigurationForm()`: splits the textarea on whitespace, **removes any value `>= 10`**,
  de-duplicates (`array_unique`); an **empty** field resets to the defaults.
- `getDynamicPluginConfig()` maps the stored list to the CKEditor 5 runtime config as
  `lineHeight.options`.
- The plugin declares `elements: false` in `ckeditor5_line_height.ckeditor5.yml`, so it adds no
  GHS/allowed-elements of its own.

## Programmatic example

```php
$editor = \Drupal\editor\Entity\Editor::load('full_html');
$settings = $editor->getSettings();
$settings['toolbar']['items'][] = 'lineHeight';
$settings['plugins']['ckeditor5_line_height_line_height']['line_height_options'] = ['1', '1.5', '2'];
$editor->setSettings($settings)->save();
```

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hooks (`ckeditor.api.php`)

Two alter hooks, matching core CKEditor 4.

## `hook_ckeditor_plugin_info_alter(array &$plugins)`

Modify CKEditor plugin definitions after all `@CKEditorPlugin`s are discovered (invoked by
`CKEditorPluginManager` via `alterInfo('ckeditor_plugin_info')`). Use it to rename, tweak, or adjust
another module's plugin.

```php
function mymodule_ckeditor_plugin_info_alter(array &$plugins) {
  $plugins['stylescombo']['label'] = t('Better name');
}
```

## `hook_ckeditor_css_alter(array &$css, \Drupal\editor\Entity\Editor $editor)`

Add CSS files to the **iframe** editing area without writing a full plugin. `$css` is a flat list of
Drupal-root-relative paths or external URLs; `$editor` lets you branch on the text format.

```php
function mymodule_ckeditor_css_alter(array &$css, \Drupal\editor\Entity\Editor $editor) {
  $css[] = \Drupal::service('extension.list.module')->getPath('mymodule') . '/css/mymodule-ckeditor.css';
}
```

Themes can do the same declaratively via an `info.yml` entry (only affects iframe instances):

```yaml
# mytheme.info.yml
ckeditor_stylesheets:
  - css/ckeditor-iframe.css
```

No other hooks are invited. (There is also `hook_help` for the settings page and a `hook_theme` for the
`ckeditor-settings-toolbar` template, but those are internal, not extension points.)

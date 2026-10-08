# FakeObjects — CKEditor plugin registration & setup

FakeObjects is a CKEditor **4** integration. It has no service API, forms, hooks you
implement, or Drush commands — it ships one CKEditor plugin definition plus an install
requirements check.

## The CKEditor plugin

`src/Plugin/CKEditorPlugin/FakeObjects.php` extends `Drupal\ckeditor\CKEditorPluginBase`:

```php
/**
 * @CKEditorPlugin(
 *   id = "fakeobjects",
 *   label = @Translation("FakeObjects"),
 * )
 */
class FakeObjects extends CKEditorPluginBase {
  public function getFile() {
    return 'libraries/fakeobjects/plugin.js'; // loaded relative to DRUPAL_ROOT
  }
  public function getConfig(Editor $editor) { return []; } // no editor config
  public function getButtons() { return []; }              // no toolbar button
}
```

- Plugin id: `fakeobjects`. It implements the core `ckeditor` (CKEditor 4) plugin type; it
  does **not** define a new plugin type of its own.
- Because `getButtons()` is empty, the plugin is a dependency/utility plugin — it is pulled
  in by other CKEditor plugins that declare it as a requirement, not toggled by editors.

## Installing the JavaScript library

The JS is **not** bundled. Download the CKEditor add-on (>= 4.5.11) from
`https://ckeditor.com/cke4/addon/fakeobjects` and place it so that
`/libraries/fakeobjects/plugin.js` exists. Composer also declares the library package
`drupal-ckeditor-libraries-group/fakeobjects: ^4.5.11` in the module's `require`.

## Requirements check

`fakeobjects.install` implements `hook_requirements()` (`install` and `runtime` phases):
it checks `file_exists(DRUPAL_ROOT . '/libraries/fakeobjects/plugin.js')` and reports
`REQUIREMENT_OK` ("Plugin detected") or `REQUIREMENT_ERROR` ("Plugin not detected") on the
status report.

## Drupal 10 / 11 note

CKEditor 4 is no longer in Drupal core. To use this plugin on Drupal 10/11, also install the
contributed CKEditor 4 module: `composer require drupal/ckeditor:^1.0` and enable it.

# The `drupalviews` BUEditor plugin

The submodule is one BUEditor plugin plus one JS library.

## The plugin

`Drupal\insert_view_adv_bueditor\Plugin\BUEditorPlugin\DrupalViews` extends
`Drupal\bueditor\BUEditorPluginBase`:

```php
/**
 * @BUEditorPlugin(
 *   id = "drupalviews",
 *   label = "Embedded Views"
 * )
 */
class DrupalViews extends BUEditorPluginBase {
  public function getButtons() {
    return ['drupalviews' => $this->t('Views Embed')];   // toolbar button
  }
  public function alterEditorJS(array &$js, BUEditorEditor $bueditor_editor, ?Editor $editor = NULL) {
    $toolbar = BUEditorToolbarWrapper::set($js['settings']['toolbar']);
    if ($toolbar->has('drupalviews')) {                  // only when the button is on the toolbar
      $js['libraries'][] = 'insert_view_adv_bueditor/drupalviews';
    }
  }
  public function alterToolbarWidget(array &$widget) {
    $widget['libraries'][] = 'insert_view_adv_bueditor/drupalviews';
  }
}
```

So it declares a `drupalviews` button; only if a BUEditor editor's toolbar actually contains
that button does it attach the JS library (a conditional-library pattern worth copying for
other BUEditor plugins).

## The library & JS

`insert_view_adv_bueditor.libraries.yml`:

```yaml
drupalviews:
  version: 1.0
  js: { js/bueditor.drupalviews.js: {} }
  dependencies:
    - bueditor/drupal.bueditor
```

`js/bueditor.drupalviews.js` extends the BUEditor (`BUE`) object with a "View Embed Token"
dialog/form that collects the view name, display and arguments and inserts the resulting
`[view:...]` token into the content. The parent `insert_view_adv` text-format filter renders
that token at display time (see the parent module's `agent/api/token-syntax.md`).

## Enabling

Add the **Views Embed** (`drupalviews`) button to a BUEditor toolbar (BUEditor editor config),
on a text format whose filter set includes the Advanced Insert View filter. Requires the
`bueditor` project to be installed — it is **not** on this site.

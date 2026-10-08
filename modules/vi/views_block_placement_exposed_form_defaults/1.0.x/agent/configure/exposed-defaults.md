# Configure exposed-form defaults for a placed Views block

No admin page. Configuration happens in two places: the **view's block display** (which filters
are customizable) and the **block placement** (the default values).

## 1. Mark filters customizable (Views UI)

1. Edit the view, select its **Block** display.
2. Ensure the filters you want are **exposed** (Filter criteria → *Expose*).
3. In the block display's **"Allow settings"** (the `allow` section of the display options), a
   **"Customizable filters"** checkbox list appears (added by `ExposedFormBlockDisplay`). Tick the
   exposed filters that site builders should be able to default when placing this block.
4. Save the view.

Stored on the view config as the display option `customizable_exposed_filters` (a map keyed by
filter handler id):

```yaml
# views.view.<id>:
display:
  block_1:
    display_options:
      customizable_exposed_filters:
        title: title
        type: type
```

Read it back:

```bash
drush cget views.view.<id> display.block_1.display_options.customizable_exposed_filters
```

Set it with drush (scriptable):

```php
$view = \Drupal::entityTypeManager()->getStorage('view')->load('my_view');
$display = &$view->getDisplay('block_1');
$display['display_options']['customizable_exposed_filters'] = ['title' => 'title'];
$view->save();
```

## 2. Set default values on placement

When you place that block (Block layout `admin/structure/block`, or a Layout Builder block), the
block configuration form now shows the exposed-filter form elements for the customizable filters
(built by `ExposedFormBlockDisplay::blockForm()`). Enter the **default values** you want for this
placement and save.

The values are stored on the placed block's configuration as `exposed_filter_values` (schema key
added to `views_block`), e.g. inside `block.block.<id>` → `settings.exposed_filter_values`. At
render, `preBlockBuild()` calls `$view->setExposedInput($exposed_filter_values)` so the block loads
already filtered.

## How it works

`hook_views_plugins_display_alter()` replaces the core Views `Block` display plugin class with
`Drupal\views_block_placement_exposed_form_defaults\ExposedFormBlockDisplay`, which:
- adds the **Customizable filters** checkboxes in `buildOptionsForm()`/saves them in
  `submitOptionsForm()` (only for the `allow` section);
- lists selectable filters via `getListOfExposedFilters()` (exposed filters only);
- renders the chosen filters' exposed form in `blockForm()` and stores submitted values in
  `blockSubmit()`;
- injects them into the view in `preBlockBuild()`.

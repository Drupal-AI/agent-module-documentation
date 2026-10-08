<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Putting a block display's exposed filters in their own block

The module ships **zero configuration**. Everything happens on the view's display and on
Block layout.

## 1. Enable the option on the block display

UI: edit the view → select the **Block** display → *Advanced* → **Exposed form in block** → **Yes** → Save.

Config (`views.view.<view_id>`):

```yaml
display:
  block_1:
    display_plugin: block
    display_options:
      exposed_block: true       # <- this is the whole switch
```

Without this module the option is not offered on block displays at all (core's
`DisplayPluginBase::optionsSummary()`/`buildOptionsForm()` only show `exposed_block` when the
display plugin's `usesExposedFormInBlock()` returns TRUE, which core's `block` display does not).

Set it programmatically:

```php
$view = \Drupal\views\Entity\View::load('my_view');
$display = &$view->getDisplay('block_1');
$display['display_options']['exposed_block'] = TRUE;
$view->save();
```

Read it back:

```bash
drush config:get views.view.my_view display.block_1.display_options.exposed_block
```

## 2. Place the generated block

Core's `views_exposed_filter_block` deriver
(`\Drupal\views\Plugin\Derivative\ViewsExposedFilterBlock`) scans **enabled** views for displays
that both have `exposed_block` set **and** whose display plugin returns TRUE from
`usesExposedFormInBlock()`. For each match it creates:

```
plugin id:    views_exposed_filter_block:<view_id>-<display_id>
admin label:  "Exposed form: <view_id>-<display_id>"
```

Place it like any block:

```php
\Drupal\block\Entity\Block::create([
  'id' => 'my_view_filters',
  'plugin' => 'views_exposed_filter_block:my_view-block_1',
  'theme' => \Drupal::config('system.theme')->get('default'),
  'region' => 'sidebar_first',
  'settings' => ['id' => 'views_exposed_filter_block:my_view-block_1', 'label' => 'Filters', 'label_display' => '0'],
])->save();
```

or via *Structure → Block layout → Place block* and search for **Exposed form: …**.

Then place the view's own block (`views_block:my_view-block_1`) wherever the results belong.

## Behaviour details

- Once `exposed_block` is TRUE, `DisplayPluginBase::viewExposedFormBlocks()` renders the exposed
  form **only** in the separate block; `ExposedFormPluginBase::renderExposedForm()` suppresses it
  inside the view itself. So the filters disappear from the results block — that is expected.
- The block is skipped for **disabled** views (`$view->status() === FALSE`).
- Rebuild the block plugin definitions after changing the option: `drush cr`
  (or `\Drupal::service('plugin.manager.block')->clearCachedDefinitions();`).
- `views_block_filter_block_form_views_exposed_form_alter()` sets
  `$form['actions']['reset']['#access']` to FALSE when the exposed form has no visible children,
  and never re-enables a Reset button that another module already disabled.
- Because the replacement class extends **ctools_views**' `Block` display plugin, per-block-instance
  overrides from ctools_views (items per page, offset, exposed filter overrides in block config)
  remain available.
- Known conflict from the project README: Views Bulk Operations-style bulk form submit handling can
  clash with the exposed form; test the combination before shipping.

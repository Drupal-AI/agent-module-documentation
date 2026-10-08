# Configure an Ajax block

There is **no module settings form**. All options are added per block onto the core block config
form. `block_ajax_entity_type_alter()` swaps the block entity's default form class to
`Drupal\block_ajax\Form\AjaxBlockForm` (extends core `BlockForm`), which appends an **"Ajax block"**
`details` fieldset (`src/Form/AjaxBlockForm.php::form()`). The fieldset's `#access` is gated by the
`administer ajax blocks` permission.

`configure` route = `block.admin_display` (Structure → Block layout). This module's route subscriber
(`AjaxBlockRouteSubscriber`) re-points that route's controller to `AjaxBlockListController::listing`,
which appends " (Ajax loaded)" to the label of blocks that have Ajax enabled.

## Where the settings live

Saved by `AjaxBlockForm::submitForm()` into the block config entity under
`settings['block_ajax']` (a normal block third-party/plugin setting — **not** a separate config
object, and the module ships **no config schema** for these keys).

## Form fields (all under `settings['block_ajax']`)

| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `is_ajax` | checkbox | `FALSE` | Master switch — load this block via Ajax. Everything below is `#states`-hidden until this is on. |
| `max_age` | select | `0` | Response/block max-age in seconds (options from `AjaxBlocks::getMaxAgeOptions()`; `0` = "No caching"). |
| `show_spinner` | checkbox | `FALSE` | Show an Ajax throbber while loading. |
| `placeholder` | textfield | `''` | Text shown in the throbber before the block loads. |
| `load_button` | checkbox | `FALSE` | Render a button and only load the block when it is clicked. |
| `load_button_text` | textfield | `Load block` | Button label (visible only when `load_button` on). |
| `refresh_block` | checkbox | `FALSE` | Re-fetch the block on an interval. |
| `refresh_interval` | number (ms) | `5000` | Interval when `refresh_block` on. |
| `context['context_type']` | select | `''` | One of `node` / `taxonomy_term` / `user` — attaches the current page's entity id so the block is fetched via a context route (see blocks/ajax-endpoint.md). |
| `ajax_defaults['method']` | radios | `POST` | `POST` or `GET` — jQuery `$.ajax` `type`. |
| `ajax_defaults['timeout']` | textfield (ms) | `10000` | jQuery `$.ajax` `timeout`. |
| `ajax_defaults['others']` | checkboxes | `async` off / `cache` off | `async` and `cache` flags fed to `$.ajax`. |

## Set it from PHP (drush php / update hook)

```php
$block = \Drupal::entityTypeManager()->getStorage('block')->load('mysite_myblock');
$settings = $block->get('settings');
$settings['block_ajax'] = [
  'is_ajax' => TRUE,
  'max_age' => 300,
  'show_spinner' => TRUE,
  'placeholder' => 'Loading…',
  'load_button' => FALSE,
  'refresh_block' => FALSE,
  'refresh_interval' => 5000,
  'context' => ['context_type' => 'node'],
  'ajax_defaults' => ['method' => 'POST', 'timeout' => 10000, 'others' => ['async' => 'async']],
];
$block->set('settings', $settings);
$block->save();
```

## Runtime / caching behavior

- `block_ajax_block_build_alter()`: for an Ajax block it forces `#cache['max-age']` to `0` (or the
  configured `max_age`) and adds the `block_ajax` cache tag, so the *placeholder* is not cached
  stale.
- `block_ajax_block_view_alter()`: replaces the block's `#theme` with `block_ajax_block`, attaches
  the `block_ajax/ajax_blocks` library and `drupalSettings.block_ajax`, and (for a context block)
  attaches the current node/user/term id. Rendering the block config entity is removed from the
  render array so the placeholder can be built without it.
- `AjaxBlocks::invalidateAjaxBlocks()` is called on save when `is_ajax` is on, invalidating the
  `block_ajax` cache tag.

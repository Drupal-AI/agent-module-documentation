<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How it works (mechanism)

Two form-alter hooks in `inline_block_title_automatic.module` delegate to one class,
`\Drupal\inline_block_title_automatic\FormAlter`. No config, schema, permission, or plugin.

## The hooks

```php
// inline_block_title_automatic.module
function inline_block_title_automatic_form_layout_builder_add_block_alter(&$form, $form_state, $form_id) {
  \Drupal::classResolver()->getInstanceFromDefinition(FormAlter::class)
    ->blockAddConfigureAlter($form, $form_state, $form_id);
}
function inline_block_title_automatic_form_layout_builder_update_block_alter(&$form, $form_state, $form_id) { /* same */ }
```

So it targets exactly the Layout Builder **Add block** (`layout_builder_add_block`) and
**Configure/Update block** (`layout_builder_update_block`) forms.

## FormAlter::blockAddConfigureAlter()

It acts only on `block_content` blocks — either:

- a reusable library block: `$form['settings']['provider']['#value'] === 'block_content'`, or
- an inline block: `isset($form['settings']['block_form']['#block']) &&
  $form['settings']['block_form']['#block'] instanceof \Drupal\block_content\Entity\BlockContent`.

For those it:

- `$form['settings']['label']['#type'] = 'value';` — hides the placement label ("Title") field
  (still submitted, just not editable), defaulting it to `'Inline block'` when empty.
- `$form['settings']['label_display']['#type'] = 'value';` and
  `$form['settings']['label_display']['#default_value'] = FALSE;` — hides the "Display title"
  checkbox and forces the title **not** to display.

Other block types (system blocks, views blocks, etc.) are untouched.

## Observing / verifying it (no persistent state)

Because it is a pure runtime form alter, there is nothing stored in config to inspect. To
confirm it is in effect, build the real Add block form for an inline block on a
Layout-Builder-enabled display and check the element types:

```php
$manager = \Drupal::service('plugin.manager.layout_builder.section_storage');
$display = \Drupal::entityTypeManager()->getStorage('entity_view_display')
  ->load('node.<bundle>.default');                 // must be Layout-Builder-enabled
$storage = $manager->load('defaults', ['display' => \Drupal\Core\Plugin\Context\EntityContext::fromEntity($display)]);
$form = \Drupal::formBuilder()->getForm('Drupal\layout_builder\Form\AddBlockForm', $storage, 0, 'content', 'inline_block:basic');

$form['settings']['label']['#type'];            // 'value'  (module active) vs 'textfield' (core)
$form['settings']['label_display']['#type'];    // 'value'
$form['settings']['label_display']['#default_value']; // FALSE
$form['settings']['label']['#default_value'];   // 'Inline block'
```

If the module were disabled, `label` would be a `textfield` and `label_display` a `checkbox`.

## Enabling it elsewhere

There is no configuration; the behavior applies wherever Layout Builder places a `block_content`
block once the module is enabled. To get it on a content type, enable Layout Builder on that
type's view display (`$display->enableLayoutBuilder()->save()`).

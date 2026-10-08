# Block Form Alter — manual setup guide

**Block Form Alter** (`block_form_alter`) is a small developer-focused module that
makes altering block configuration forms straightforward. In Drupal, a block's
settings form is rendered by several different subsystems — the Block module, Block
Content, and Layout Builder — and the block's plugin is not consistently available,
so writing a `hook_form_alter()` that reliably targets one kind of block means a lot
of fiddly detection code. This module does that detection once and gives you two
clean hooks instead.

The two hooks it provides are **`hook_block_plugin_form_alter()`**, which fires for
block *plugins* (any plugin except content/inline blocks) and hands you the plugin
id, and **`hook_block_type_form_alter()`**, which fires for custom *content block*
forms — the `block_content` and `inline_block` plugins, including inline blocks
placed through Layout Builder — and hands you the block bundle machine name. In both
cases the module works out which subsystem rendered the form, resolves the block's
plugin id or bundle, and re-dispatches to your hook, so the same code path works
whether the block was placed via Block layout or Layout Builder.

There is nothing to configure — the module has no admin UI, no settings, no
permissions and no services. It exists purely as a convenience API for module
developers, and notably works around core issue
[#3028391](https://www.drupal.org/project/drupal/issues/3028391) ("It's very
difficult to alter forms of inline (content blocks) placed via Layout Builder"). It
depends on core's Block module.

This guide is written for a **human** developer. If you want terse, token-cheap
references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is no admin interface. You use the module by implementing one of its two hooks
in your own custom module, then clearing caches (`drush cr`) so the hook is
discovered.

**Altering a block plugin's form** — for system blocks, views blocks, webform
blocks, your own plugins, and so on:

```php
/**
 * Implements hook_block_plugin_form_alter().
 */
function my_module_block_plugin_form_alter(array &$form, \Drupal\Core\Form\FormStateInterface &$form_state, string $plugin) {
  if ($plugin === 'webform_block') {
    $form['settings']['redirect']['#default_value'] = TRUE;
    $form['settings']['redirect']['#disabled'] = TRUE;
  }
}
```

**Altering a custom content block's form** — the `block_content` and `inline_block`
plugins, including inline blocks added through Layout Builder. The third argument is
the block bundle machine name:

```php
/**
 * Implements hook_block_type_form_alter().
 */
function my_module_block_type_form_alter(array &$form, \Drupal\Core\Form\FormStateInterface &$form_state, string $block_type) {
  if ($block_type === 'accordion') {
    $form['field_example']['widget'][0]['value']['#default_value'] = 'A better default value';
  }
}
```

**Which hook to use:** if you are targeting a block *plugin* (system, views block,
webform block, a custom plugin), use `hook_block_plugin_form_alter()`. If you are
targeting a *content block* or *inline block* — anywhere, including Layout Builder —
use `hook_block_type_form_alter()`. The plugin-level hook deliberately skips the
`block_content` and `inline_block` plugin ids, so those always flow through the
block-type hook.

For the full detail of when each hook fires and how dispatch works internally, see
the sibling [`agent/hooks/block-form-alter.md`](../agent/hooks/block-form-alter.md)
doc.

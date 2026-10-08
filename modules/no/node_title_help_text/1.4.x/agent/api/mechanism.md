<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How it works (hooks)

The whole module is `node_title_help_text.module` (a handful of hooks) plus a one-key config
schema. No services, plugins, or classes.

## Storing the text (node type form)

- `node_title_help_text_form_node_type_form_alter()` adds
  `$form['submission']['title_help']` (a textarea) to the node type edit form and registers
  an entity builder.
- `node_title_help_text_form_node_type_form_builder()` writes the submitted value onto the
  node type: `$type->setThirdPartySetting('node_title_help_text', 'title_help', <value>)`.

## Applying the text (node add/edit form)

`node_title_help_text_form_node_form_alter()` (a `hook_form_BASE_FORM_ID_alter` for
`node_form`):

```php
$node_type = $node->type->entity;
$description = $node_type->getThirdPartySetting('node_title_help_text', 'title_help');
if ($description) {
  $widget =& $form['title']['widget'];
  if (empty($widget[0]['value']['#description'])) {   // only if not already set
    $widget[0]['value']['#description'] = $description;
  }
}
```

So it never overrides an existing title description.

## Inline Entity Form support

`node_title_help_text_inline_entity_form_entity_form_alter()` does the same for IEF: for
`node` entity forms it loads the bundle's `NodeType`, reads `title_help`, and sets it as the
title widget `#description` (again only if empty).

## Install/uninstall

`hook_uninstall()` loops every `NodeType` and calls
`unsetThirdPartySetting('node_title_help_text', 'title_help')`. `hook_update_8001` migrated
old `\Drupal::state()` values into the third-party setting.

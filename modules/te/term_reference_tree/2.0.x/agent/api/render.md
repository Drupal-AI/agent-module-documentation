<!--
SPDX-FileCopyrightText: © 2025 Agent Module Documentation contributors
SPDX-License-Identifier: GPL-2.0-or-later
-->
# API: `checkbox_tree` element & helpers in custom code

The module exposes no services, hooks (`*.api.php`), or plugin managers. Its two reusable
programmatic surfaces are the `checkbox_tree` render element and the `term_tree_list` theme.

## Use the `checkbox_tree` element in a custom form

Build a hierarchical taxonomy selector without a field. The element loads the term
hierarchy for each vocabulary you pass in `#vocabularies`.

```php
use Drupal\taxonomy\Entity\Vocabulary;

$form['sections'] = [
  '#type' => 'checkbox_tree',
  '#title' => $this->t('Sections'),
  '#vocabularies' => Vocabulary::loadMultiple(['sections']),
  '#default_value' => [],            // array of ['target_id' => $tid]
  '#value_key' => 'target_id',
  '#max_choices' => -1,              // -1 = unlimited (checkboxes); 1 = radios
  '#start_minimized' => TRUE,
  '#leaves_only' => FALSE,
  '#select_parents' => FALSE,
  '#select_all' => FALSE,
  '#cascading_selection' => 0,       // 0 none | 1 select+deselect | 2 select | 3 deselect
  '#max_depth' => 0,                 // 0 = unlimited
];
```

The submitted value is an array of `['target_id' => $tid]` items (matching an
entity_reference field value). The widget's own
`TermReferenceTree::validateTermReferenceTreeElement()` is a reference for how selected
checkboxes are flattened back into that shape (and how `select_parents` + `leaves_only`
inject ancestors).

## Render selected terms as a tree (`term_tree_list`)

The formatter themes values via `#theme => 'term_tree_list'`; call it directly with an
array of `['target_id' => $tid]` items:

```php
$build['tags'] = [
  '#theme' => 'term_tree_list',
  '#data' => [['target_id' => 12], ['target_id' => 34]],
  '#attached' => ['library' => ['term_reference_tree/term_reference_tree_css']],
];
```

## Helper functions (`term_reference_tree.module`)

Procedural helpers used internally — available if you build on the element:

- `_term_reference_tree_get_term_hierarchy($tid, $vid, &$allowed, $filter, $label, $default)`
  — returns a vocabulary's nested term hierarchy as a render array.
- `_term_reference_tree_get_children($tid, $vid)` — direct children of a term.
- `_term_reference_tree_flatten($element, $form_state)` — flatten a processed tree element
  into its leaf checkbox/radio elements.
- `template_preprocess_checkbox_tree*()` — preprocess callbacks for the tree Twig templates.

No other public API: no config to write beyond the field-display component (see
[configure/widget.md](../configure/widget.md)), no events, no Drush.

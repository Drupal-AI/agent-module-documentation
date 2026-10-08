<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraphs & Inline Entity Form variants

Besides the main `@FormAlter` type, the module bridges two nested-subform systems to their
own plugin managers. All three plugin types share the discovery directory
`src/Plugin/FormAlter/` and the `formAlter(&$form, $form_state, $form_id)` signature; only the
annotation and matching keys differ.

## ParagraphsFormAlter (`plugin.manager.form_alter.paragraphs`)

Matches Paragraphs subforms by **`paragraph_type`**. pluginformalter hooks the various
Paragraphs widget alters (`hook_field_widget_paragraphs_form_alter`,
`…single_element_paragraphs_form_alter`, entity_reference / browser variants) and, when the
element carries `#paragraph_type`, asks this manager for matching plugins.

```php
/**
 * @ParagraphsFormAlter(
 *   id = "my_teaser_paragraph_alter",
 *   label = @Translation("Alter the teaser paragraph subform"),
 *   paragraph_type = { "teaser" },
 *   weight = 0
 * )
 */
```

A plugin with **no** `paragraph_type` matches every paragraph subform; otherwise the value
(wildcards allowed) is matched against the element's `#paragraph_type`.

## InlineEntityFormAlter (`plugin.manager.form_alter.ief`)

Matches Inline Entity Form subforms by a set of properties. pluginformalter implements
`hook_inline_entity_form_entity_form_alter()` (`type = entity_form`, with `entity_type` +
`bundle`), `hook_inline_entity_form_reference_form_alter()` (`type = reference_form`, with
`entity_type`), and `hook_inline_entity_form_table_fields_alter()` (`type = table_fields`).

```php
/**
 * @InlineEntityFormAlter(
 *   id = "my_ief_product_alter",
 *   type = "entity_form",
 *   entity_type = "commerce_product",
 *   bundle = "default",
 *   weight = 0
 * )
 */
```

Annotation keys: `type` (`entity_form`|`reference_form`|`table_fields`), `entity_type`,
`bundle` (use `*` to inherit the runtime bundle), `field_name`, `allowed_bundles`,
`parent_entity_type`, `parent_bundle`, `weight`. `InlineEntityFormAlterManager::getInstance()`
keeps only plugins whose declared `type`/`entity_type`/`parent_entity_type`/`bundle` all
match the current options (a `table_fields` plugin matches on any non-empty subset).

## Requirements

The Paragraphs variant only fires when the **Paragraphs** module supplies the widgets; the
IEF variant only when **Inline Entity Form** is present. The same Drupal ≥ 11.2 deprecation
applies to these plugins too.

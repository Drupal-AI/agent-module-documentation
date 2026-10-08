<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# NodeToText — one node field to plain text

Class `Drupal\entity_to_text\Extractor\NodeToText` (`src/Extractor/NodeToText.php`), service id
**`entity_to_text.extractor.node_to_text`**. Constructor args (from `entity_to_text.services.yml`):
`@entity_to_text.htmlpurifier`, `@renderer`, `@plugin.manager.field.field_type`.

## Method

`public function fromFieldtoText(string $field_name, NodeInterface $node): string`

Steps (source):
1. `$node->getFieldDefinition($field_name)` → resolve the field type definition via
   `FieldTypePluginManagerInterface::getDefinition()`. If the field/type is unknown, returns `''`.
2. Builds display options `['label' => 'hidden', 'type' => $field_type_definition['default_formatter']]`
   — i.e. renders with the field type's **default formatter**.
3. If `$node->get($field_name)->isEmpty()`, returns `''`.
4. `$field->view($display_options)` → `renderer->renderRoot($view)` to produce markup.
5. Passes the markup through `HtmlPurifier::init()->purify(...)` (handles both `Markup` objects and
   plain strings) and returns `trim($clean_html)`.

Because the purifier config allows **zero** elements and properties, the result is the field's
visible text with all HTML/CSS removed.

## Usage

```php
$text = \Drupal::service('entity_to_text.extractor.node_to_text')
  ->fromFieldtoText('body', $node);
```

## Notes

- Node-only: the signature is typed to `\Drupal\node\NodeInterface`; other entity types are not accepted
  by this service (use `ParagraphsToText` / `FileToText` submodules for those cases).
- Renders one field per call. Loop over field names to build a full document.
- No access checking is performed here; the caller is responsible for loading/permitting the node.

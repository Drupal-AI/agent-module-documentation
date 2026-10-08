<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# First Paragraph — agent index

A field **formatter showing the first paragraph of text** (auto teaser/summary — opening paragraph vs manual
summary/truncation). Depends on core `field`. Version **2.1.0** (branch 2.1.x). Core `^10.3||^11||^12`.

Content-display/formatter — renders authored content (first paragraph); no access role.

## Mechanism

- Formatter plugin `text_first_para` (label "First Paragraph"), applicable to `text`, `text_long`,
  `text_with_summary` field types. Class `Drupal\first_paragraph\Plugin\Field\FieldFormatter\TextFirstPara`,
  declared with the `#[FieldFormatter]` PHP attribute; extends `FormatterBase`.
- Per field item: renders the value through `#type => 'processed_text'` (applies the item's text format),
  loads the resulting HTML with `Html::load()`, takes the **first `<p>` element** via
  `getElementsByTagName('p')->item(0)`, and re-emits that one paragraph again through
  `#type => 'processed_text'` with the same `#format` and `#langcode`.
- No paragraph present → element is `['#markup' => '']` (empty output).
- Injects the core `renderer` service (constructor + `create()`).

## Notes for agents

- Configuration is per-field-display only (Manage display → pick the formatter); no settings form, no route,
  no permission, no service, no config-entity of its own. `provides_config_schema` reflects the standard
  formatter third-party settings surface, not a custom schema file.
- Requires the PHP DOM extension (`ext-dom` in composer.json).
- Output is sanitized by the field's own text format (processed twice through `processed_text`); it does not
  bypass or re-open filtering. Ships a kernel test asserting disallowed markup is stripped.

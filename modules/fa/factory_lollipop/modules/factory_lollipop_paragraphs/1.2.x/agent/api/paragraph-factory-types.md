<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraph FactoryTypes

Two `FactoryTypeInterface` implementations registered on the parent module's chain resolver (tag
`factory_lollipop.factory_type_resolver`, priority 245). They behave like any built-in FactoryType — see
the parent's [../../../1.2.x/agent/api/factory-types.md](../../../1.2.x/agent/api/factory-types.md).

## ParagraphTypeFactoryType — `paragraph type`

File: `src/FactoryType/ParagraphTypeFactoryType.php`. Uses `RandomGeneratorTrait`.

- `shouldApply($type)` → `$type === 'paragraph type'`.
- `create($attributes)` → casts attributes to array; `id` defaults to `mb_strtolower(randomMachineName())`
  and `label` to `randomString()` when absent. Loads `paragraphs_type` storage lazily; if a
  `paragraphs_type` with that `id` already exists it is returned unchanged, otherwise it is created (with
  any extra `$attributes` merged in) and saved. Returns `\Drupal\paragraphs\Entity\ParagraphsType`.
- `getIdentifier()` → the paragraph type id.

## ParagraphFactoryType — `paragraph`

File: `src/FactoryType/ParagraphFactoryType.php`.

- `shouldApply($type)` → `$type === 'paragraph'`.
- `create($attributes)` → casts to array; **requires** a non-empty `type` (else
  `\InvalidArgumentException('The type attribute is mandatory.')`). Loads `paragraphs_type` storage and
  requires the type to exist (else `\InvalidArgumentException('The type attribute must be an existing
  Paragraph Type.')`). Loads `paragraph` storage lazily, creates the entity with `$attributes` merged
  over `['type' => ...]`, saves it, and returns `\Drupal\paragraphs\Entity\Paragraph`.
- `getIdentifier()` → the paragraph id.

## Usage

```php
$factory->define('paragraph type', 'accordion_type', ['id' => 'accordion', 'label' => 'Accordion']);
$factory->define('paragraph', 'accordion', [
  'type' => $factory->association('accordion_type'), // ensures the type exists, binds its id
]);
$paragraph = $factory->create('accordion', ['field_title' => 'FAQ']);
```

Reference blueprints live in the submodule's test fixtures
(`modules/factory_lollipop_paragraphs/tests/modules/factory_lollipop_paragraphs_test/src/Factories/`).

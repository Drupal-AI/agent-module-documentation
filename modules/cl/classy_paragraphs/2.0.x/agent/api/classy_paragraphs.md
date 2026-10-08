# classy_paragraphs — API

Small surface: one config entity + one view alter. No services, no Drush, no hooks invited
(`.api.php` does not exist).

## Config entity: `classy_paragraphs_style`

- Class: `Drupal\classy_paragraphs\Entity\ClassyParagraphsStyle`
  implements `Drupal\classy_paragraphs\ClassyParagraphsStyleInterface` (extends `ConfigEntityInterface`).
- Properties: `id`, `label`, `classes` (string, one class per line), `uuid`.
- Public method: `getClasses(): ?string` — returns the raw newline-separated classes string
  (or NULL). There is no setter; set `classes` via the entity array on create, or the admin form.

Load / create / delete:

```php
$storage = \Drupal::entityTypeManager()->getStorage('classy_paragraphs_style');
$style   = $storage->load('loud');           // ClassyParagraphsStyle|null
$classes = $style->getClasses();             // "loud-background\ntext-uppercase"
$storage->create(['id' => 'soft', 'label' => 'Soft', 'classes' => 'soft-background'])->save();
$storage->load('soft')->delete();
```

## Render behavior: `classy_paragraphs_entity_view_alter()`

Implemented in `classy_paragraphs.module`. On **every** entity view build it:

1. Scans the entity's field definitions for reference fields whose storage setting
   `target_type === 'classy_paragraphs_style'` (works on any entity type, not just paragraphs).
2. For each non-empty such field, loads the referenced style entities.
3. Splits each style's `getClasses()` on `\r\n` and **merges** the resulting classes into
   `$build['#attributes']['class']` (appending to any existing classes).

So the classes are applied through the render array's attributes — reaching
`{{ attributes.class }}` / `{{ attributes.addClass(classes) }}` in the template. Nothing is
printed as field output (hide the field in *Manage display*).

Caveat: classes are split on the literal sequence `\r\n`; styles saved with `\n`-only line
endings still yield one class per non-empty segment via the merge, but authoring one class
per line (CRLF from the textarea) is the intended path. Bypassed when Display Suite or
Panelizer render the paragraph.

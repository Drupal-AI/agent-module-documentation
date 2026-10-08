<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# section_library — programmatic API

There is no custom service or Drush command. You work directly with the
`section_library_template` content entity via the entity type manager. The payload is
the `layout_section` field, whose value is a Layout Builder `Section` object.

## Create a template in PHP

```php
use Drupal\layout_builder\Section;

$template = \Drupal::entityTypeManager()
  ->getStorage('section_library_template')
  ->create([
    'label'       => 'Hero + CTA',
    'type'        => 'template',          // 'section' (one) or 'template' (whole page)
    'entity_type' => 'node',              // required: where it was captured from
    'entity_id'   => 1,                   // required
    'layout_section' => [
      // One Section per array item; the field is unlimited-cardinality.
      new Section('layout_onecol'),
      // new Section('layout_twocol_section', [], [$componentUuid => $component]),
    ],
  ]);
$template->save();
```

`user_id` defaults to the current user (`preCreate()`); `created`/`changed` are automatic.
`label` is required (max 50 chars); `type`, `entity_type`, `entity_id` are effectively
required for a well-formed template. A `Section` is
`new Section($layout_id, $layout_settings = [], $components = [])`, where each component is
a `Drupal\layout_builder\SectionComponent`.

## Load & inspect

```php
$storage = \Drupal::entityTypeManager()->getStorage('section_library_template');

foreach ($storage->loadMultiple() as $t) {
  $label = $t->label();
  $kind  = $t->get('type')->value;                 // 'section' | 'template'
  $count = count($t->get('layout_section')->getValue());

  // Get the Section object(s) from the layout_section field items:
  foreach ($t->get('layout_section') as $item) {
    /** @var \Drupal\layout_builder\Section $section */
    $section = $item->section;                      // computed 'section' property
    $layoutId = $section->getLayoutId();            // e.g. 'layout_onecol'
    $components = $section->getComponents();         // SectionComponent[]
  }
}
```

**Key gotcha:** on a `layout_section` field item the `Section` object is exposed as the
computed property `$item->section` (a `LayoutSectionItem`). There is no `getSection()`
method on the item.

## Query for a specific template

```php
$ids = \Drupal::entityTypeManager()->getStorage('section_library_template')
  ->getQuery()->accessCheck(FALSE)
  ->condition('label', 'Hero + CTA')
  ->condition('type', 'template')
  ->execute();
```

## How import works (deep clone)

When an editor imports a template, `ImportSectionFromLibraryController` uses
`DeepCloningTrait` (`deepCloneSection()` / `deepCloneSections()`) to copy the stored
sections into the target layout: it regenerates section/component UUIDs and, for **inline**
(non-reusable) blocks, creates **new** `block_content` instances so the imported copy is
fully independent of the original template and of any other layout it was imported into.
Reusable blocks are referenced as-is.

## Delete

```php
$storage->load($id)->delete();
```

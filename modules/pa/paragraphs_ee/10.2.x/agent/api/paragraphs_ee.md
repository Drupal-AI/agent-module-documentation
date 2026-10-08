<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# API — off-canvas browser controller & category entity

## Off-canvas browser route & controller

Route `paragraphs_ee.paragraphs_browser`
(`/paragraphs_ee/browser/{entity_type}/{bundle}/{form_mode}/{field_name}`,
requirement `_permission: access content`) is served by
`\Drupal\paragraphs_ee\Controller\ParagraphsOffCanvasBrowser`
(`src/Controller/ParagraphsOffCanvasBrowser.php`, interface
`ParagraphsOffCanvasBrowserInterface`). It renders the paragraph-type picker markup that the
off-canvas dialog loads over AJAX; the actual add action still fires against the original field
widget on the host entity form (see `js/paragraphs_ee.off_canvas.js`).

Key methods:
- `content()` — returns `[]` (empty) unless `getComponent()` finds the field component **and**
  its `third_party_settings.paragraphs_ee.paragraphs_ee.dialog_off_canvas` is `TRUE`, and the
  field renderer is a `ParagraphsWidget` with `add_mode === 'modal'`. It creates an empty entity
  of `{entity_type}`/`{bundle}`, builds the widget form, and returns the `add_more` element as
  `build['dialog']` with libraries `paragraphs_ee.categories` + `paragraphs_ee.off_canvas`.
- `getTitle()` — "Add @widget_title" (or "Add Paragraph" fallback).
- `getFormDisplay()` / `getComponent()` / `getWidget()` — resolve the `entity_form_display`
  `entity_type.bundle.form_mode`, its component, and the field renderer.
- `hasDialogOffCanvas()` (protected) — the guard that gates all of the above on the off-canvas
  third-party setting.

## Paragraphs category config entity

`\Drupal\paragraphs_ee\Entity\ParagraphsCategory` (`src/Entity/ParagraphsCategory.php`,
interface `ParagraphsCategoryInterface`) is a `ConfigEntityType` (id `paragraphs_category`,
prefix `paragraphs_category`, `admin_permission: administer paragraphs categories`). Load via
the `paragraphs_category` storage:

```php
$categories = \Drupal::entityTypeManager()->getStorage('paragraphs_category')->loadMultiple();
uasort($categories, [\Drupal\paragraphs_ee\Entity\ParagraphsCategory::class, 'sort']); // by weight
```

Methods:
- `getDescription(): string` — renders the stored `{value, format}` description through
  `processed_text` (in isolation). Legacy plain-string descriptions are normalised to the
  default filter format on read.
- `getDescriptionFormat(): ?string` — the description's filter format id (default format if
  unset).
- `getWeight(): int` — sort weight (default 0).

Category membership of a paragraph type is stored on the **paragraphs_type** entity as the
third-party setting `paragraphs_ee.paragraphs_categories` (array of category ids), written by
`FormHooks::paragraphsTypeFormBuilder()`.

## Widget helper

`\Drupal\paragraphs_ee\ParagraphsEE` (`src/ParagraphsEE.php`) — static helpers
`registerWidgetFeatures(array &$elements, ParagraphsWidget $widget)` (drag&drop library + item
classes) and `addAdminThemeAccents(array &$elements)` (Gin / Default Admin accent library),
both called from `FormHooks::fieldWidgetCompleteFormAlter()`.

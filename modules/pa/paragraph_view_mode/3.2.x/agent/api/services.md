<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services & runtime mechanism

Three services, no plugin manager, no events.

| Service id | Class | Interface |
|---|---|---|
| `paragraph_view_mode.storage_manager` | `StorageManager` | `StorageManagerInterface` |
| `paragraph_view_mode.checker.widget_settings` | `Checker\WidgetSettingsChecker` | `WidgetSettingsCheckerInterface` |
| `paragraph_view_mode.matcher.display_mode` | `Matcher\DisplayModeMatcher` | `DisplayModeMatcherInterface` |

## `StorageManagerInterface` constants (the magic strings)

```php
ENTITY_TYPE = 'paragraph';
CONFIG_NAME = 'paragraph_view_mode';
FIELD_NAME  = 'paragraph_view_mode';   // = CONFIG_NAME
FIELD_TYPE  = 'paragraph_view_mode';   // = FIELD_NAME
FIELD_LABEL = 'Paragraph view mode';
```

Methods: `addField(string $bundle): bool`, `getField(string $bundle): ?FieldConfigInterface`,
`deleteField(string $bundle): bool`, `addToFormDisplay(string $bundle, string $form_mode =
'default'): void`, `getFieldStorage(): EntityInterface`, `createFieldStorage():
EntityInterface`. `addToFormDisplay()` sets the component with `weight => -100` and
`ParagraphViewModeWidget::defaultSettings()`.

## `WidgetSettingsCheckerInterface`

- `hasFormModeBindEnabled(string $form_mode, ParagraphInterface $p): bool` — reads
  `form_mode_bind` from the component in the paragraph's **`$form_mode`** form display.
- `hasApplyToPreviewEnabled(ParagraphInterface $p): bool` — reads `apply_to_preview` from the
  **default** form display.

## `DisplayModeMatcherInterface`

- `matchViewForModeAndEntity(string $mode, EntityInterface $e): ?string`
- `matchFormForModeAndEntity(string $mode, EntityInterface $e): ?string`

Both return `NULL` (= "leave the mode alone") unless every condition holds.

## The runtime path

`paragraph_view_mode.module` implements exactly two alter hooks plus the paragraph-type form
alter:

```php
hook_entity_view_mode_alter(&$view_mode, $entity)  →  matcher->matchViewForModeAndEntity()
hook_entity_form_mode_alter(&$form_mode, $entity)  →  matcher->matchFormForModeAndEntity()
```

`matchViewForModeAndEntity()` returns `NULL` — no override — when **any** of these is true:

1. `$entity` is not a `ParagraphInterface`.
2. the requested mode is `preview` **and** `apply_to_preview` is FALSE (the guard that keeps
   Paragraphs' own preview working);
3. the paragraph has no `paragraph_view_mode` field.

Otherwise it returns `$paragraph->get('paragraph_view_mode')->value ?: $mode` — i.e. the stored
value, falling back to the requested mode when the field is empty.

`matchFormForModeAndEntity()` runs the same match first, then additionally returns `NULL` if
`form_mode_bind` is FALSE for that form mode. So the form mode is only swapped when the site
builder opted in, and only to a form mode whose machine name equals the chosen view mode
(non-existent form modes simply fall back to `default` in core).

The widget supplies the other half of form-mode binding: when `form_mode_bind` is on it adds an
`#ajax` change handler (`ParagraphViewModeWidget::reloadSubform`) that rebuilds the paragraph
subform, which is what causes `hook_entity_form_mode_alter()` to fire again.

## `Enum\ViewModes` / `Enum\WidgetSettings`

Final classes of constants (not real PHP enums):

```php
ViewModes::DEFAULT = 'default';  ViewModes::PREVIEW = 'preview';
WidgetSettings::VIEW_MODES = 'view_modes';
WidgetSettings::DEFAULT_VIEW_MODE = 'default_view_mode';
WidgetSettings::FORM_MODE_BIND = 'form_mode_bind';
WidgetSettings::APPLY_TO_PREVIEW = 'apply_to_preview';
```

`Drupal\paragraph_view_mode\ViewModeInterface` is **deprecated** (removed in 3.2.0 per its
docblock) — use `Enum\ViewModes`.

## Reading a paragraph's chosen mode

```php
$mode = $paragraph->get('paragraph_view_mode')->value;   // e.g. 'teaser'
```

Stored in the ordinary field table `paragraph__paragraph_view_mode`, column
`paragraph_view_mode_value`.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Allowed Text Format Field Widget (allowed_text_format_field_widget) — agent index

A single field **widget**, `allowed_text_format_field_widget` (label **"Allowed Text Format"**),
for the **`text_long`** field type only. It extends core's `TextareaWidget` and lets the widget's
settings decide which text formats appear in that field's format selector. Depends on core `field`
and `filter`. Version **1.1.0-rc1** (release candidate). Core requirement `^8 || ^9 || ^10 || ^11`.
No config UI page, no permissions, no Drush, no ships-with config schema.

## Mechanism (read the source: `src/Plugin/Field/FieldWidget/AllowedTextFormatFieldWidget.php`)
- `settingsForm()` adds a `#type => checkboxes` element (setting key `allowed_format`) whose
  `#options` are every `filter_format` entity's **label**, keyed by format **machine name**.
- `defaultSettings()` defaults `allowed_format` to *all* available formats.
- `getAllowedTextFormats()` = `array_intersect_key(all_formats, array_filter(selection))`; an empty
  selection falls back to **all** formats.
- `formElement()` calls the parent, then sets `$element['#allowed_formats'] = array_keys(getAllowedTextFormats())`.
- `settingsSummary()` appends `Allowed formats : <labels>`.

## What core does with `#allowed_formats`
`\Drupal\filter\Element\TextFormat::processFormat()` first calls
`getFormatsForAccount($user)` (only formats **this user may use**), then
**`array_intersect_key($formats, array_flip($element['#allowed_formats']))`**. So the offered list
is `builder allowlist ∩ user-permitted formats`.

## Keep this distinction clear — it is what the module is easy to misread as
- **It narrows what is offered, not what is permitted.** Core still intersects with the user's
  permitted formats; the widget can never *add* a format the user lacks the `use text format X`
  permission for. If a user has access to **none** of the allowed formats, core disables the widget
  and shows an access-denied notice — a graceful fallback handled by core, not this module.
- The security boundary remains the **text format's filter chain** and the format-use permissions.
- Anything writing to the field **outside this widget** — a migration, **JSON:API**, a webform
  handler, a second form display without this widget — is unaffected.
- Only `text_long`. Not `text_with_summary` (standard Body) and not single-line `text`.

Treat it as **content-model enforcement and editorial guidance**, never as a control that stops
someone using a format they hold the permission for.

## Map
- `usage.md` — short + dense + use-case bullets.
- `agent/fields/restrict-text-formats.md` — how to apply it and what each setting does.

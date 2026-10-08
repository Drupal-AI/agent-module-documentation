<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media File Formatters (mff) — agent index

Two field formatters for core **`file`** fields. Package `Media`. Core requirement
`^8.8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 8.x-1.0-alpha3.
No dependencies beyond core `file`. **No routes, permissions, services, or Drush.**

- **Both formatters, every setting, how to enable them on a field** →
  [fields/formatters.md](fields/formatters.md)

## What it actually is

- Two `@FieldFormatter` plugins in `src/Plugin/Field/FieldFormatter/`, both with
  `field_types = { "file" }` (core file fields only — not media reference fields, despite the
  "Media File Formatters" name / `Media` package):
  - **`mff_name_link_formatter`** — label *"Name field link text"*, class `MffNameLinkFormatter`
    (extends core `FileFormatterBase`). Renders a `#theme => 'file_link'` whose link text is the
    **parent entity's** `label()`. Setting `open_in_new_window` adds `target="_blank"`.
  - **`mff_description_formatter`** — label *"File field description text"*, class
    `MffDescriptionFormatter` (extends core `DescriptionAwareFileFormatterBase`). Renders the file
    item's **description**: as `file_link` link text when `use_description_as_link_text` is on,
    otherwise as a `#type => 'processed_text'` element with **no link**.
- It changes only how a file field is **displayed**. Chosen per view-display on *Manage display*.

## Mechanism (from source)

- Both `viewElements()` iterate `getEntitiesToView($items, $langcode)` (core file access + display
  flags honored), attach `$file->getCacheTags()`, and forward any `$item->_attributes` to the
  element (unsetting them afterward so they aren't double-rendered by the field template).
- `MffNameLinkFormatter` reads the parent via `$item->getEntity()->label()` for `#description`,
  and passes `#link_options` with `attributes.target=_blank` when open-in-new-window is set.
- `MffDescriptionFormatter` reads `$item->description`; in text mode it sets
  `#langcode => $item->getLangcode()` and lets core's processed-text element render it.

## Settings (from `defaultSettings()`)

- `mff_name_link_formatter`: `open_in_new_window` (bool, default FALSE) — schema at
  `field.formatter.settings.mff_name_link_formatter` (`config/schema/mff.schema.yml`).
- `mff_description_formatter`: `use_description_as_link_text` (bool, default FALSE) — **no config
  schema** for this key.

## Files

- `mff.info.yml`, `mff.module` (only `hook_help`), `config/schema/mff.schema.yml`,
  `src/Plugin/Field/FieldFormatter/MffNameLinkFormatter.php`,
  `src/Plugin/Field/FieldFormatter/MffDescriptionFormatter.php`. README points at sandbox
  `drupal.org/sandbox/imclean/3051849`.

## Notes / caveats

- The `Media`/"Media File Formatters" naming is aspirational: the plugins bind to core **`file`**
  fields, not to media-reference fields.
- Open-in-new-window historically relied on core patch `#2727281`; behavior depends on your core
  `file_link` theme handling `#link_options`.
- Description-text mode renders `processed_text` **without** an explicit `#format`, so core applies
  the fallback text format.

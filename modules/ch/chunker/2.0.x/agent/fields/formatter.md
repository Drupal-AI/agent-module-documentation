<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Chunker field formatter

Everything Chunker does lives in one class:
`src/Plugin/Field/FieldFormatter/ChunkerFormatter.php` (plugin id `chunker`, extends
`FormatterBase`), applicable to field types `text_long` and `text_with_summary`.

## Install & enable
1. Install `drupal/chunker`, enable the `chunker` module (core only, no other deps).
2. Go to a bundle's **Manage display** (e.g. `/admin/structure/types/manage/article/display`).
3. For a long-text field, choose the **Chunker** formatter, open its settings gear, save.

There is no admin settings page; configuration is stored in the entity view display as
`field.formatter.settings.chunker`.

## Settings (`defaultSettings()` + `settingsForm()`)
Schema in `config/schema/chunker.schema.yml`:

| Key | Type | Default | Meaning |
|-----|------|---------|---------|
| `start_level` | integer | `2` | Heading level to wrap as a section: 2 or 3. Wrapping runs from this level **upward toward h1** (see below). |
| `section_tag` | string | `div` | Wrapper element. Form only offers `div`; an empty value skips the wrapper. |
| `section_class` | string | `chunker-section` | Class set on each wrapper (`#max_length` 32). |
| `permalink_string` | string | `''` | If non-empty, an `<a href="#id">` with this text is appended to each chunked heading (class `permalink`); blank = no permalink. |

`settingsSummary()` reports the level, tag, class, and permalink (or `<none>`).

Note: `enwrap()` also honours a `heading_class` setting if present in `$settings`, but no form field or
schema key exposes it, so it is effectively unused via the UI.

## How chunking works
`viewElements()` builds, per field item, a render array of
`['#type' => 'processed_text', '#text' => $this->chunkText($item->value, $settings), '#format' => $item->format, ...]`.
Because output goes through `processed_text` with the field's own format, filtering/escaping matches the
core default text formatter — Chunker only restructures the DOM.

`chunkText()`:
- Loads the HTML with `Html::load($text)` (DOMDocument), grabs the `<body>` scope.
- Loops `for ($recurse = start_level; $recurse > 1; $recurse--)` calling `enwrap($scope, $recurse, $settings)`.
  So with `start_level = 2` it wraps h2 sections; with `3` it first wraps h3s, then h2s — producing
  nested, hierarchical sections where higher headings contain their subsections.
- Returns `Html::serialize($dom)`.

`enwrap($scope, $start_level, $settings)`:
- `heading_tag = "h$start_level"`; `higher_tags` = all heading levels above it (used to stop a lower
  section from swallowing a higher heading).
- Snapshots `$scope->childNodes` into a plain array first (mutating a live DOMNodeList mid-iteration is
  unsafe), then walks the children:
  - A **higher-level heading** closes the current section (clone of scope) so nesting stays correct.
  - The **target heading** starts a new section: increments `section-N`, keeps an existing `id` or sets
    `section-$index`, creates the `section_tag` wrapper with `section_class`, appends the heading, and
    (if `permalink_string`) appends a space + `<a href="#id" class="permalink">`.
  - **Other content** is appended into the current section.

## Verified output (from the kernel test)
`tests/src/Kernel/ChunkerFormatterTest.php` confirms, with defaults, each `h2 … <p>` becomes
`<div class="chunker-section"><h2 id="s1">…</h2><p>…</p></div>`, and with
`section_tag=section, section_class=document-section, permalink_string=#` each heading gains
`<a href="#s1" class="permalink">#</a>` and wrappers become `<section class="document-section">`.

## Operating notes
- Works only on the listed text field types; the field must contain HTML headings at the chosen level.
- README caveats: assumes headings are not already wrapped in divs; changing heading tags to another
  element and accordion markup are not supported; chunking at level 3 is untested.
- Pairs well with themes/modules that add ToC, tabs, accordions, or previous/next navigation over the
  generated sections.

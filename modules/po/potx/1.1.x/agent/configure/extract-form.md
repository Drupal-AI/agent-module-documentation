<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Extract web form

potx has **no settings page** — its only UI is a one-shot extraction form.

- Form: `Drupal\potx\Form\PotxExtractTranslationForm` (form id `potx_extract_transation`).
- Route: `potx.extract_translation` → path `/admin/config/regional/translate/extract`.
- It appears as the **Extract** local task (tab) on the *User interface translation* page
  (`locale.translate_page`).
- Permission required: **`translate interface`** (core locale permission — potx defines none of
  its own).

## How it works

- `generateComponentList()` builds a directory tree of all **installed** modules and themes;
  `buildComponentSelector()` renders it as radio buttons grouped by directory (single-component
  dirs get one radio; multi-component dirs get a collapsible `details` fieldset with a
  "Extract from all in directory" option).
- If the site has more than one language (or a single non-English language), the form also shows:
  - **Template language** radios — a language-independent template or a language-dependent one
    (plural forms, language team name).
  - **Include translations** checkbox — export existing translations too (turns the download
    into a `.po` rather than a `.pot`).
- Submitting streams the generated file to the browser as a download (`.pot`, or `.po` when a
  language + translations are chosen). Validation requires a component to be selected.

Note: a blank white response usually means PHP's `memory_limit` is too low for the extraction.

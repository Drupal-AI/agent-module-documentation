# Configuration

ANT Custom Translations has a single admin form where you upload your dictionary
of custom translation overrides.

## Open the form

1. Log in as a user with the **`configure auto node translate custom`**
   permission. This permission is marked "restrict access", so it should be
   given only to trusted administrators.
2. Go to **`/admin/config/system/custom-translations`** (under Configuration →
   System).

## Upload your override spreadsheet

The form accepts a spreadsheet upload. Each row defines a **source → target**
translation pair: the phrase as it appears in your source language, and the
exact text it should become in the target language. The file is read with the
PhpSpreadsheet library, and the resulting pairs are stored in the module's
configuration (`auto_node_translate_custom.settings`).

Typical uses:

- Keep **brand and product names** rendered a fixed way (or untranslated)
  across languages.
- Maintain a **glossary** so key terminology is always translated consistently.
- **Override** the machine-translation provider's output for specific phrases
  that it gets wrong.

## How the overrides are applied

When the parent **Auto Node Translate** module auto-translates node content, it
consults this dictionary. Any term you listed is rendered exactly as you
specified, rather than however the machine-translation provider would render it.

## Updating the dictionary

To change your overrides, edit your spreadsheet and **re-upload** it on the same
form. It is worth reviewing the current dictionary before a large translation
run so you know which terms are pinned.

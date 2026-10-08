<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Google Translator

## Config object

Everything lives in **`google_translator.settings`** (config_object, schema in
`config/schema/google_translator.schema.yml`). Shipped defaults
(`config/install/google_translator.settings.yml`):

| Key | Type | Default | Meaning |
|---|---|---|---|
| `google_translator_active_languages_display_mode` | string | `SIMPLE` | Widget layout: `SIMPLE`, `HORIZONTAL`, or `VERTICAL`. |
| `google_translator_active_languages` | sequence of strings | `[pt, es]` | Google Translate short codes offered in the selector. |
| `google_translator_disclaimer_title` | label | `"Automatic translation disclaimer"` | Title of the disclaimer modal. |
| `google_translator_disclaimer` | text | (a default paragraph) | Modal body; if non-empty a modal is shown before translating. Admin-filtered HTML. |

Display modes: `SIMPLE` is the most compact; `HORIZONTAL` shows "Powered by Google" beside the
selector; `VERTICAL` shows it beneath.

## Settings form

Route **`google_translator.config`** at **`/admin/config/regional/google-translator`**
(`\Drupal\google_translator\Form\SettingsForm`, a `ConfigFormBase`). Fields: Display Mode
(radios), a "Languages configuration" details element with an "Available Languages" checkboxes
list (~100 Google languages), Service disclaimer title (textfield), Service disclaimer text
(textarea). The full langcode → name option list is the private `getAvailableLanguages()` method
on the form (codes like `zh-CN`, `zh-TW`, `pt`, `es`, `fr`, `de`, `ja`, `ar`, …).

## Drush / config workflow

```bash
# Read
drush cget google_translator.settings

# Set the display mode
drush cset google_translator.settings google_translator_active_languages_display_mode VERTICAL -y

# Replace the active languages list (sequence)
drush cset google_translator.settings google_translator_active_languages.0 fr -y
drush cset google_translator.settings google_translator_active_languages.1 de -y
```

Or in PHP:

```php
\Drupal::configFactory()->getEditable('google_translator.settings')
  ->set('google_translator_active_languages_display_mode', 'HORIZONTAL')
  ->set('google_translator_active_languages', ['fr', 'de', 'ja'])
  ->save();
```

The form's submit filters empty checkbox values with `array_values(array_filter(...))`, so the
saved sequence is a compact re-indexed list of the selected codes.

## Permission

`administer google_translator settings` (defined in `google_translator.permissions.yml`) gates the
form; the route also accepts core `administer site configuration`
(`_permission: 'administer site configuration+administer google_translator settings'`).

## Config translation

`google_translator.config_translation.yml` registers the settings for the Config Translation UI,
so the disclaimer text/title can be translated per language.

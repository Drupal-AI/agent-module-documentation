<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Hide Preview

## Where to set it
- **Route:** `hide_preview.settings` → path `/admin/config/hide_preview` (menu link under
  *Configuration › User interface*). Requires permission `administer site configuration`.
- **Form:** `Drupal\hide_preview\Form\HidePreviewConfigForm` (a `ConfigFormBase`).
- **Config object:** `hide_preview.settings`, single key `hide_preview.form_names` — a numeric
  array of pattern strings. No config schema ships, so this is stored schema-less.

The form field is one textarea, "Form names", **one pattern per line** (no commas). On submit,
lines are split on `\r\n`, empty/null lines filtered out, and saved to the array.

Set it with drush instead of the UI:
```
ddev drush cset hide_preview.settings hide_preview.form_names.0 '/contact_message_.*/' -y
ddev drush cset hide_preview.settings hide_preview.form_names.1 'node_article_edit' -y
```

## How a pattern matches a form (`hide_preview_form_alter`)
For each stored pattern `$name` and the current `$form_id`:
1. `@preg_match($name, $form_id, $matches)` runs. If it does **not** error and produces a
   non-empty `$matches`, the pattern is treated as a **regular expression** and the button is
   removed. (So a valid regex like `/contact_message_.*/` works; note a bare word like
   `node` is not a valid delimiter-wrapped regex, so it falls through to step 2.)
2. Otherwise `strpos($form_id, $name) !== FALSE` — a plain **substring** match anywhere in the
   form ID removes the button.

Because substring matching is used, a plain pattern `contact_message_` matches
`contact_message_feedback_form`, `contact_message_personal_form`, etc.

## What gets removed (`_hide_preview_remove_button`)
These form elements are unset when a form matches:
- `$form['actions']['preview']` — the standard core preview submit.
- `$form['actions']['preview_draft']` — preview-draft variants.
- `$form['meta']['preview']` — Gin admin theme preview button.
- `$form['top']['meta']['preview']` — Gin variation.

## Validation
`validateForm()` only errors on a line that **contains non-word characters** (`/[^\w]+/`) **and**
is not a compilable regex (`@preg_match($name, '') === FALSE` with a real `preg_last_error()`).
Plain word strings and valid regexes both pass. Finding the right `form_id` (e.g. via the HTML
`id`/`data-drupal-selector`, or `hook_form_alter` debugging) is up to you.

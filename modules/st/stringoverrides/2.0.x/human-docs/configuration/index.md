# Configuration

All of String Overrides' work happens on one form, per language.

## Open the overrides form

1. Make sure your account has the **Administer string overrides** permission
   (see below).
2. Go to **Configuration → Regional and language → String Overrides**
   (`/admin/config/regional/stringoverrides`). You land on your **default
   language's** overrides. On a multilingual site you can switch to another
   language's form from there, and each language keeps its own list.

## Add an override

The form is a table with these columns for each row:

- **Enabled** — tick to make this override active. Untick to keep the row but
  stop it applying (see "Disabling" below).
- **Original** — the **exact** source string as Drupal produces it, for example
  `Log in`. Matching is exact, so capitalisation and punctuation must match the
  original.
- **Replacement** — the text you want shown instead, for example `Sign in`.
- **Context** — usually leave this **blank**. Only fill it in to target a string
  that Drupal translates with a specific context (used to disambiguate identical
  words that mean different things, such as the month "May").

The form also has buttons:

- **Add extra row** — adds another blank override row (via AJAX) so you can enter
  several at once.
- **Remove disabled strings** — permanently deletes the parked list of disabled
  rows for this language.
- **Save configuration** — saves both your enabled and disabled rows.

A row with a blank **Original** is ignored when you save, so empty rows do no
harm.

## Per-language behaviour

Overrides are stored separately for each language. Setting one for your default
language leaves the others untouched, and you can give the same source string a
different replacement in each language — a lightweight way to translate a handful
of strings without a full translation import.

## Disabling without deleting

Unticking **Enabled** on a row parks it as a *disabled* override: it is kept
(separately from the active list) so you can switch it back on later without
retyping. Disabled rows are not consulted when text is translated. This makes it
easy to keep a library of prepared overrides and toggle them, or to quickly A/B
different wording. Use **Remove disabled strings** if you want to clear those
parked rows for good.

## The permission

- **Administer string overrides** (`administer string overrides`) — controls
  access to the overrides form. It is marked security-sensitive (overriding
  interface text is powerful), so grant it only to trusted administrator roles at
  **People → Permissions**.

## Deployment

Overrides are stored as configuration (one config object per language), so you
can export them with the rest of your site configuration and import them on
other environments like any other config. If you ever write the override config
directly (bypassing this form), clear caches afterwards (`drush cr`) so the new
wording takes effect — the form does this for you automatically on save.

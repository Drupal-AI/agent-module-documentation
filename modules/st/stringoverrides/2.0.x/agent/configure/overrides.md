<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# String Overrides — configuring overrides

## Admin UI

- Route `stringoverrides.translations_form.default` → `/admin/config/regional/stringoverrides`
  redirects (via `GoToDefaultLanguage`) to the default language's form.
- Per-language form `stringoverrides.translations_form` →
  `/admin/config/regional/stringoverrides/{language}` (form `StringoverridesAdminForm`).
- Permission required: `administer string overrides`.

The form is a table with columns **Enabled / Original / Replacement / Context** plus:
- **Add extra row** (AJAX) — add another blank override row.
- **Remove disabled strings** — deletes the `<langcode>_disabled` config.
- **Save configuration** — persists both enabled and disabled rows.

Each row: tick *Enabled*, put the exact source string in *Original*, the replacement in
*Replacement*, and optionally a *Context* (leave blank for the common case). A blank
*Original* row is ignored on save.

## Where overrides are stored (config)

Enabled overrides for a language live in the config object
`stringoverrides.string_override.<langcode>`; disabled rows live in
`stringoverrides.string_override.<langcode>_disabled`. Structure (schema
`stringoverrides.string_override.*`):

```yaml
# stringoverrides.string_override.en
contexts:
  - context: ''                 # the (often empty) string context
    translations:
      - source: 'Log in'        # exact original string
        translation: 'Sign in'  # replacement
      - source: 'Home'
        translation: 'Start'
  - context: 'Long month name'  # a second group, keyed by its context
    translations:
      - source: 'May'
        translation: 'Mai'
```

Overrides are grouped into one entry per distinct `context`; each entry holds a
`translations` list of `{source, translation}` pairs. On save the module sorts contexts and
re-indexes them numerically (config keys can't contain arbitrary characters).

## Setting overrides with Drush (no UI)

```bash
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("stringoverrides.string_override.en");
  $c->set("contexts", [[
    "context" => "",
    "translations" => [
      ["source" => "Log in", "translation" => "Sign in"],
    ],
  ]])->save();
  \Drupal::cache()->delete("stringoverides:translation_for_en");
'
```

Always delete the cache id `stringoverides:translation_for_<langcode>` after writing config
directly, or the translator will keep serving the previously cached set (a plain `drush cr`
also clears it).

## Deployment

Export `stringoverrides.string_override.<langcode>` (and the `_disabled` variant if used)
with your configuration and import it on other environments like any other config.

# Translate Tool — manual setup guide

**Translate Tool** (`translate_tool`) is a small developer helper for adding and
deleting interface‑translation strings **from code** — typically from a module's
update or install hook — without anyone having to open the translation UI. If you
ship string translations as part of a deployment and want them created automatically
when an update runs, this is the tool for it.

It's deliberately tiny: one service (`translate_tool`) wrapping Drupal core's locale
storage, plus two procedural wrapper functions so the calls read naturally inside
procedural update/install hooks. There is **no admin UI, no settings, no permissions,
and no Drush commands** — it is purely an API for developers. It depends only on
core's Locale module.

This guide is written for a **human** developer. If you want terse, token‑cheap
references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside core's Locale module.

## How to use it

Call the service (or the procedural wrappers) from your own code — most often a
`hook_update_N()` or `hook_install()` so translations are created as part of an
update path:

```php
// Via the service
/** @var \Drupal\translate_tool\TranslateTool $tt */
$tt = \Drupal::service('translate_tool');
$tt->add('horse', 'da', 'hest');             // add a Danish translation
$tt->add('horse', 'da', 'hest', 'animals');  // scoped to a translation context
$tt->delete('old string');                   // remove a string's translations

// Or the procedural wrappers, convenient inside a hook
function my_module_update_10001(&$sandbox) {
  translate_tool_add('horse', 'da', 'hest');
  translate_tool_delete('old string');
}
```

The method signatures are:

- `add(string $source, string $langcode, string $translation, string $context = '')`
  — looks up the source string, creates it if it doesn't exist yet, then
  creates (or **replaces**, if one already exists) the translation for that language.
- `delete(string $source, string $context = '')` — removes the string's
  translations.

One thing to keep in mind: for the added translation to actually appear where the
text is rendered, `$source` must be a string Drupal collects for translation (a
`t()` / `@Translation` string). See the sibling
[`agent/api/service.md`](../agent/api/service.md) for the full API reference.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Translator service & the alter hook

Source: `src/Translator.php` (service `auto_node_translate.translator`), `auto_node_translate.api.php`,
`src/Form/TranslationForm.php`.

## Service `auto_node_translate.translator`

`Translator::translateNode(\Drupal\node\Entity\Node $node, array $translations)` — `$translations` is a
map `langId => truthy` selecting target languages (produced by `TranslationForm`). Flow:

1. Load provider from `auto_node_translate.settings:default_api` via the plugin manager.
2. For each selected language, get/add the node translation and walk `getFields()`:
   - **Text fields** (`getTextFields()`: `string`, `string_long`, `text`, `text_long`,
     `text_with_summary`) and **link** titles → translated via the provider; over-length `string`/`text`
     output is truncated to the field's `max_length`.
   - `entity_reference_revisions` (paragraphs) → deferred, then `translateParagraphField()` recurses,
     translating each referenced paragraph (and its nested paragraphs) in place.
   - Other non-excluded fields → copied verbatim from the source.
   - `getExcludeFields()` skips system/identity fields (langcode, uuid, revision ids, status, created,
     content_translation_*, paragraph parent_* keys, etc.).
3. If `content_moderation` is active and the node is moderated, sets the translation's moderation
   state per the `moderation_state` setting (source state / `draft` / `published`).
4. Saves a **new revision** with log "Automatic translation using <api>", the request time, and the
   current user as revision author.

Only translatable fields are written; non-translatable fields are left to core's shared handling.

## Alter hook

`hook_auto_node_translate_translation_alter(&$text, array &$info)` — invoked (`invokeAll`) for **every**
string before it is sent to the provider, for both text fields and link titles. `$info` = `field`
(the field item list), `from` (source langcode), `to` (target langcode). Use it to append/skip/rewrite
content, protect glossary terms, etc.

```php
function mymodule_auto_node_translate_translation_alter(&$text, array &$info) {
  if ($info['field']->getName() === 'title') {
    $text .= ' — ' . strtoupper($info['to']);
  }
}
```

## Provider calls

Each string becomes one `$provider->translate($text, $from, $to)` call (see
[../plugins/provider.md](../plugins/provider.md)). With MyMemory, long strings are internally chunked to
~400 bytes per request, so a large body can produce several outbound HTTP GETs.

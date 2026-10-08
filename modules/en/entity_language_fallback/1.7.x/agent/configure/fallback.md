# Configure fallback languages

No module settings page. Fallbacks are configured **per language** on the language edit form.

## Steps

1. *Configuration → Regional and language → Languages* (`/admin/config/regional/language`).
2. **Edit** a language (e.g. French). The module (`hook_form_language_admin_edit_form_alter`)
   adds an **"Entity fallback language"** details section with one *Priority N* select per
   other language on the site.
3. Choose fallback languages in priority order (Priority 1 is tried first). Leave a slot
   `-None-` to skip it. Save.

The entity builder filters out empty selections and stores the ordered list.

## Storage

Saved as a third-party setting on the `configurable_language` config entity:

```yaml
# language.entity.fr (…third_party.entity_language_fallback)
third_party_settings:
  entity_language_fallback:
    fallback_langcodes:
      - nb
      - en
```

Schema: `language.entity.*.third_party.entity_language_fallback` → `fallback_langcodes`
(sequence of strings). Read at runtime by `FallbackController::ensureFallbackChain()` via
`ConfigurableLanguage::getThirdPartySetting('entity_language_fallback','fallback_langcodes')`.

## When it applies

`entity_language_fallback_language_fallback_candidates_alter()` replaces the core candidate
list **only** for `$context['operation']` in `entity_view` or `entity_upcast`. For a
translatable entity the resulting candidate order is: requested language, then each configured
fallback langcode (de-duplicated). Non-translatable entities are untouched. There is no UI
toggle beyond the per-language selects and no permission gate on the behaviour itself (editing
languages already requires *Administer languages*).

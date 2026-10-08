<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Auto Node Translate — agent index

Adds an "Auto Translate" node operation that machine-translates a node's text/link/paragraph
fields into chosen enabled languages via a pluggable provider (MyMemory ships built in).
Depends on core `content_translation`. Config page `auto_node_translate.settings`.

- **Settings forms & keys (provider selection, moderation state, MyMemory email), routes** →
  [configure/settings.md](configure/settings.md)
- **The `auto_node_translate_provider` plugin type — write your own translation backend** →
  [plugins/provider.md](plugins/provider.md)
- **Permissions: `configure auto node translate` + dynamic per-bundle `auto translate …`** →
  [permissions/permissions.md](permissions/permissions.md)
- **The `Translator` service, the translate flow, and `hook_auto_node_translate_translation_alter`** →
  [api/translator.md](api/translator.md)

Key facts:
- Route `entity.node.auto_translation_add` = `node/{node}/auto-translate-form` (added by
  `AutoNodeTranslateRouteSubscriber`), guarded by access check `_access_auto_translation`
  (`AutoNodeTranslateAccessCheck`). `TranslationForm` chooses target languages.
- Provider plugins: annotation `@AutoNodeTranslateProvider`, manager
  `plugin.manager.auto_node_translate_provider`; bundled `auto_node_translate_mymemory`.
- MyMemory endpoint is the fixed host `https://api.mymemory.translated.net/get` (not configurable);
  only an optional quota-raising email is stored (`auto_node_translate.my_memory_settings:mm_email`).
- Translates `string/text/text_long/text_with_summary`, link titles, and recurses into
  `entity_reference_revisions` paragraphs; integrates with `content_moderation` when present.

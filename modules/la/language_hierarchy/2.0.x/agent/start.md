# Language Hierarchy — agent index

Configures parent/child **inheritance between languages**: when a translation is missing in a
language, fall back through a configured chain of parent languages (for content, config, interface
strings, and path aliases) instead of jumping to the site default. Depends on core `language`. No
settings form (`configure` null) and no permission of its own — configured through the core
language forms.

- **Where the fallback is stored and how to set it (per-language edit form, overview tree,
  the priority table)** → [configure/fallback.md](configure/fallback.md)
- **How the fallback actually resolves (candidate-alter hook, config override, locale decorator,
  path-alias/query alters, URL fixing)** → [api/mechanism.md](api/mechanism.md)
- **The Views sort & filter it adds ("Content language relevance", "Most relevant translation")** →
  [plugins/views.md](plugins/views.md)

Key facts:
- Each language's parent is a **third-party setting** on its `configurable_language` entity:
  `third_party_settings.language_hierarchy.fallback_langcode` (schema
  `language.entity.*.third_party.language_hierarchy`). Empty = no fallback.
- The module maintains a DB table **`language_hierarchy_priority`** (langcode → priority),
  rebuilt by `language_hierarchy_update_priorities()` on any language insert/update/delete and on
  config import.
- Fallback resolution goes through `hook_language_fallback_candidates_alter()`; verify it with
  `\Drupal::languageManager()->getFallbackCandidates(['langcode' => '<lc>'])`.

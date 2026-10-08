Language Hierarchy lets you configure parent/child inheritance between languages so that when a translation (content, config, or interface text) is missing in one language, Drupal falls back through a configured chain of "parent" languages instead of jumping straight to the site default.

---

Each language stores a `fallback_langcode` as a third-party setting on its
`configurable_language` config entity (`third_party_settings.language_hierarchy.fallback_langcode`),
editable both on the single-language edit form ("Translation fallback language" select) and on the
languages overview form as a drag-and-drop parent/child tree. The module implements
`hook_language_fallback_candidates_alter()` to rebuild the fallback candidate list by walking that
chain (with loop protection), and maintains a `language_hierarchy_priority` DB table
(langcode → priority) that is recomputed whenever any language is inserted, updated, deleted, or
config is imported. That priority drives ordering in three places: a `ServiceProvider` swaps
`language.config_factory_override` for `LanguageHierarchyConfigFactoryOverride` so **config
translations** inherit from parent languages; when `locale` is enabled it decorates
`locale.storage` (`StringDatabaseStorageDecorator`) so **interface translation** lookups fall back
through the hierarchy; and it alters the `path_alias` language-fallback query so **path aliases**
resolve via the hierarchy. It also provides a Views sort ("Content language relevance") and a Views
filter ("Most relevant translation (using fallback)") for showing the single most-specific
translation of each item, plus `hook_preprocess_node/taxonomy_term/image_formatter` logic that
rewrites a link's language when the shown translation is only a fallback of the current page
language. There is no settings form or permission of its own — you configure it entirely through
the core language forms; when `config_translation` is enabled it also adds a route subscriber so
config-translation edit pages respect the hierarchy.

---

- Make a regional language (e.g. Austrian German) fall back to its base language (German) for missing translations.
- Fall back from a country variant (en-GB, en-AU) to a base language (en) instead of the site default.
- Build a multi-level fallback chain (e.g. es-MX → es → en) for content and interface text.
- Inherit configuration translations (views, field labels, menus) from a parent language.
- Inherit interface (locale) string translations from a parent language when `locale` is enabled.
- Resolve path aliases through the language hierarchy so URLs work across related languages.
- Configure a language's parent via the "Translation fallback language" select on its edit form.
- Set up the whole hierarchy visually by dragging languages into a parent/child tree on the overview form.
- Avoid showing site-default (often English) strings by falling back to a closer related language first.
- Serve partially-translated regional sites without duplicating every translation.
- Show only the most relevant translation of each node in a View using the fallback-limited filter.
- Sort a View by how relevant each translation is to the current content language.
- Provide sensible fallbacks for a shared/base language used by several regional variants.
- Keep a base language fully translated and let variants override only what differs.
- Prevent fallback loops automatically (the chain walker guards against cycles).
- Recompute fallback priorities automatically whenever languages are added, changed, or removed.
- Deploy the hierarchy as configuration (fallback_langcode third-party settings) across environments.
- Reflect the hierarchy after a config import (priorities rebuild on the config import event).
- Fix links so a fallback translation's URL uses the current page's language instead of the fallback's.
- Support editorial workflows where a base translation is written first and variants trickle in.
- Reduce translation effort for closely related locales sharing most of their content.
- Query the `language_hierarchy_priority` table to understand relative language relevance.
- Combine content, config, and interface translation fallback under one consistent hierarchy.

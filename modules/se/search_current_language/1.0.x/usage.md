Search by current language forces Drupal core's node search to return only results in the visitor's current interface language (plus language-neutral content) and hides the language filter from the advanced search form. No configuration.

---

The module is a tiny query/form alter. `hook_query_TAG_alter()` targets the core search query tags `search_node_search` and `search_search_exclude_node_search`: it strips any existing `i.langcode` condition already on the query, then adds `i.langcode IN (<current language>, 'und', 'zxx')`, so results are limited to the active language plus the "undetermined" (`und`) and "not applicable" (`zxx`) neutral codes. `hook_form_search_form_alter()` sets `#access = FALSE` on the advanced search form's `lang-fieldset`, removing the user-facing language filter. It depends on core `search`, `language`, and `content_translation`, has no settings, permissions, services, or schema, and only affects the core Search module's node search (not Search API). The current language comes from `\Drupal::languageManager()->getCurrentLanguage()`, so whatever language negotiation the site uses drives which results appear.

---

- Show search results only in the language the visitor is currently browsing.
- Hide the "Languages" filter from the core advanced node search form.
- Prevent a multilingual site from returning mixed-language search results.
- Include language-neutral (`und`) and not-applicable (`zxx`) content in every language's results.
- Give each language's visitors a clean, language-scoped search without extra configuration.
- Avoid confusing editors/users with results they can't read.
- Complement URL- or interface-based language negotiation so search follows the active language.
- Drop-in fix for the common "core node search ignores current language" complaint on multilingual sites.
- Keep core Search (not Search API) while still enforcing per-language results.
- Remove the need to train users to set the language filter manually before searching.
- Ensure a language switcher and search behave consistently on the same page.
- Serve region/language-specific microsites from one Drupal install with scoped search.
- Keep translated articles from appearing under an unrelated language's search results.
- Respect any language negotiation strategy (URL, session, interface) automatically.
- Simplify a multilingual site's search UX by removing a rarely-understood filter control.

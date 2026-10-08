Select Translation adds a Views filter that reduces a multilingual node listing to a single, best-matching translation per node, so a view never shows the same node once per language.

---

Select Translation exposes a single Views filter (plugin id `select_translation_filter`) on the `node_field_data` table, registered via `hook_views_data_alter()`. Adding it to a view of nodes collapses each node down to one translation chosen by a configurable selection mode: use the current interface language falling back to the original node language; use the current language, then the site default, then the original; use core's language fallback candidate chain; or a custom comma-separated priority list of language codes. In the custom list the special tokens `current`, `default` and `original` resolve to the current interface language, the site default language, and the node's original (untranslated) language respectively, and `original` is always appended as the final fallback so a node is never dropped entirely. The filter is implemented with LEFT JOINs against wrapped sub-queries rather than correlated sub-queries, which keeps it fast on large node tables and avoids breaking under node-access rewrites (e.g. the Domain module). Two extra checkboxes refine behaviour: show only default-language content when the current language equals the site default, and fall back to the default-language node when the current-language translation exists but is unpublished. The same selection algorithm is also available programmatically through the `select_translation_of_node($nid, $mode)` API function and a `drush select_translation:translation` command. The module has no settings form and no configure route; all configuration lives in the filter instance inside each host view.

---

- Show a language-agnostic list of articles where each node appears exactly once in the visitor's current language
- Fall back to a node's original language when no translation exists for the current interface language
- Fall back through current → site default → original language for content that may only be partially translated
- Build a "latest news" block that never duplicates a node across its translations
- Use Drupal core's language fallback candidate chain to pick the translation in a view
- Define a custom language priority such as `en,fr,current,default,original` for an editorial preference order
- Prefer English, then French, then whatever the interface language is, for a mixed-language listing
- Display only site-default-language content to anonymous visitors browsing in the default language
- Substitute the default-language node when the current-language translation is still unpublished
- Prevent a translated node from showing twice in search or listing pages
- Power a multilingual sitemap-style listing that resolves one canonical translation per node
- Add the filter to a REST/JSON export view so an API returns one translation per node
- Feed a multilingual RSS feed one appropriate translation per item
- Keep a taxonomy-term landing page showing one translation per tagged node
- Drive a "related content" view that respects the reader's language with graceful fallback
- Replace hand-written correlated sub-query SQL with a performant LEFT JOIN based translation filter
- Keep translation selection working under node-access modules like Domain Access
- Resolve the best translation of a node in custom PHP with `select_translation_of_node()`
- Look up which translation of a node a given mode resolves to from the command line via Drush
- Script bulk translation checks in Drush using `select_translation:translation --mode`
- Present a members list or directory of nodes in the reader's preferred language
- Build an admin listing that shows the original-language version of every node
- Offer editors a view that always surfaces the source (original) translation for reference
- Ensure a promoted-to-front-page view shows one language-appropriate copy of each promoted node
- Combine with the core "Published" filter to hide unpublished translations while still showing the default-language node

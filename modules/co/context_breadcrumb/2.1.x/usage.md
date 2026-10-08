Context Breadcrumb lets you define custom, dynamic breadcrumbs through the Context module: add a "Breadcrumb" context reaction, list breadcrumb rows (title + URL, with token support), and optionally emit them as Schema.org JSON-LD.

---

The module plugs into [Context](https://www.drupal.org/project/context) by providing a `context_breadcrumb` **context reaction** (`src/Plugin/ContextReaction/Breadcrumb.php`) where you configure up to nine ordered breadcrumb rows, each with a title, a URL, a token flag, and a weight. A high-priority `breadcrumb_builder` service (`ContextBreadcrumbBuilder`, priority 9999) applies the reaction of the active context to the current page, running row titles/URLs through the Token system (node/user/term/vocabulary tokens, plus a special `[term_hierarchy]` token for taxonomy trees). It also ships a `taxonomy_vocabulary` **context condition** plugin and a `VocabularyContext` context provider so contexts can be activated per vocabulary. Separately, a settings form (`/admin/config/user-interface/context-breadcrumb`, route `context_breadcrumb.settings_form`, permission `administer context breadcrumb`) has a single `enable_json_ld` toggle; when on, `hook_page_attachments_alter` injects a placeholder `<script type="context_breadcrumb_ld">` that a response event subscriber replaces with a real `application/ld+json` BreadcrumbList built from the page's breadcrumb links (via `JsonLdData`, JSON-encoded, admin routes excluded). Requires the Context module; Token and Ctools are recommended.

---

- Define a fixed breadcrumb trail for a section of the site via a Context reaction.
- Show different breadcrumbs on different pages by using multiple contexts with different conditions.
- Use tokens (e.g. `[node:title]`, `[term:name]`) in breadcrumb titles and URLs.
- Build a taxonomy-hierarchy breadcrumb with the `[term_hierarchy]` token.
- Point a token URL at a node field, e.g. `[term_hierarchy:node:field_category]`.
- Order breadcrumb segments with per-row weights (drag-and-drop table).
- Link a breadcrumb segment to `<front>` or `<nolink>`.
- Activate a context (and its breadcrumb) only for specific taxonomy vocabularies via the condition plugin.
- Use the vocabulary context provider to react to the current vocabulary.
- Emit Schema.org `BreadcrumbList` JSON-LD for SEO by enabling the JSON-LD toggle.
- Keep JSON-LD off admin pages automatically (admin routes are skipped).
- Override the site's default breadcrumb without writing a custom breadcrumb builder.
- Give a landing page a custom multi-level breadcrumb.
- Add a static "Home > Section > Page" trail to a set of pages.
- Cache breadcrumbs per query argument via the reaction's "Cache query args" setting.
- Combine Context conditions (path, role, etc. from Context/Ctools) to target breadcrumbs precisely.
- Provide localized breadcrumb titles by using contexts and language-aware tokens.
- Replace an outdated custom breadcrumb module with a config-driven, UI-managed approach.
- Add breadcrumbs for taxonomy term pages that mirror the term hierarchy.
- Expose breadcrumbs as structured data for rich results in search engines.

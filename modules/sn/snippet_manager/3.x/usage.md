<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Snippet Manager manages reusable code snippets — Twig templates with named variables, optional CSS/JS — as config entities that can be rendered as blocks, pages, layouts, display variants, or embedded in other snippets and content.

---

Reusable bits of markup or logic — a formatted address, a call-to-action, a computed widget — often end up scattered across templates and blocks. Snippet Manager centralises them at `/admin/structure/snippet`: each snippet is a `snippet` config entity with a **Twig** template, optional **CSS/JS**, and named **variables** (a `SnippetVariable` plugin can pull in an entity, a view, a block, a menu, formatted text, a file, or a nested "mini snippet"). One snippet can be exposed as a standalone **page** (its own path and access rules), a placeable **block**, a **layout** or page **display variant**, replaced into content via the `[snippet:ID]` **text-format filter**, or embedded in another template with the `{{ snippet('id', {...}) }}` **Twig function**. Install via `composer require drupal/snippet_manager` and `drush en snippet_manager` (it depends on **filter**, **file**, and the contrib **codemirror_editor** module for the code editor; requires Drupal 10.3/11 and PHP 8.1). Snippet templates are compiled as Twig through Drupal's standard `inline_template` — the same non-sandboxed environment theme templates use — so authoring is gated behind the **restrict-access** `administer snippets` permission. Treat that permission like the ability to edit theme templates or run PHP: grant it only to trusted developers and site builders, never to content editors. Rendering, by contrast, is public wherever the author chooses (an enabled snippet placed as a block or page shows to anonymous visitors by design), so decide each snippet's page access (`- Do not limit -` / Permission / Role) deliberately.

---

- Install with `composer require drupal/snippet_manager` then `drush en snippet_manager`.
- Manage all snippets at `/admin/structure/snippet`.
- Create a snippet with a Twig template body.
- Add named variables to a snippet (entity, view, block, menu, text, file, url…).
- Embed one snippet in another with `{{ snippet('id') }}`.
- Include a snippet template via `@snippet/id` in Twig.
- Render a snippet as a placeable block.
- Expose a snippet as a standalone page with its own path.
- Choose page access: do-not-limit, by permission, or by role.
- Add path placeholders like `%` or `%node` to load route entities.
- Turn a snippet into a page display variant.
- Turn a snippet into a Layout Builder layout with regions.
- Attach per-snippet CSS and JavaScript.
- Replace `[snippet:ID]` tokens in content via the Snippet text filter.
- Duplicate an existing snippet as a starting point.
- Enable or disable a snippet without deleting it.
- Preview a snippet's rendered HTML and render time on the Source tab.
- Restrict the `administer snippets` permission to trusted developers only.
- Never grant snippet authoring to content editors.
- Use the `entity` variable's "Bypass access checks" option deliberately.
- Extend with a custom `SnippetVariable` plugin.
- Alter a snippet's render output with `hook_snippet_view_alter()`.

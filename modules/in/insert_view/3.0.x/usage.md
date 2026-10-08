<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Insert View adds a single text-format filter that turns `[view:name=display=args=limit:number]` tags inside any formatted text field into the rendered output of that view.

---

The whole module is one `@Filter` plugin, `insert_view`, of type `TYPE_TRANSFORM_IRREVERSIBLE`, plus a two-line `hook_help()`. There is no settings form, no configure route, no permissions, no services, no config schema and no Drush commands — you enable the module and then tick **Insert View** on the text formats where you want it (`/admin/config/content/formats`), which stores `filters.insert_view.status: true` inside the `filter.format.<id>` config entity. At runtime `InsertView::process()` runs the regex `/\[view:([^=\]]+)=?([^=\]]+)?=?([^=\]]+)?=?(?:limit:)?([\d]+)?\]/i` over the text; each match is replaced with a lazy-builder **placeholder** created via `FilterProcessResult::createPlaceholder()` pointing at the trusted static callback `InsertView::build()`, and the result gains the cache tag `insert_view` and the cache contexts `url` and `user.permissions`. `InsertView::build()` loads the view with `Views::getView()`, returns empty markup when the view does not exist or `$view->access($display_id)` fails, substitutes `%0`, `%1`, … placeholders in the argument string with the corresponding slash-separated components of the current path, optionally calls `setItemsPerPage()` for the `limit:` parameter, and finally returns `$view->preview($display_id, $args)`. The display id defaults to `default` when omitted (or when the second segment is numeric), and multiple arguments are separated by slashes exactly as in a view's URL. Because the filter is powerful — it renders any view display the tag names — the README warns to grant it only to trusted roles and to make sure every view display (including the default display) has correct access settings.

---

- Drop a "Latest news" view into the body of a static Basic page.
- Embed a Views listing inside a WYSIWYG body without a Views block or Layout Builder.
- Put a filtered product grid into a landing page's rich-text field.
- Show a taxonomy-term listing inside another node's body via `[view:name=display=term_id]`.
- Use the current path to feed a contextual filter with `%1` / `%2` placeholders.
- Limit an embedded view to N rows for a teaser-style block: `[view:my_view=block_1==limit:5]`.
- Show all results regardless of the display's pager with `limit:0`.
- Embed the same view twice on one page with different arguments.
- Add a view to a custom block body (any field using a text format with the filter enabled).
- Insert a view into a Paragraph's text field.
- Let editors place listings themselves without needing block-layout permissions.
- Create a dedicated "Editorial HTML" text format that has the filter enabled, and keep the default formats untouched.
- Use the view's `default` display by writing `[view:my_view]` with no display id.
- Pass several arguments: `[view:my_view=page_1=arg1/arg2/arg3]`.
- Embed a view into a webform confirmation message or email body (any filtered text).
- Render a view inside a taxonomy term description.
- Add a "related content" view to the bottom of long-form articles.
- Prototype a page layout quickly before formalising it with blocks or Layout Builder.
- Migrate legacy Drupal 6/7 content that already contained `[view:...]` tags.
- Keep view output cacheable-per-URL by relying on the module's `url` cache context.
- Invalidate every embedded view at once by invalidating the `insert_view` cache tag.
- Restrict the filter to a format only trusted editors may use, per the module's security warning.
- Verify a view display's markup in situ while building it.
- Provide an "insert this listing" instruction to editors via the filter's long tips text.

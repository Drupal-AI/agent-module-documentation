<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
HTML Title lets a limited, admin-controlled set of HTML tags render inside Drupal node titles (page titles, teasers, breadcrumbs, admin messages) instead of being escaped, so titles can show italics, superscripts, subscripts and similar inline markup.

---

Core escapes node titles, so a title like `H<sub>2</sub>O` or an italicised book name shows the raw tags. HTML Title works around this without changing how the title is stored: you type the markup into the normal title field, and the module decodes and re-renders it wherever the title is displayed. It registers a single `html_title.filter` service whose `decodeToText()`/`decodeToMarkup()` methods run the stored title through `Html::decodeEntities()` and then a strict `Xss::filter()` limited to the tags configured in `html_title.settings:allow_html_tags` (default `<br> <sub> <sup>`); everything else is stripped so titles cannot introduce XSS or nested links. A settings form at `/admin/config/user-interface/html_title` (permission *administer html title settings*) edits that allowed-tag string. Numerous preprocess hooks apply the filter to the page title, the node title field, search results, breadcrumbs and node-save confirmation messages, while stripping tags from RSS titles. It also ships an `html_title` field formatter (for string fields) and swaps the Views node-title field handler (`node_html_title`) so listed titles render the markup too. The intended tag set is inline-only: `em, sub, sup, b, i, strong, cite, code, bdi, wbr`.

---

- Render a chemical formula such as `H<sub>2</sub>O` or `x<sup>2</sup>` correctly in an article title.
- Italicise a book or publication name inside a node title using `<em>` or `<cite>`.
- Show a trademark/registered mark as superscript in a product page title.
- Allow `<strong>` emphasis on a single keyword within a page heading.
- Keep the rendered markup consistent in the browser `<title>`, breadcrumb and on-page `<h1>`.
- Display the HTML title correctly in the "content has been created/updated" admin message after saving.
- Restrict which tags editors may use by editing `allow_html_tags` (e.g. only `<em> <sup>`).
- Prevent XSS by stripping any tag not on the allowlist via `Xss::filter()`.
- Add the *HTML-title text* formatter to a plain-string field so its value renders as markup in view displays.
- Swap a Views listing's node-title column to the `node_html_title` handler so titles show markup in a table/grid.
- Strip markup from RSS feed titles automatically so feeds stay valid.
- Present marked-up titles inside search result listings.
- Give an editorial team inline formatting in titles without a WYSIWYG or custom field.
- Enable `<bdi>` for correct bidirectional text in multilingual titles.
- Use `<code>` in a documentation site's node titles to format inline code.
- Add line breaks in a title with `<br>` where the theme allows.
- Programmatically decode a stored title to safe markup with `\Drupal::service('html_title.filter')->decodeToMarkup($title)`.
- Convert a title array/render array to filtered plain text with `decodeToText()`.
- Roll out marked-up titles across an existing site without altering stored title values or the schema.
- Limit the allowed tag list per environment by overriding `html_title.settings` config in a deployment.
- Grant only trusted roles the *administer html title settings* permission to control the allowlist.
- Ensure the Gin admin theme's page-title markup is overridden so titles still render (handled via theme_registry_alter).
- Keep title markup out of places that must stay plain (RSS) while enabling it where HTML is safe.

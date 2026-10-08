<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Link Area adds a "Link" area handler to Views so you can place a configurable internal or external link in a view's header, footer, or no-results (empty) region.

---

The module registers a single Views area plugin (`linkarea`, class
`Drupal\views_linkarea\Plugin\views\area\Link`, extending `TokenizeAreaPluginBase`) under
the Global category as "Link — Provide an internal or external link". You add it to a
display's Header, Footer, or No Results Behavior and configure a rich set of options: link
text, path (Drupal path/URI/route/external URL, may append query and fragment), whether
it's external, "output as action" (rendered like a primary-admin-action button), an
optional destination query parameter, prefix/suffix HTML, title/rel/target/class
attributes, absolute URL, case transform, language, a "rewrite output" template using the
`{{ views_linkarea }}` token, and access-denied replacement text. Most text options support
Views token replacement (from the first result row when "tokenize" is on). `render()`
tokenizes and normalizes the path into a `Url` object; `renderUrl()` checks route access
(`access_manager->checkNamedRoute()` for routed URLs) and returns either a `#type => link`
render element or, when a rewrite/access-denied template is used, markup filtered through
`xss_admin`. There is a config schema for all options; there are no permissions, no Drush,
and no global settings page. Because several fields accept admin-authored HTML/attributes,
treat configuring this handler as a trusted, admin-only capability (see
`agent/configure/link-area.md` for the XSS responsibilities).

---

- Add a "Create new content" call-to-action button in a listing view's header.
- Put a "Back to overview" link in a view footer.
- Show an "Add the first item" link in the no-results/empty region of an empty view.
- Render the link as a themed action button matching core's primary admin actions.
- Link to an external site (e.g. `https://example.com`) from a view header.
- Build a link to a routed page and have it hidden automatically when the user lacks access.
- Show custom fallback text (or nothing) when the link's target is access-denied.
- Include a `destination` query param so the linked action returns the user to the view.
- Pass the first row's field value into the link path via Views tokens.
- Insert a token-driven link text such as "See all {{ title }} items".
- Add query string and fragment to the link (e.g. `/search?type=article#results`).
- Apply a CSS class to style the link consistently with the theme.
- Set `target="_blank"` (or an iframe name) on the link.
- Add a `rel` attribute for lightbox/JS utilities.
- Add a title/tooltip attribute for accessibility.
- Force an absolute URL for links that appear in RSS feeds or emails.
- Transform the path case (upper/lower/capitalize) for the value portion of a path.
- Replace spaces with dashes in a generated path.
- Wrap the generated link in custom prefix/suffix markup.
- Use the "rewrite output" template with `{{ views_linkarea }}` to embed the link inside arbitrary HTML.
- Choose a specific language for the generated URL on a multilingual site.
- Provide a "Download report" or "Export" link in the header of a data view.
- Add a marketing CTA to the footer of a promoted-content view.
- Link an empty search-results view to a "browse all" page.

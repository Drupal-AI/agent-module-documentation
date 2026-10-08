<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Fixed Text Link Formatter adds field formatters that render a Link (or File) field as a hyperlink whose visible text is a fixed, admin-configured string ("Visit our website", "Download") instead of the per-item title or the raw URL.

---

The module ships two field formatter plugins and nothing else — no settings page, permissions, services, or Drush. **`fixed_text_link`** (label "Link with fixed text") applies to core **link** fields; it extends core's `LinkFormatter`, hides the URL-only / trim-length / plain options, and forces every rendered link to use a configured **Link text** string, an optional **Link class**, plus the inherited rel/target options. Its **Allow override** setting keeps the fixed text only when an item has no title of its own, letting editors override per link. **`fixed_text_file_url`** (label "Link with a fixed text") applies to **file** fields; it renders each file as a link to the file URL using a fixed **Link text**, optional **Link class**, and an **Open in a new window** toggle. Both are selected per field on the entity's *Manage display* page and their settings are stored in the `core.entity_view_display.*` config (component `type` + `settings.link_text` / `link_class`). The result is consistent call-to-action link text across all entities of a bundle without editors typing a title on every link.

---

- Show every link in a "Website" link field as "Visit our website" instead of the raw URL.
- Render a call-to-action link with fixed text like "Learn more" across all articles.
- Display a file/download field as a "Download" link rather than the file name.
- Give document links a consistent "Download the PDF" label site-wide.
- Force a uniform link label on a link field where editors otherwise leave the title blank.
- Add a CSS class (e.g. `btn btn-primary`) to formatted links for button styling.
- Open formatted file links in a new browser tab via the "Open in a new window" option.
- Apply `rel="nofollow"` and new-window target to fixed-text link fields (inherited link options).
- Let editors optionally override the fixed link text per item with the Allow override setting.
- Keep the fixed text only for links that have no per-item title, using Allow override.
- Standardize "Read more" links on teaser view modes of a content type.
- Present an external partner URL as a branded label instead of exposing the domain.
- Configure different fixed labels per view mode (e.g. "Details" on default, "More" on teaser).
- Turn a resume/CV file field into a tidy "Download CV" link.
- Provide a consistent "Book now" link across event nodes pointing to varying URLs.
- Hide long/ugly URLs behind friendly link text for accessibility and readability.
- Style a link field as a button with a fixed label and a utility class.
- Avoid teaching content editors to fill the optional link title on every link field.
- Export the formatter choice + fixed text in config so it deploys with the site.
- Use on media/document reference display where the label should always read "Open file".

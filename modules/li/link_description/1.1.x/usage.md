<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Link with description adds a `link_description` field type that behaves exactly like the core Link field but carries an extra multi-line "description" value alongside each link's URL and text.

---

The module extends core's Link module by subclassing its plugins. It defines a field type `link_description` (extends `LinkItem`, adding a `description` column of DB type `text`/`big` and a `description` string property), a widget `link_description` (extends the core `LinkWidget`, adding a 3-row "Long description" textarea after the URL/text inputs), and two formatters: `link_description` ("Link with description") and `link_separate_description` ("Title and link URL with description"), each extending the matching core Link formatter and rendering the description via a dedicated Twig template. It therefore inherits all core Link options — allowed link type (internal/external/both), allow/require link text, `rel="nofollow"`, open-in-new-window `target`, URL-only / plain-URL / trim-length formatter settings — and just layers a description on top. The description is stored raw (no text format) and output with `nl2br` so newlines are preserved. Two theme hooks (`link_with_description`, `link_with_description_separate_text_url`) and templates control the markup (a `.link-item` wrapper with a `.link-description` paragraph). There is no settings page, permission, service, or Drush command; you use it purely by adding a field of this type to an entity bundle. It requires core's Link module and PHP >= 8.1.

---

- Add a "Related links" field where each link also has an explanatory description.
- Store a URL plus a short blurb about where it goes, in one field.
- Build a link directory / resource list where every entry shows a title and a description.
- Replace a core Link field with `link_description` to gain a description without custom code.
- Show a call-to-action link with descriptive supporting text underneath.
- Provide editors a "Long description" textarea next to each link URL and text.
- Render links as separate title + URL + description using the `link_separate_description` formatter.
- Keep the compact core-style rendering but append a description via the `link_description` formatter.
- Preserve multi-line descriptions (newlines become `<br>`) in the output.
- Reuse core Link field settings (internal/external, require link text) with an added description.
- Apply `rel="nofollow"` or open-in-new-window on described links via inherited formatter settings.
- Trim the visible link text length while still displaying the full description.
- Create a footer "useful links" list with per-link descriptions.
- Add documentation links to a content type, each annotated with what the reader will find.
- Build a partner/sponsor list where each logo-link has descriptive text.
- Style the description independently via the `.link-description` CSS class.
- Override the module's Twig templates in a theme to customise link+description markup.
- Provide accessible link context by pairing each URL with a human-readable description.
- Use on any fieldable entity (nodes, taxonomy terms, paragraphs, media) that supports fields.
- Migrate legacy link+note data into a single structured field.
- Populate `uri`, `title`, and `description` programmatically when creating entities.
- Offer multi-value described links (multiple URLs each with their own description) on one field.
- Display a menu of external references with inline descriptions on a landing page.
- Give marketing a link field where the descriptive copy is editable separately from the anchor text.

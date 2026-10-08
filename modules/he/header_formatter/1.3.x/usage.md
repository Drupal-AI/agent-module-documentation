Header Formatter adds a single field formatter ("Header") that renders a plain-text `string` field wrapped in an HTML heading tag (`<h1>`–`<h6>`) chosen by a site builder on the Manage display tab.

---

The module provides one field-formatter plugin, `text_header` (class `TextHeaderFormatter`), applicable to
core `string` fields whose cardinality is exactly 1 (single-value). On *Manage display* you pick the "Header"
formatter and set a single `level` setting (1–6, default 2); each field value is then rendered as an
`html_tag` render element with tag `h{level}` and the raw field value. The settings summary shows the chosen
level (e.g. "Header level: H2"). There is no global configuration, no permissions, no dependencies beyond
Drupal core, and no config schema — the only stored setting is the per-display `level`. It is a deliberately
tiny "site builder" convenience for turning a title/label string field into a semantic heading in a view
mode without writing a template or a Twig override.

---

- Render a single-value string field as an `<h2>` heading in a view mode.
- Choose any heading level H1–H6 per display / view mode.
- Turn a node subtitle or tagline field into a semantic heading without a template override.
- Use different heading levels for the same field in different view modes (e.g. H1 on full, H3 on teaser).
- Give a custom "section title" string field proper heading semantics for accessibility/SEO.
- Display a taxonomy term name field as a heading on the term page.
- Render a paragraph/entity-reference component's title string field as a heading.
- Provide editors a simple string field while site builders control the heading markup.
- Replace an inline-template or Twig `{{ ... }}` wrapping just to add an `<hN>` tag.
- Present a user profile field (e.g. display name) as a heading on the user page.
- Apply a heading to a computed/single-value string field in Layout Builder.
- Keep markup consistent across content types by standardising which level a title field uses.
- Show a media entity's name as a heading in a media view mode.
- Use H1 for a landing-page hero title string field.
- Downgrade a field to H4–H6 for less prominent secondary headings.

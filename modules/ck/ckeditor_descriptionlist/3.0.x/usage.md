CKEditor 5 plugin that adds a toolbar button for building HTML description lists (`<dl>` with `<dt>`/`<dd>` term-and-description pairs) in the rich-text editor.

---

CKEditor Description List gives content editors a WYSIWYG way to create semantic description lists — the `<dl>` element holding paired `<dt>` (term) and `<dd>` (description) children — without touching the HTML source. In version 3.x it is a native CKEditor 5 plugin: adding the single "Description list" toolbar button to a text format inserts a `<dl>` widget, and when text is selected each line becomes a `<dt>`/`<dd>` pair, splitting on the first colon so a line like `Term: definition` produces the term and its description automatically. The plugin declares its allowed HTML as exactly `<dl>`, `<dd>`, `<dt>`, so enabling the button also teaches the format's "Limit allowed HTML tags" filter to keep those three tags. The module ships no settings form, config object, permission, or service — configuration is entirely the per-format toolbar. It depends on Drupal core's CKEditor 5 module and runs on core `^10.5 || ^11`.

---

- Build a glossary or terminology list where each term (`<dt>`) is followed by its definition (`<dd>`).
- Add an FAQ-style block where each question is a `<dt>` term and each answer a `<dd>` description.
- Mark up metadata pairs (author, date, category) semantically instead of using a table or bold labels.
- Create product spec sheets with attribute/value pairs as `<dt>`/`<dd>`.
- Document key/value configuration or settings references inside rich-text body fields.
- Produce name/role pairs for a staff or contributor listing.
- Convert a colon-delimited paste ("Label: value" lines) into a proper description list in one click.
- Give editors accessible, screen-reader-friendly list semantics without hand-writing HTML.
- Replace ad-hoc `<strong>Label:</strong> value` patterns with valid `<dl>` markup.
- Add a "Definitions" section to knowledge-base or documentation articles.
- Structure recipe metadata (prep time, cook time, servings) as description pairs.
- Present dictionary-style entries where headwords are terms and meanings are descriptions.
- Lay out event details (date, venue, price) as labeled description pairs.
- Enable the button only on the specific text formats (e.g. Full HTML, a custom editorial format) that should offer description lists.
- Keep body content semantically correct for SEO and accessibility audits that flag misused tables/lists.
- Author comparison or feature lists where each feature name maps to a description.
- Let editors quickly wrap an existing paragraph of "Label: value" lines into a description list, then refine.
- Standardize how term/description content is entered across a multi-author editorial team.
- Add description lists to any entity with a formatted-text field (nodes, blocks, paragraphs, taxonomy descriptions) that uses a CKEditor 5 format.
- Provide a lightweight alternative to custom field collections when the data is really just term/description prose.

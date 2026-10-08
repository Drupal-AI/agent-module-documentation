HTML Formatter provides a family of field *formatters* that wrap a field's rendered value in a configurable HTML tag (e.g. `h2`, `div`, `article`) with an optional CSS class and an optional link to the host entity, chosen per field on the *Manage display* tab.

---

The module ships four `FieldFormatter` plugins that share a common settings trait (`HtmlFormatterTrait`) exposing three settings — `tag` (an HTML element name), `class` (a CSS class), and `link` (bool, wrap the value in a link to the entity's canonical URL). `html_field_formatter` handles plain text/string field types (`text`, `text_long`, `text_with_summary`, `string`, `string_long`); `html_field_formatter_datetime_default` extends core's DateTime formatter; `html_field_formatter_timestamp` extends the Timestamp formatter (`timestamp`/`created`/`changed`); and `html_field_formatter_entity_reference_label` extends the Entity Reference Label formatter. Each renders through the module's `html_formatter` theme hook / `html-formatter.html.twig` template, which emits `<{{ tag }}{{ attributes }}>{{ value }}</{{ tag }}>` (the tag is omitted entirely when left blank). Settings persist in the entity view display (`content.<field>.settings.{tag,class,link}`, schema `field.formatter.settings.html_field_formatter*`). There is no global config page (`configure` null), no permissions and no Drush. It is essentially a lightweight way to add a semantic wrapper element and class to a field without a custom template or the heavier "Fences" module. Important caveat: the plain-text formatter emits `$item->value` (the raw stored value) rather than running the field's text-format filter, and the `tag`/`class` come straight from admin-entered config — so only expose these formatters (and the fields they format) to trusted roles; see [agent/configure/formatters.md](agent/configure/formatters.md).

---

- Wrap a title/string field in an `<h2>` (or any tag) without writing a Twig template.
- Add a semantic element like `<article>`, `<section>` or `<aside>` around a field's output.
- Give a field's wrapper a specific CSS class for theme styling.
- Render a plain string field inside a `<div class="badge">` for a UI chip/badge.
- Make a text field's value a link to the parent node/entity (checkbox "Link to Content").
- Wrap a datetime field's formatted date in a custom tag + class.
- Wrap a created/changed/timestamp field (e.g. published date) in a styled `<time>`-like element.
- Wrap an entity-reference *label* in a tag and link it to the host entity.
- Produce headings from computed/first fields in a view mode without a preprocess hook.
- Standardize markup across bundles by choosing the same tag/class in each display.
- Reduce reliance on the Fences module for simple tag-wrapping needs.
- Add a class hook to a field so JS can target it (e.g. `js-copy-target`).
- Emit inline elements like `<span class="label">` around short string fields.
- Build teaser markup where the title is an `<h3>` linking to content.
- Wrap a taxonomy/entity-reference label in `<span class="tag">` for pill styling.
- Keep field labels off but still get a wrapping element for CSS targeting.
- Apply consistent date wrappers across multiple date fields.
- Format a "string_long" field (e.g. a plain-text note) inside a `<pre>`-like block tag.
- Turn an entity reference label into a clickable link back to the referencing entity.
- Provide a minimal, dependency-light alternative for adding wrapper markup in view modes.

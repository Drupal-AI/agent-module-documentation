Fences lets you choose the HTML tags (and CSS classes) that wrap each field — the field, its label, the items wrapper, and each item — instead of Drupal's default `<div>` soup, configured per field on Manage display.

---

Drupal core wraps every rendered field in generic `<div>`s: a `<div>` around the whole field, a `<div>` around the label, and a `<div>` around each item. Fences replaces the core `field.html.twig` template with one that reads eight per-field settings and lets you pick a real HTML tag for each wrapper — for example a `<section>` for the field, an `<h3>` for the label, or nothing at all. Settings live as **third-party settings on the field's formatter** inside the `entity_view_display` config (schema `field.formatter.third_party.fences`), so each field/view-mode gets its own markup, and the choices export cleanly as config. The settings appear as a collapsible **Fences** section under each field on **Structure → Content types → *type* → Manage display** (gear icon), gated by the `edit fences formatter settings` permission. Choosing the special value `none` for a wrapper removes that tag entirely, letting you strip markup down to just the value. The available tags come from a discovery registry (`*.fences.yml`) so modules can add their own, and a global settings form controls whether the field template override applies to all themes or only when the field template comes from core. The optional **Fences Presets** submodule adds reusable named tag bundles (Inline, Inline Label, None, …) you can apply to a field in one click. It has no effect on data — only on the markup wrapped around field output — so it is safe to add to an existing site to clean up semantics and accessibility.

---

- Wrap a field in a semantic `<section>`, `<article>`, or `<aside>` instead of `<div>`.
- Render a field label as an `<h2>`/`<h3>` heading instead of a `<div>`.
- Strip all wrapper markup from a field so only the raw value is output (`none`).
- Output an address field inside an `<address>` element for correct semantics.
- Turn a multi-value field into a real `<ul>` list with `<li>` items.
- Render a quote/citation field inside `<blockquote>`.
- Make a field display inline (`<span>`) so several fields sit on one line.
- Add specific CSS classes to a field wrapper without writing a template.
- Add classes to individual field items (e.g. a grid/card class per item).
- Remove the redundant label `<div>` while keeping the label text.
- Give a field's items a wrapping `<ol>`/`<ul>` element (items wrapper tag).
- Improve accessibility by using headings and landmarks for field labels/regions.
- Reduce "div-itis" and DOM size across a content type's rendered fields.
- Configure different markup per view mode (teaser vs full) for the same field.
- Export field markup choices as config for deployment across environments.
- Let a code field render as `<pre><code>` for preformatted output.
- Wrap a byline/author field in `<cite>`.
- Apply a consistent set of tags to many fields at once using a preset.
- Give editors an "Inline" one-click preset for compact metadata rows.
- Standardize field markup site-wide without a custom theme.
- Force the Fences field template on custom themes as well as core (global setting).
- Add BEM-style classes to field/label/item wrappers directly in the display config.
- Mark up a tags/terms field as a `<nav>` region of links.
- Emit a definition list (`<dl>`/`<dt>`/`<dd>`) structure for label + value pairs.
- Restrict who can change field markup via the `edit fences formatter settings` permission.

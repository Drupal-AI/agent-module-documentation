<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# filter_allowed — the editable-allowed-HTML filter plugin

Class `Drupal\ckeditor5_allowed_html\Plugin\Filter\FilterAllowed`
(`src/Plugin/Filter/FilterAllowed.php`), extending `Drupal\filter\Plugin\FilterBase`.

Annotation:
- `id = "filter_allowed"`
- `title = "Limit allowed HTML tags and correct faulty HTML - Editable tag list"`
- `type = FilterInterface::TYPE_TRANSFORM_REVERSIBLE`

It is functionally a copy of core's `filter_html` (`Drupal\filter\Plugin\Filter\FilterHtml`); the
only meaningful difference is that the **Allowed HTML tags** field is an ordinary editable textarea
rather than the read-only field core presents for CKEditor 5.

## Install / enable

1. `drush en ckeditor5_allowed_html` (or via Extend). No dependencies beyond core `filter`.
2. Edit a text format: `/admin/config/content/formats/manage/<format>`.
3. In *Enabled filters*, check **"Limit allowed HTML tags and correct faulty HTML - Editable tag
   list"** (leave core's own filter unchecked to avoid two competing tag filters).
4. Under *Filter settings*, open its tab and edit **Allowed HTML tags**.

Editing text-format filters is gated by core's **`administer filters`** permission — a trusted,
admin-level permission. This module adds no permission, route, or menu link of its own.

## Settings (`settingsForm()`, stored in the text-format entity)

Schema: `filter_settings.filter_allowed` in
`config/schema/ckeditor5_allowed_html.schema.yml`.

- `allowed_html` (string, textarea) — the editable tag/attribute list. If empty, `settingsForm()`
  seeds this default:
  `<br> <p> <h2> <h3> <h4> <h5> <h6> <strong> <em> <sup> <blockquote> <a href> <ul> <ol start> <li> <table> <tr> <td rowspan colspan> <th rowspan colspan> <thead> <tbody> <tfoot> <caption> <drupal-media data-entity-type data-entity-uuid alt>`
- `filter_html_help` (boolean) — show the "basic HTML help" tips table in long tips.
- `filter_html_nofollow` (boolean) — add `rel="nofollow"` to all `<a>` on output.

`setConfiguration()` collapses runs of whitespace in `allowed_html`
(`preg_replace('/\s+/', ' ', …)`) to match core's admin JS, and nulls the cached `$restrictions`.

## Allow-list syntax

Same grammar as core's filter:
- `<tag>` allows the tag with no attributes.
- `<tag attr>` allows `attr` with any value; `<tag attr="v1 v2">` restricts to listed values.
- Attribute-name wildcard: `<tag data-*>` (trailing `*`, must have a prefix).
- Attribute-value wildcard: `<a class="jump-*">` (prefix + `*`).
- `lang` and `dir` (values `ltr`/`rtl`) are always allowed on every element.

## Enforcement pipeline (`process()`)

1. `getHTMLRestrictions()` parses `allowed_html` into `['allowed' => [...]]`. It protects trailing
   `*` with a sentinel, then parses with the **Masterminds HTML5** stack
   (`DOMTreeBuilder` + `Scanner` + an anonymous `Tokenizer` subclass whose `setTextMode()` is a
   no-op) so raw-text elements such as `<iframe>`/`<script>` are parsed as elements. It walks
   `//body//*` via `DOMXPath`, recording each tag and its allowed attributes/values.
2. It always appends the global `*` rule:
   `['style' => FALSE, 'on*' => FALSE, 'lang' => TRUE, 'dir' => ['ltr' => TRUE, 'rtl' => TRUE]]` —
   so inline `style` and every `on*` handler are never allowed.
3. `process()` removes the `*` pseudo-tag, then calls **`Xss::filter($text, array_keys(allowed))`**
   for tag-level filtering (this is core's well-tested XSS filter; it also strips event-handler
   attributes and dangerous URL protocols such as `javascript:`).
4. `filterAttributes()` reloads the result with `Html::load()`/`DOMXPath` and, per allowed tag,
   removes attributes not on the allow-list and prunes attribute values to the allowed set
   (`filterElementAttributes()`, `findAllowedValue()` handling exact and prefix matches). Global
   allowed attributes are merged in via `array_filter($restrictions['allowed']['*'])` (so only
   `lang`/`dir` survive globally).
5. If `filter_html_nofollow` is on, every `<a>` gets `rel="nofollow"`.
6. Returns a `FilterProcessResult` with the serialized, trimmed HTML.

## Tips (`tips()`)

Renders the standard core-style filter tips: a line listing the allowed tags (via the `@tags`
placeholder, so it is auto-escaped) and, when `filter_html_help` is on, a static examples table
plus an HTML-entities table. The example markup is hardcoded, not user-supplied.

## Operational notes

- Because the list is hand-maintained, it does **not** auto-update when toolbar buttons change
  (unlike core's filter). Keep it in sync with the buttons/plugins you enable, and export it with
  the format config (`filter_format.<id>`).
- The always-forbidden `style`/`on*`/JS-URL protections and reliance on `Xss::filter` mean the
  filter's baseline safety matches core's `filter_html`. As with core, the allow-list is only as
  safe as what a trusted `administer filters` operator types into it — add only the tags you need.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Code field: `text_long_prism` (widget `text_prism`, formatter `prism_default`)

A self-contained way to store and render one highlighted code snippet on any fieldable entity,
independent of any text format.

## Field type — `text_long_prism`

`src/Plugin/Field/FieldType/TextPrismItem.php`, extends core `TextItemBase`.
Category: "Prism" (falls back to "Text" on core < 10.2 via `hook_field_info_alter`).
Default widget `text_prism`, default formatter `prism_default`.

Storage columns:
- `value` — `text`/`blob` (`size: big`), the code snippet; required.
- `languages` — `varchar(255)`, the chosen Prism language machine name; optional.

## Widget — `text_prism`

`src/Plugin/Field/FieldWidget/TextPrismWidget.php`. Renders:
- a **textarea** (`#type: textarea`) for the code — settings `rows` (default 5) and `placeholder`;
- a **language `<select>`** whose `#options` are `PrismConfig::getLanguages()` intersected with the
  languages enabled at `/admin/config/content/prism/settings` (`prism.settings:languages`). So the
  site settings form curates the picklist authors see.

## Formatter — `prism_default`

`src/Plugin/Field/FieldFormatter/TextPrismFormatter.php`. For each item renders:

```html
<div class="prism-wrapper" rel="LANGUAGE"><pre><code class="language-LANGUAGE">…value…</code></pre></div>
```

and attaches `prism/drupal.prism`. The **value** is escaped with `Html::escape()` and passed through
`nl2br()`, so newlines are preserved and the stored code is not interpreted as HTML. The formatter
has no configurable settings.

## Setup

1. Install the Prism library at `/libraries/prism/` (see start.md).
2. Add a field of type **Text (prism)** to a content type / entity.
3. At `/admin/config/content/prism/settings`, tick the languages you want offered in the widget.
4. Configure the widget's rows/placeholder on the form-display; place the formatter on the view-display.

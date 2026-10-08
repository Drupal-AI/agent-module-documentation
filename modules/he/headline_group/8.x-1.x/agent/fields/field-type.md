<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# headline_group field type — reference

A composite (multi-property) field type bundling three text values and rendering them as one semantic heading. Attach it like any field: **Structure → Content type → Manage fields → Add field → Headline Group**.

## Storage schema (`HeadlineGroupItem::schema`)
Three columns, each `type: text`, `size: medium`, `not null: FALSE`:

| Column     | Property (`string`) | Widget input          |
|------------|---------------------|-----------------------|
| `superhead`| Superhead           | textfield, maxlength 255 |
| `headline` | Headline            | textfield, maxlength 255 |
| `subhead`  | Subhead             | textfield, maxlength 255 |

`isEmpty()` returns FALSE unconditionally — the item is never pruned as empty, so a storage row is written even when all parts are blank.

## Field-instance settings

| Setting             | Type     | Default              | Effect |
|---------------------|----------|----------------------|--------|
| `include_superhead` | checkbox | `include_superhead`  | Show/hide the superhead input in the `headline_complete` widget. |
| `include_subhead`   | checkbox | `include_subhead`    | Show/hide the subhead input in the `headline_complete` widget. |
| `title_behavior`    | radios   | `headline_is_flexible` | Headline vs. entity title (below). |

`title_behavior` values (constants on `HeadlineGroupItemInterface`):
- `headline_is_blank` (`HG_BLANK`) — headline stands alone; placeholder "The main headline".
- `headline_is_flexible` (`HG_OVERRIDE`, default) — leaving the headline empty copies the parent entity title in at submit time; placeholder/description advertise the title.
- `headline_is_title` (`HG_PROHIBIT`) — headline input disabled; value always overwritten with the parent entity title.

The copy/overwrite happens in `BaseHeadlineWidget::massageFormValues()`; the title source is resolved by `getParentTitle()` (entity form, Inline Entity Form `$form['#entity']`, or Layout Builder `AddBlockForm`/`UpdateBlockForm` section-storage entity context).

## Widgets
- **`headline_complete`** (default) — a `fieldset` containing: superhead textfield (if `include_superhead`), headline textfield (always, from `BaseHeadlineWidget::formElement`), subhead textfield (if `include_subhead`).
- **`headline_headline_only`** — inherits `BaseHeadlineWidget` unchanged: only the headline textfield. Use where superhead/subhead are irrelevant regardless of instance settings.

## Formatter `headline_default`
Display settings:

| Setting                | Type              | Default          | Notes |
|------------------------|-------------------|------------------|-------|
| `headline_group_tag`   | select allowlist  | `div`            | `div`, `h1`–`h6` only. |
| `headline_group_class` | textfield (64)    | `headline-group` | Outer class; blank falls back to `headline-group`. |
| `headline_group_bem`   | checkbox          | TRUE             | Inner classes `{class}__super/head/sub` vs. bare `super/head/sub`. |
| `headline_group_anchor`| checkbox          | FALSE            | Adds `id="{Html::cleanCssIdentifier(headline)}"` when a headline exists. |

Rendered structure (parts omitted when empty; whole item skipped when all three empty):
```html
<h2 class="headline-group" id="my-headline">
  <span class="headline-group__super">Analysis</span>
  <span class="headline-group__head">My Headline</span>
  <span class="headline-group__sub">A short standfirst</span>
</h2>
```
Each part is the `#value` of core's `html_tag` element, so it is filtered with `Xss::filterAdmin()`: inline admin-safe HTML (e.g. `<em>`, `<strong>`, `<a>`) survives; `<script>`, `on*` handlers and dangerous protocols are stripped. The outer tag is not user-controllable (fixed select); the class and anchor are admin display config, and the anchor id is passed through `Html::cleanCssIdentifier()`.

## Worked example (field config YAML sketch)
```yaml
# field.field.node.article.field_hero_headline (settings)
settings:
  include_superhead: include_superhead
  include_subhead: include_subhead
  title_behavior: headline_is_flexible

# core.entity_view_display … component settings for the formatter
type: headline_default
settings:
  headline_group_tag: h1
  headline_group_class: hero-headline
  headline_group_bem: true
  headline_group_anchor: false
```

## Tokens
`headline_group.tokens.inc` registers a token **type** `headline_group` with tokens `headline`, `superhead`, `subhead`. `hook_tokens` substitutes from `$data['headline']` / `$data['superhead']` / `$data['subhead']`, so a caller must pass those keys in the token `$data` array — this is not the standard per-entity field token you get for free. Replacement values are inserted verbatim into the token pipeline (whatever consumes the token is responsible for output safety).

# `[vvjf:FIELD]` tokens — first-row field values in view text areas

## What it is

`Drupal\vvjf\Hook\VvjfTokenHooks` registers a **`vvjf` token namespace** so you can print a field value
from the **first row** of a VVJF view inside that view's Global text areas. Normal Views Twig tokens
(`{{ title }}`) do **not** work with this style, so `vvjf` tokens are the supported substitute.

- `[vvjf:FIELD_NAME]` — the field's **rendered HTML** (run through `Xss::filterAdmin`).
- `[vvjf:FIELD_NAME:plain]` — **plain text** (`strip_tags` + `Html::decodeEntities`).

`FIELD_NAME` is the Views **field machine id/alias** (e.g. `title`, `field_image`, `body`). Token names
must match `^[a-zA-Z0-9_]+(:plain)?$` (`ValidationBounds::TOKEN_PATTERN`); anything else is logged and
skipped.

## Where to use it

In the view's **Header**, **Footer**, or **No results / Empty** area, add a *Global: Text area* or
*Global: Unfiltered text* handler and tick **"Use replacement tokens from the first row."** Then embed
`[vvjf:…]` tokens. Examples:

```
[vvjf:title]          → linked/rendered title of row 1
[vvjf:field_image]    → rendered image of row 1
[vvjf:title:plain]    → row 1 title as plain text (good for aria/headings)
```

The Views UI also shows this same guidance in the style plugin's collapsible **Token Documentation**
section (built by `VvjStylePluginBase::buildTokenDocumentation()`).

## How resolution works

`VvjfTokenHooks` registers the namespace via `hook_token_info()` (type `vvjf`, `needs-data => 'view'`) and
delegates `hook_tokens()` to the shared **`vvj_core.token_resolver`** service, passing `Flipbox::class`.
The resolver is injected as `@?vvj_core.token_resolver` (nullable) so the container still compiles during
the v1 → v2 upgrade window before `vvj_core` is enabled; `tokens()` returns `[]` when it is null or when
`$type !== 'vvjf'`. Key behaviours (`TokenResolver::resolve()`):

- Fires **only** when `$data['view']` is a `ViewExecutable` whose `style_plugin` is the `Flipbox` style — a
  `vvjf` token in a non-VVJF view resolves to nothing.
- Reads `$view->result[0]` (first row); resolves each token against the display's field handlers via
  `$handler->advancedRender($first_row)`, rendering array output in isolation.
- HTML form → `Markup::create(Xss::filterAdmin($rendered))`; `:plain` form →
  `Html::decodeEntities(strip_tags($rendered))`.
- Bubbles the display's cache metadata; a field with no handler is skipped; per-token exceptions are logged
  to the `vvj_core` channel and replaced with `''`.

There is no PHP-facing token service in `vvjf` itself — resolution is entirely the `vvj_core` service,
reached through the standard Drupal token pipeline that the ticked "replacement tokens from the first row"
checkbox triggers.

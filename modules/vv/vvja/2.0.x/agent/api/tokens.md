# `[vvja:FIELD]` tokens — first-row field values in view text areas

## What it is

The module registers a **`vvja` token namespace** so you can print a field value from the **first row**
of a VVJA view inside that view's Global text areas. Normal Views Twig tokens (`{{ title }}`) do **not**
work with this style, so `vvja` tokens are the supported substitute.

- `[vvja:FIELD_NAME]` — the field's **rendered HTML** (run through `Xss::filterAdmin`).
- `[vvja:FIELD_NAME:plain]` — **plain text** (`strip_tags` + `Html::decodeEntities`).

`FIELD_NAME` is the Views **field machine id/alias** (e.g. `title`, `field_image`, `body`). Token names
must match `^[a-zA-Z0-9_]+(:plain)?$` (`ValidationBounds::TOKEN_PATTERN`); anything else is logged and
skipped.

## Where to use it

In the view's **Header**, **Footer**, or **No results / Empty** area, add a *Global: Text area* or
*Global: Unfiltered text* handler and tick **"Use replacement tokens from the first row."** Then embed
`[vvja:…]` tokens. Examples:

```
[vvja:title]          → linked/rendered title of row 1
[vvja:field_image]    → rendered image of row 1
[vvja:title:plain]    → row 1 title as plain text (good for aria/headings)
```

## How resolution works

`Drupal\vvja\Hook\VvjaTokenHooks` registers the namespace via `hook_token_info()` (type `vvja`,
`needs-data => 'view'`) and delegates `hook_tokens()` to the shared **`vvj_core.token_resolver`**
service, passing `Accordion::class`. Key behaviours (`TokenResolver::resolve()`):

- Fires **only** when `$data['view']` is a `ViewExecutable` whose `style_plugin` is the `Accordion`
  style — a `vvja` token in a non-VVJA view resolves to nothing.
- Reads `$view->result[0]` (first row); resolves each token against the display's field handlers via
  `$handler->advancedRender($first_row)`, rendering array output with `renderer->renderInIsolation()`.
- HTML form → `Markup::create(Xss::filterAdmin($rendered))`; `:plain` form →
  `Html::decodeEntities(strip_tags($rendered))`.
- Bubbles the display's cache metadata; a field with no handler is skipped; per-token exceptions are
  logged to the `vvj_core` channel and replaced with `''`.

There is no PHP-facing service in `vvja` itself — token resolution is entirely the `vvj_core` service
described above, reached through the standard Drupal token pipeline (`\Drupal::token()->replace()` or
the Views token replacement that the ticked checkbox triggers).

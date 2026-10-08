# Theme, rendering & auto-injection

All three entry points (global auto-injection + the two blocks) build a render array with a
`#theme` hook and let Twig produce a `wa.me` link.

## Theme hooks (`hook_theme()` in whatsapp_bubble.module)

| Theme hook | Template | Variables |
|---|---|---|
| `wab` | `templates/wab.html.twig` | `phone_number`, `message`, `alignment`, `valignment`, `attributes` |
| `wab_button` | `templates/wab-button.html.twig` | `phone_number`, `small_text` (default `'Contact us via'`), `attributes` |

## Link construction

`templates/wab.html.twig` (bubble):
```
<a href="https://wa.me/{{ phone_number }}?text={{ message }}" ... class="wab-link"> <svg…/> </a>
```
`templates/wab-button.html.twig` (button):
```
<a href="https://wa.me/{{ phone_number }}" target="_blank" class="whatsapp-bubble--btn whatsapp-bubble--link">…</a>
```
The scheme/host `https://wa.me/` is hard-coded; only the number is appended to the path. The
prefilled message (`?text=`) exists on the bubble only; the PHP side runs `urlencode($message)`
before passing it as the `message` variable. Both templates print variables through standard Twig
`{{ }}` output (autoescaped). The `<svg>` is an inline FontAwesome WhatsApp glyph.

## Auto-injection and library (whatsapp_bubble.module)

- `hook_page_bottom()` — on every **non-admin** route (`router.admin_context->isAdminRoute()`
  short-circuits), if `whatsapp_bubble.config:is_enabled` is truthy, builds the `wab` render array
  with classes `['whatsapp-bubble', $alignment, $valignment, $inverse]` and cache tag
  `config:whatsapp_bubble.config`. So the floating bubble appears site-wide with no block placement.
- `hook_page_attachments()` — unconditionally attaches the `whatsapp_bubble/main` library to every
  page (the blocks also attach it via `#attached`).
- `hook_help()` — help text on `help.page.whatsapp_bubble`.

## Library & CSS classes

`whatsapp_bubble.libraries.yml` → library `main`: CSS `css/whatsapp_bubble.css` (no JS).

CSS classes to target when theming:
- Container: `whatsapp-bubble` (position: fixed, z-index 1700).
- Horizontal: `left` / `right` / `center`. Vertical: `top` / `middle` / `bottom`.
- `inverse` — green (`#25D366`) background, white icon.
- Bubble link: `a.wab-link`; icon: `svg.wab`.
- Button variant: `whatsapp-bubble--btn`, `whatsapp-bubble--link`, `icon-btn-whatsapp`,
  `sup-btn-whatsapp`, `message-wrapper`.

Override the look by placing a template of the same name in your theme, or by overriding the CSS
(the library is theme-layer CSS, so it is easy to supersede).

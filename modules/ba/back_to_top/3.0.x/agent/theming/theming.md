# Theming & front-end assets

## Libraries (`back_to_top.libraries.yml`)

| Library | Assets | Purpose |
|---|---|---|
| `back_to_top/back_to_top_js` | `js/back_to_top.js` | Behavior; depends on `core/jquery`, `core/drupal`, `core/drupalSettings`, `core/once`. Attached on every page (unless prevented). |
| `back_to_top/back_to_top_icon` | `css/back_to_top.css` (theme) | Styles the **image** (PNG-24) button. Attached when `back_to_top_button_type` is `image`. |
| `back_to_top/back_to_top_text` | `css/back_to_top_text.css` (theme) | Styles the **text/CSS** button. Attached when `back_to_top_button_type` is `text`. |

Assets are attached by `hook_page_attachments()` in `back_to_top.module`; the trigger
distance and scroll speed are passed to JS through
`drupalSettings.back_to_top`. The bundled button image is `backtotop.png` / `backtotop2x.png`.

## Injected markup

`js/back_to_top.js` (the `Drupal.behaviors.backtotop` behavior) appends this to `<body>` the
first time it runs (guarded by `once`), using `back_to_top_button_text` as the label:

```html
<nav aria-label="Back to top">
  <button id="backtotop" aria-label="Back to top">Back to top</button>
</nav>
```

To restyle the button, target `#backtotop` (and `body #backtotop` to beat the module's own
specificity). The button `fadeIn()`s once `window.scrollTop()` exceeds the trigger and
`fadeOut()`s below it; clicking runs an eased `requestAnimationFrame` scroll to 0 that is
cancelled if the user scrolls, clicks, or presses a key.

## Color overrides (text button only)

For the text button, `hook_page_attachments()` builds an inline `<style>` in `html_head`
overriding `body #backtotop` — but only for color keys whose value differs from the default
(`back_to_top_bg_color`, `back_to_top_border_color`, `back_to_top_text_color`, and a
`body #backtotop:hover` rule for `back_to_top_hover_color`). Leaving a color at its default
emits no inline CSS, so your theme's stylesheet wins. Placement (positions 2–9) is likewise
injected as inline `left`/`top`/`margin-left` rules on `body #backtotop`.

## `hook_back_to_top_admin_prevent` alter

`is_adminpage()` computes whether the current route is an admin route, then invokes
`\Drupal::moduleHandler()->alter('back_to_top_admin_prevent', $is_admin)`. Implement
`hook_back_to_top_admin_prevent(&$is_admin)` in a custom module to force the button on or off
for specific routes when "Prevent on administration pages" is enabled.

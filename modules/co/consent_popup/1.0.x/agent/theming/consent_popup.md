<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming — Consent Popup

## Theme hook & template

- Hook: **`consent_popup`** (declared in `consent_popup_theme()`), single variable **`items`**,
  template `templates/consent-popup.html.twig`. Override by copying that file into your theme's
  `templates/` (e.g. `consent-popup.html.twig`) and clearing caches.
- Shipped markup:

  ```twig
  <div id="javali-popup">
    <div class="consent-text"><h2>{{ items.text|raw }}</h2></div>
    <div class="consent-buttons">
      <button class="accept">{{ items.accept }}</button>
      <button class="decline">{{ items.decline }}</button>
    </div>
    <a class="visually-hidden" href="{{ items.url }}">{{ items.url_text }}</a>
  </div>
  ```

- `items` keys (set in `ConsentPopupBlock::build()`): `text` (message, already
  `Xss::filterAdmin()`-filtered), `accept`, `decline` (button labels), `url` (resolved decline
  URL), `url_text` (link label). The `.accept` / `.decline` / `#javali-popup` selectors and the
  `visually-hidden` class are what the JS keys off — keep them if you override the template.

## CSS & the colour variable

- Stylesheet `css/consent-popup.css` (library `consent_popup/consent_popup`, `theme` group).
- The outer overlay is themed on `.block-consent-popup` (the block wrapper): `position: fixed`,
  full viewport, `z-index: 1000`, hidden by default (`display: none`), shown as a centered flexbox
  only when `body.consent-popup-opened` is present. `body.consent-popup-opened` also sets
  `overflow: hidden` to lock scrolling.
- Overlay background comes from the CSS custom property **`--consent-popup-bg-color`** (fallback
  `rgb(0,0,0,0.8)`), which the JS sets on `document.documentElement` from
  `drupalSettings.consent_popup.bg_color` (composed in `build()` from `design.color` +
  `design.color_opacity`).
- Blur: elements matching the configured selectors get class **`blurred-element`**; the rule
  `.consent-popup-opened .blurred-element { filter: blur(7px) }` (with a 1s transition) applies
  while the popup is open. The inner card is `#javali-popup` (white, ~20–28rem, responsive at
  `min-width: 48em`).

## JavaScript contract (`js/consent-popup.js`)

`Drupal.behaviors.consent_popup` reads `drupalSettings.consent_popup`:

| Setting | Meaning |
|---|---|
| `cookie_name` / `cookie_life` | cookie to read/write and its lifetime in days |
| `bg_color` | value written to `--consent-popup-bg-color` |
| `text_decline` | HTML injected via `$('#javali-popup .consent-text').html('<h2>…</h2>')` on decline (non-redirect) |
| `to_blur` | array of CSS selectors to add `blurred-element` to |
| `non_blocking` | decline still allows the page (cookie set `true`) |
| `redirect` / `redirect_url` | decline redirects (`window.location.replace`) after 500 ms |

If you replace the front-end wholesale, note the module depends on `core/jquery` and `core/once`
and toggles state purely through the `consent-popup-opened` body class and the named cookie —
there is no server round-trip for the accept/decline choice.

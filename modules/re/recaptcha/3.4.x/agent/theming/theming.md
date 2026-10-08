# Theming

One theme hook (`recaptcha_theme()` in `recaptcha.module`):

- **`recaptcha_widget_noscript`** — template `templates/recaptcha-widget-noscript.html.twig`,
  variable `widget` (`sitekey`, `recaptcha_src_fallback`, `language`). Rendered only when
  `widget.noscript` is enabled, providing an `<iframe>`-based fallback for browsers without
  JavaScript. Override the template in your theme to customize the fallback markup.

The interactive widget itself is Google-rendered markup (`<div class="g-recaptcha">` + Google's
`api.js`), so it is not themed via Twig; adjust its look with the `widget.theme`/`size`/`type`
settings. Frontend behavior is in the `recaptcha/recaptcha` library (`js/recaptcha.js`).

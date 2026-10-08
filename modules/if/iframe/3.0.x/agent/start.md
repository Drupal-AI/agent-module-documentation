# iframe — agent start

Defines a single `iframe` **field type** (URL + width/height/title + styling attributes) with
three widgets and four formatters, built on core `field` and `link`. No admin settings page
(configure is `null`); everything is per-field via Field UI. Default widget
`iframe_urlwidthheight`, default formatter `iframe_default`.

- Add an iframe field, pick a widget, set field/widget defaults, choose a formatter, allowed
  attributes → [configure/iframe.md](configure/iframe.md)
- Theme the rendered iframe (`iframe.html.twig`, theme hook, header level) → [theming/iframe.md](theming/iframe.md)

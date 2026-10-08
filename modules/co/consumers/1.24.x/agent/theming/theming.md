# Theming

The module registers a `consumer` theme hook (`consumers_theme()`) with the default template
`templates/consumer.html.twig`, used when a consumer entity is rendered in a view mode.

Available Twig variables (see `template_preprocess_consumer()`):

| Variable | Meaning |
|---|---|
| `client` | The consumer entity (`#consumer`). |
| `label` | Rendered label. |
| `description` | Rendered description. |
| `image` | Rendered logo image. |
| `content` | All rendered child elements. |
| `view_mode` | Current view mode. |

Override by copying `consumer.html.twig` into your theme, or add a
`consumer--<view-mode>.html.twig` suggestion. Useful for building a public "our apps" / API
client showcase page.

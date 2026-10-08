# bg_image_formatter — agent start

Adds an image-field formatter (`bg_image_formatter`, label "Background Image") that renders
an image field as a CSS `background-image` on a selector, injected into the page `<head>`,
instead of an `<img>`. Extends core `ImageFormatter`; depends on core `image`. Configured on
an entity's **Manage display** screen — there is no admin settings page (`configure` is null).

- Apply the formatter + its selector / image-style / background CSS settings → [configure/bg_image_formatter.md](configure/bg_image_formatter.md)
- How the CSS is built and attached to the page (tokens, multivalue, AJAX) → [theming/bg_image_formatter.md](theming/bg_image_formatter.md)

Submodule: **responsive_bg_image_formatter** (media-query-based responsive backgrounds) —
see `../../modules/responsive_bg_image_formatter/1.18.x/agent/start.md`.

# responsive_bg_image_formatter — agent start

Submodule of **bg_image_formatter**. Adds the `responsive_bg_image_formatter` formatter
("Responsive Background Image") for `image` fields, subclassing `BgImageFormatter`. Uses a
core **responsive image style** to emit one CSS `background-image` rule per breakpoint/source
(with retina variants) instead of a single background. Depends on `bg_image_formatter` and
core `responsive_image`. Configured on **Manage display**; no admin page (`configure` null).

- Apply the formatter + responsive image style / CSS settings → [configure/responsive_bg_image_formatter.md](configure/responsive_bg_image_formatter.md)
- How per-breakpoint CSS rules are generated and attached → [theming/responsive_bg_image_formatter.md](theming/responsive_bg_image_formatter.md)

Parent module: `../../../../1.18.x/agent/start.md`.

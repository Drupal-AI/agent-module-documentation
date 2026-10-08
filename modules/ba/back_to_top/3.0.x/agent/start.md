# back_to_top — agent start

Adds a hovering "back to top" button that smoothly scrolls the page up. A front-end
library is attached to every page by `hook_page_attachments()`; behavior is driven entirely
by the `back_to_top.settings` config object. Config UI: **Admin → Config → User interface →
Back To Top** (`/admin/config/user-interface/back_to_top`), route `back_to_top_settings`,
gated by the `access back_to_top settings` permission. No external libraries, no submodules.

- Settings keys, defaults, positions, visibility rules, permission → [configure/settings.md](configure/settings.md)
- Libraries, CSS, injected markup, color styling, the admin-prevent alter → [theming/theming.md](theming/theming.md)

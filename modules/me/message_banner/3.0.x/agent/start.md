# Message Banner — agent index

One dismissible, site-wide message banner. Single settings form + `hook_page_attachments`;
rendered client-side via `drupalSettings.messageBanner` and `js/message_banner.js`.
Config: `message_banner.settings` (`/admin/config/user-interface/message-banner`).

- **All settings keys, permissions, defaults, JS behavior, caching** →
  [configure/settings.md](configure/settings.md)
- **`hook_message_banner_colors_alter` to add banner colors** → [hooks/colors.md](hooks/colors.md)

Key facts:
- Config object `message_banner.settings`; save timestamp stored in state key `banner_saved`.
- Two permissions: `manage message banner` (gates the form), `view message banner` (whether the
  banner is attached for a user; granted to anonymous + authenticated on install).
- Banner text = `check_markup(banner_text.value, banner_text.format)` — admin-authored rich text.
- Theme hook `message_banner` (template `templates/message-banner.html.twig`), preprocess adds
  `#message-banner` id, `.message-banner` class, and the `banner_color` value as a class.
- Off admin routes unless `banner_enabled_on_admin_routes`; cache context `user.roles`.

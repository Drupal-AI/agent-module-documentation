<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
- What: shows a configurable sitewide announcement in a modal, driven by an admin form and a block plugin.
- When: you need to broadcast a temporary notice (maintenance, promo, policy update) to all visitors.

---

- Enable the module; it ships CSS/JS libraries (`announcement_modal/announcement_modal.announcements`) and a block.
- Configure at `/admin/config/announcement_modal` (route `announcement_modal.announcement_settings`, `administer site configuration`); the route is `no_cache: TRUE`.

---

- Provides the `administer announcement modal configuration` permission for delegated management.
- Settings form `AnnouncementSettings` stores the announcement content and toggle in config.
- Ships an `Announcement` block plugin (`src/Plugin/Block/Announcement.php`) to place the modal.
- Attaches the `announcement_modal.announcements` library (CSS in `css/`, JS in `js/`) that opens the modal.
- Use it to show one active announcement across the whole site.
- Place the block in a region (e.g. header/content) via Block layout so the modal renders.
- The admin route is marked `no_cache` so edits appear immediately.
- Style overrides go through the module's CSS library or your theme.
- Enable/disable the announcement from the settings form without removing the block.
- Content is authored by an admin; sanitize/trust the markup you enter.
- The JS controls modal open/close behavior on page load.
- Grant `administer announcement modal configuration` to editors who manage notices.
- No public routes are exposed beyond the admin form.
- Clear caches if the library changes don't appear.
- Suitable for single global announcements rather than per-page targeting.
- Version 2.0.x supports Drupal 8/9/10.

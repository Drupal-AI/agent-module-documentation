<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GLightbox — agent index

Integrates the pure-JS GLightbox library: image field formatters that open images/videos in a
responsive lightbox popup, plus a global settings form.

- **Global settings (`glightbox.settings`), route, and key config groups** →
  [configure/settings.md](configure/settings.md)
- **The image field formatters (`glightbox`, `glightbox_responsive`) and their per-field settings** →
  [configure/formatter.md](configure/formatter.md)
- **Override GLightbox JS options in code** → [hooks/settings-alter.md](hooks/settings-alter.md)

Key facts:
- Configure route `glightbox.admin_settings` → `/admin/config/media/glightbox`
  (permission `administer site configuration`). Depends on core `image`.
- Config object `glightbox.settings` with groups `custom`, `advanced`, `plyr`. Schema also defines
  `field.formatter.settings.glightbox`.
- Formatters (both for `image` fields): `glightbox` and `glightbox_responsive`.
- Requires external JS libraries in `/libraries`: GLightbox (`levmyshkin/glightbox`), DOM Purify
  (`levmyshkin/dom_purify`), Plyr (`levmyshkin/plyr`, for video).
- Services: `glightbox.activation_check` (`?glightbox=no` disables it), `glightbox.attachment`
  (attaches assets, prefers local over CDN), `glightbox.gallery_id_generator`, `glightbox.formatter`.
- Submodule **glightbox_inline** (opens on-page elements/pages/media in the lightbox via a link
  class) — see [../../modules/glightbox_inline/1.0.x/agent/start.md](../../modules/glightbox_inline/1.0.x/agent/start.md).
- No permissions of its own, no Drush, no plugin types. Hook: `hook_glightbox_settings_alter()`.

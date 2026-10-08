<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media: Tyler Data & Insights — agent index

Embeds Tyler Technologies Data & Insights (Socrata) visualizations as Drupal Media. Provides a media
**source** plugin, a **field formatter**, and a validation **constraint**; its only config is an
allowed-hosts list. Depends on core `media`.

- **Allowed-hosts config, settings form, and CSP integration** →
  [configure/allowed-hosts.md](configure/allowed-hosts.md)
- **The media source / formatter / constraint plugin IDs and how to set up a media type** →
  [plugins/media.md](plugins/media.md)

Key facts:
- Config object: `media_tyler_data_insights.settings` → `allowed_hosts` (sequence of `https://` origins).
- Configure route: `media_tyler_data_insights.allowed_hosts_settings` → `/admin/config/media/tyler-data-insights`.
- Permission: `administer media_tyler_data_insights hosts` (manage the allowed-hosts list).
- Plugin IDs: media source `media_tylerdi`, field formatter `media_tyler_data_insights`, validation
  constraint `media_tyler_data_insights`. Source field type is `string_long`.
- Optional `drupal/csp`: hosts are appended to the `frame-src` CSP directive on non-admin routes.

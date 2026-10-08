<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Social Link Field — agent index

Provides a multi-value **`social_links`** field type (each item = a platform id + a profile
link), a `social_links` widget, and two formatters (`font_awesome`, `network_name`). Platforms
are pluggable. One global boolean setting controls whether Font Awesome is auto-attached.

- **Add/configure a social_links field, widget + formatter options, the global settings page, permission** →
  [configure/field-and-settings.md](configure/field-and-settings.md)
- **Add a new social platform (SocialLinkFieldPlatform plugin) / list the built-in ones** →
  [plugins/platform.md](plugins/platform.md)

Key facts:
- Field type id `social_links` (columns `social`, `link`); default widget `social_links`;
  default formatter `font_awesome`. Other formatter: `network_name`.
- Global config: `social_link_field.settings` → `attached_fa` (bool). Route
  `social_link_field.settings` = `/admin/config/services/social-link-field`. Permission
  `configure social link field`.
- Plugin type: `SocialLinkFieldPlatform` annotation, manager service
  `plugin.manager.social_link_field.platform`, discovered in `Plugin/SocialLinkField/Platform/`.
- No Drush commands.

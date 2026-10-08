<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# social_media (Social media share) — agent index

Renders configurable social share/follow links for the current page as a block
(`social_sharing_block`) or a field. All behavior lives in one config object,
`social_media.settings`, keyed by network. No permissions, plugin types, or Drush
commands of its own. Depends on Token and core Field.

- Configure networks (enable/label/url/icon/attributes), the block, and the Email
  forward form → [configure/settings.md](configure/settings.md)
- Read/build the block programmatically; render pipeline and cache tags →
  [api/block.md](api/block.md)
- Add or alter networks from another module via the dispatched events →
  [hooks/events.md](hooks/events.md)

Admin UI: `/admin/config/services/social-media` (route `social_media.admin_form`,
permission `administer site configuration`).

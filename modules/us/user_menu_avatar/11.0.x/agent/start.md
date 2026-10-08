<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User Menu Avatar (user_menu_avatar) — agent index

Replaces the *title* of the user account menu links with the current user's avatar image
and/or name. It targets links routed to `user.login` (anonymous — the "Log in" link) and
`user.page` (authenticated — the "My account" link) via `hook_preprocess_menu`, swapping the
link title for `FormattableMarkup` that renders an image (as a CSS `background-image`) and/or
a name span, then attaches a small CSS library and a per-`user` cache context.

Depends only on core `user`. Core requirement `^10 || ^11` (release version `11.0.0` tracks the
core major, not semver). No permissions of its own; the settings form is gated by core
`administer site configuration`. No drush, no plugin types.

Settings: `/admin/config/people/user-menu-avatar` (route `user_menu_avatar.config`), config
object `user_menu_avatar.settings`.

- **Configure what/how the avatar and name display** → [configure/settings.md](configure/settings.md)
- **How links get replaced (which menus/routes, cache, library)** → [hooks/menu.md](hooks/menu.md)
- **Reuse the image-resolution service (`umas`)** → [api/services.md](api/services.md)
- **CSS library and classes used for styling** → [theme/styles.md](theme/styles.md)

Key facts:
- Config object: `user_menu_avatar.settings`. Route: `user_menu_avatar.config`. Configure
  permission: `administer site configuration`.
- Service id: `umas` → `Drupal\user_menu_avatar\Services\UserMenuAvatarServices`.
- Hook: `user_menu_avatar_preprocess_menu()` (also `user_menu_avatar_help()` renders README.md).
- Library: `user_menu_avatar/styles` (`css/user-menu-avatar.css`).
- Targeted routes: `user.login` (anonymous markup), `user.page` (authenticated markup).
- Default avatar field: `user_picture`; default image style: `medium`; supports either an
  `image` field or an `entity_reference` (media) field with `field_media_image`.
- Install hook `user_menu_avatar_update_8001()` clears the legacy `link_text` config key.

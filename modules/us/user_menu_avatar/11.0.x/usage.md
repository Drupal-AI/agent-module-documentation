<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User Menu Avatar swaps the text of the account menu links — "Log in" for anonymous visitors, "My account" for authenticated users — with the current user's avatar image and/or name, giving Drupal's account menu the picture-as-entry-point treatment familiar from most modern applications.

---

Drupal's user menu shows plain text links. This module makes the avatar treatment configuration rather than theme code: a settings form at `/admin/config/people/user-menu-avatar` (gated by `administer site configuration`) chooses, for authenticated and anonymous states independently, whether to show a picture, a name, or both. At render time `hook_preprocess_menu` walks every menu, finds links routed to `user.page` (authenticated) or `user.login` (anonymous), and replaces their titles with markup that draws the avatar as a CSS `background-image` — shaped (circle or square) and sized from config — beside an optional name span; a `visually-hidden` name is always kept for screen readers. The image comes from a configurable user field (default `user_picture`), which may be a plain image field or an entity-reference field pointing at a media item with `field_media_image`; a configured image style (default `medium`) is applied unless the file is an SVG, and the field's default image is used when the user has none. Names default to `getDisplayName()` but can be overridden by a custom field or a fixed string. The module attaches its small CSS library and a per-`user` cache context only on links it actually rewrites, and depends on nothing beyond core `user`.

---

- Show the logged-in user's profile picture in the account menu.
- Replace the "My account" text link with an avatar.
- Match the account-menu convention of modern applications.
- Show the username alongside the avatar.
- Show only the picture, keeping the name for screen readers.
- Show only the name when no picture is wanted.
- Give an intranet a familiar account entry point.
- Use a default field image for users without a picture.
- Style the avatar as a circle or a square.
- Set the avatar pixel size without touching theme code.
- Choose which image style renders the avatar.
- Pull the avatar from a custom user field instead of `user_picture`.
- Pull the avatar from a media (entity-reference) field.
- Override the displayed name with a custom user field.
- Override the displayed name with fixed text like "My Account".
- Show a custom avatar image to anonymous visitors.
- Customise the anonymous "Log in" label.
- Keep SVG avatars unstyled while styling raster images.
- Personalise the header for logged-in users.
- Distinguish logged-in from anonymous state visually.
- Reduce theme overrides for a common account-menu need.
- Reinforce identity on a members' or community site.
- Improve discoverability of the profile/settings link.
- Apply the treatment to any menu that contains the account links.

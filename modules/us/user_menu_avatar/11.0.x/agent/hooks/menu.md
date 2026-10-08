<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hook — menu link replacement

Implemented in `user_menu_avatar.module`.

## `user_menu_avatar_preprocess_menu(&$variables)`

Runs on **every** rendered menu (no menu-name restriction). It builds the anonymous and
authenticated replacement markup once, and if either is non-empty it walks `$variables['items']`
recursively (into each item's `below` children) via `uma_apply_markup()`.

For each menu link, matching is by **route name**, not menu:

- Link routed to **`user.login`** → its `title` is replaced with the *anonymous* markup
  (`uma_anon_markup()`).
- Link routed to **`user.page`** → its `title` is replaced with the *authenticated* markup
  (`uma_auth_markup()`).

Because matching is purely by route, any menu containing a `user.login` / `user.page` link is
affected (in a stock site this is the "account" menu shown in the toolbar).

On a replacement it also:

- attaches the library `user_menu_avatar/styles`, and
- adds the `user` cache context to the menu render array (`$variables['#cache']['contexts'][] = 'user'`),
  so each user's menu caches separately.

## What the markup contains

Built with `FormattableMarkup` (placeholders are escaped). Three shapes per state:

- image **and** name → `<div class="uma-flex-wrapper">` with a `.uma-image` span (avatar as a
  CSS `background-image`, sized/shaped from config) + a `.uma-name` span;
- image **only** → `.uma-image.image-only` span + a `.visually-hidden` name span (name kept for
  screen readers);
- name **only** → `.uma-name.name-only` span.

Preconditions:

- **Anonymous markup** appears when the user is anonymous and either an anonymous avatar resolves
  (`display_anonymous_avatar = yes` and a file is uploaded) or `display_anonymous_text = yes`.
- **Authenticated markup** appears when the user is authenticated and either the avatar image
  resolves (`display_menu_avatar = yes` and the field yields an image) or `display_user_name = yes`.

Image resolution (`uma_image()`) reads the configured `avatar_image_field` off the current user:
an `image` field goes through `umas::getFieldImage()`, an `entity_reference` (media) field through
`umas::getMediaFieldImage()`. The name (`uma_name()`) follows the precedence documented in
[../configure/settings.md](../configure/settings.md).

## Other hook

`user_menu_avatar_help()` returns the module `README.md` on `help.page.user_menu_avatar` (rendered
through the `markdown` filter if that module is present, otherwise wrapped in `<pre>`).

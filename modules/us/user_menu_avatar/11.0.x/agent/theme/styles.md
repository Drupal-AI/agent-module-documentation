<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theme — library & CSS classes

Library `user_menu_avatar/styles` (`user_menu_avatar.libraries.yml`) attaches
`css/user-menu-avatar.css` (as `theme`-weight CSS). It is attached automatically by
`user_menu_avatar_preprocess_menu()` whenever a menu link title is replaced — you do not attach
it manually.

## Markup / classes produced

The avatar is rendered as a `<span class="uma-image ...">` with the image set as an inline
`background-image` (not an `<img>`), sized via inline `width`/`height` from `avatar_size`.

| Class | Role |
|-------|------|
| `.uma-flex-wrapper` | Wrapper when both image and name show (`display:flex; align-items:center`). |
| `.uma-image` | The avatar span; `background-size:cover; background-position:center`, no repeat. |
| `.uma-image.shape-circle` | Circular avatar (`border-radius:50%`); the alternative is `shape-square` (unstyled square). |
| `.uma-name` | The visible name span; gets `margin-left:1rem` inside `.uma-flex-wrapper`. |
| `.uma-name.name-only` | Name-only variant (no image). |
| `.uma-image.image-only` | Image-only variant; pairs with a `.visually-hidden` name span for screen readers. |
| `.image-only .visually-hidden` | Standard visually-hidden pattern so the name stays accessible. |

`shape-<shape>` and the pixel size come from the `avatar_shape` / `avatar_size` config keys — see
[../configure/settings.md](../configure/settings.md). To restyle, override these classes in your
theme (e.g. change the square variant, add a border, or adjust the name gap).

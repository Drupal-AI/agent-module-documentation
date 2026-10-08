<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Scene (media_scene) — agent index

**CKEditor 5 toolbar buttons that set a Media Library image as a styled background (size, overlay tint, focal point, parallax) behind field content, referencing the media entity so updates propagate.**

- **Version:** 1.0.x (release 1.0.3) — core `^10.3 || ^11`
- **Depends:** ckeditor5, editor, file, media, media_library
- **Config:** `/admin/config/media/media-scene` (`administer media scene`, restricted) — the image style for backgrounds
- **Buttons:** Add Background Image, Background Scene Settings, Remove Background Image; opener `media_library.opener.media_scene` (image type only); `MediaSceneResolver` renders at display time.
- **Filter:** enable **Render Media Scene backgrounds** on restricted (Limit-allowed-HTML) text formats; Full HTML works without it.
- **Security:** settings route permission-gated (restricted); editing needs only core **View media**. No anonymous or mutating endpoints. No security findings.

See [configure/settings.md](configure/settings.md).

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Style Options: Media adds a "Background media" style-option plugin that lets site builders attach a Media Library item (image, video, or remote video) plus a CSS blend mode to a layout component or paragraph through the Style Options system.

---

The base Style Options module only offers a managed-file image upload for backgrounds, which cannot reuse responsive image styles or point at a video. Style Options: Media fills that gap with a single `@StyleOption` plugin, `background_media`, whose configuration form exposes a Media Library element (bundles `image`, `video`, `remote_video`) and a Blend Mode select (the 16 CSS `mix-blend-mode` / `background-blend-mode` values). At render time the plugin loads the chosen media entity and builds it with the `background` view mode (falling back to `default` if that view mode is not configured), placing the render array under `#style_options_media` on the element so a Layout Builder layout template or paragraph behavior template can print it and apply the blend mode. To use it, add the `background_media` option to a `[module|theme].style_options.yml` configuration file; the module ships no routes, permissions, services, config, or schema of its own.

---

- Attach a Media Library image as a component background instead of a plain managed-file upload.
- Use a video or remote video (e.g. YouTube/Vimeo via `remote_video`) as a layout background.
- Reuse responsive image styles by driving the background through a media entity + `background` view mode.
- Pick a CSS blend mode (multiply, screen, overlay, etc.) for a background media treatment.
- Add background media to a Layout Builder section or block via Style Options.
- Add background media to a Paragraphs component through the Style Options paragraph behavior.
- Expose the `background_media` option only on the layouts/paragraph types you list in `*.style_options.yml`.
- Let editors choose backgrounds from the shared Media Library rather than re-uploading files.
- Centralize background assets as reusable media entities across many components.
- Define a `background` media view mode to control exactly how the background renders.
- Fall back gracefully to the `default` media view mode when `background` is not set.
- Combine an image background with a color overlay using a blend mode.
- Give themers a predictable `#style_options_media` render slot to template against.
- Build hero sections with a full-bleed media background.
- Provide art-directed backgrounds that respect image style breakpoints.
- Offer editors a curated background experience without granting file-system access.
- Enable the plugin only where a media background is actually needed.
- Keep the option out of layouts that should not have backgrounds by omitting it from their config.
- Migrate from the base Style Options image option to media-driven backgrounds.
- Standardize blend-mode choices across a design system.
- Pair with the Media and Media Library core modules already required for media entities.

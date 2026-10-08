<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layout Builder Backgrounds adds a "Background" panel to the Layout Builder configure-section form so an editor can give any section a CSS background color and/or a background image chosen from the media library; the values are applied as inline styles on the section's layout wrapper at render time.

---

The mechanism is small and worth knowing exactly. The module implements `hook_form_layout_builder_configure_section_alter()` to add three fields to the section configuration modal: a **Color** textfield (any CSS color string), a **media_library** **Image** picker limited to the `image` bundle, and a **Background position** select (nine `left/center/right` × `top/center/bottom` options). A custom submit handler (`_layout_builder_backgrounds_section_form_submit`, unshifted ahead of core's) writes `color`, `media` (the media entity ID), and `position` into the section's layout configuration array under the key `layout_builder_backgrounds` — it is stored as **Layout Builder section settings** in section storage (per-view-mode default layout, or a per-entity override), not as a config entity, and the settings are removed entirely when both color and image are cleared. There is **no config schema, no permission, no admin form, and no Drush command** — the module's entire surface is these two hooks plus a `hook_help` and `hook_preprocess_layout`.

Rendering happens in `hook_preprocess_layout()`: when a section carries the settings, the module adds the class `layout-builder-backgrounds` and builds an inline `style` on the layout element. A color becomes `background-color: <color>;`; an image is resolved by loading the `Media` entity, reading its source file, and calling `File::createFileUrl()`, then emitting `background-image: url(<file-url>); background-position: <position>; background-size: cover; background-repeat: no-repeat;`. So the image is always the **original managed file** (no image style / responsive image — a full-bleed original is a real page-weight and LCP concern), the fit is hard-coded to `cover` + `no-repeat`, and everything is **inline CSS on the wrapper** rather than a stylesheet or a data attribute. The heavy dependency list — core `image`, `media`, `media_library`, plus **`layout_builder_styles`** (whose `ConfigureSectionForm` the alter hook expects) and **`media_library_form_element`** (which supplies the `media_library` form element) — is what makes the image side work; the module itself ships no CSS or JS. Two things to keep in mind operationally: because a section can be configured on a **per-entity layout override**, whoever holds that permission controls what CSS color string lands in the page, and because backgrounds are decorative inline styles, contrast and screen-reader concerns are entirely on the editor — nothing here validates either.

---

- Add a background image to a Layout Builder section from the media library.
- Set a solid background color on a section (hex, named, `rgba()`, etc.).
- Alternate white and tinted bands down a landing page.
- Give a hero or call-to-action section a full-bleed photographic background.
- Choose the focal point of a section's background image via the position select.
- Reuse a managed, access-controlled media image as a section background.
- Style sections without writing a layout plugin per background variant.
- Add backgrounds to existing custom or Bootstrap layouts without modifying them.
- Set a per-page background on a per-entity layout override.
- Set a default-layout background for a whole view mode.
- Emphasize a testimonial or pricing band with a color.
- Build a marketing page's visual rhythm inside Layout Builder.
- Remove a section background by clearing both the color and the image.
- Combine a color with an image (color shows while/where the image is absent).
- Complement `layout_builder_styles` class-based styling with ad-hoc backgrounds.
- Set a section background using a CSS color function like `rgba(0,0,0,.5)`.
- Apply `background-size: cover` framing to a section image automatically.
- Position a background image (e.g. `center top`) for responsive cropping.
- Give a content editor per-section background control inside the layout UI.
- Prototype a design's banded structure quickly without theme changes.

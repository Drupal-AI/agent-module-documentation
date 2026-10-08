<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Timeline Styles (timeline_styles) — agent index
**Views style plugins that render rows as a chronological timeline, with an image variant and a ready-made content type/view.**

- **Version:** 2.0.x (release `2.0.1`)
- **Core:** `^9.3 || ^10 || ^11`
- **Depends on:** `views`, `color_picker`, `color_field`.
- **Views style plugins:** `timeline_styles` (`src/Plugin/views/style/TimelineStyle.php`) and `timeline_styles_image` (`TimelineStyleImage.php`). Both `usesRowPlugin`/`usesRowClass`/`usesGrouping`; one option — the title field (`timeline_style_field`), plus `timeline_style_image` for the image variant.
- **Theme:** hooks `timeline_style` / `timeline_style_image`; `template_preprocess_timeline_styles()` builds the per-row `nav`; library `timeline_styles/global-styling` attached in `hook_views_pre_render`.
- **Ships (config/install):** node type `timeline_styles` (date/color/icon/image/tags fields), `timeline_styles_tags` vocabulary, display modes, an image style, and a demo `timeline_styles` view.
- **Surface:** no routes, permissions, controllers or custom forms (only the Views style options form).

**Security:** Front-end display only — no routes, permissions, or external calls; no mutating or anonymous endpoints. Field output goes through Views field handlers and standard Twig templates (no raw markup sinks in the plugins). No security findings.

See [plugins/views-style.md](plugins/views-style.md).

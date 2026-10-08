<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Laces Base installs a starter configuration and a set of Bootstrap 5 grid layouts for building sites with the Layout Builder ecosystem and the companion Laces theme.

---

The module ships mostly configuration: an article content type (`laces_article_layout`) with Layout Builder enabled, a Laces image field, a large library of image styles, media view modes and responsive image styles, and Bootstrap breakpoints. In code it provides four Layout plugins — one/two/three/four column (`OneColumn`…`FourColumn`) — each rendering a Bootstrap 5 `container`/`row`/`col` structure with a selectable container breakpoint (`container`, `container-sm` … `container-fluid`, `container-edge`). A `hook_plugin_filter_layout__layout_builder_alter` removes the duplicate core layouts (`layout_onecol`, `layout_twocol_section`, etc.) so only the Laces layouts appear in Layout Builder, and `hook_preprocess_layout` promotes `#row_attributes` into a Twig `Attribute` object. On install it copies bundled Bootstrap Styles settings into `bootstrap_styles.settings`. The module defines no routes, controllers, permissions or outbound HTTP, so it has no request-facing or credential surface — it is purely site-building scaffolding intended for administrators.

Typical setup: install the Laces theme and this module, then use Layout Builder on the provided content type with the Bootstrap column layouts and the supplied image/responsive-image styles.
---
- Install a ready-made Bootstrap 5 site base for Layout Builder.
- Add a Layout Builder-enabled `laces_article_layout` content type.
- Lay out sections with the one-column Laces layout.
- Lay out sections with the two-column Laces layout.
- Lay out sections with the three-column Laces layout.
- Lay out sections with the four-column Laces layout.
- Choose a container breakpoint (sm/md/lg/xl/xxl/fluid/edge) per layout section.
- Render edge-to-edge sections with the `container-edge` option.
- Use the bundled Laces image styles (xs–xxl) for content images.
- Use the hero image styles for banner imagery.
- Apply the responsive image styles (full/half/quarter/…/hero) to media.
- Configure media view modes for images at various page fractions.
- Configure remote-video view modes at various widths.
- Rely on the provided Bootstrap breakpoints for responsive behaviour.
- Hide the duplicate core Layout Builder/Discovery layouts automatically.
- Seed Bootstrap Styles settings on install.
- Pair with the Laces Bootstrap 5 theme for full functionality.
- Build article pages without hand-writing layout config.
- Extend the provided layouts with additional Bootstrap classes in a subtheme.

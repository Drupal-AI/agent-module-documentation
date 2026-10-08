<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Laces Base (laces_base) — agent index
**Installs base configuration and four Bootstrap 5 grid Layout Builder layouts (one/two/three/four column, with selectable container breakpoints) for the Laces theme ecosystem.**

**Version:** 2.1.x  ·  **Core:** ^9.5 || ^10 || ^11  ·  **Package:** Laces
- **Depends:** node, breakpoint, layout_builder, layout_discovery, media, media_library, responsive_image.
- **Layouts (`laces_base.layouts.yml`):** `laces_base_onecol|twocol|threecol|fourcol` → `Drupal\laces_base\Plugin\Layout\{One,Two,Three,Four}Column`; each adds a `container_type` breakpoint option.
- **Hooks:** `hook_plugin_filter_layout__layout_builder_alter` removes duplicate core layouts; `hook_preprocess_layout` builds `row_attributes`; `hook_install` seeds `bootstrap_styles.settings`.
- **Config:** `laces_article_layout` content type, image styles, media view modes, responsive image styles, breakpoints.
- **Security:** no routes, controllers, permissions, or outbound HTTP — pure site-building/config scaffolding; no request-facing or credential surface. No security findings.

See [plugins/laces_base.md](plugins/laces_base.md)

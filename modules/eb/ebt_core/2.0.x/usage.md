<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Extra Block Types (EBT): Core is the base module for the EBT ecosystem — a family of custom block-type modules meant to be placed in Layout Builder. It provides the shared machinery (a per-block "EBT Settings" design field, a site-wide settings form for colors/breakpoints/widths, CSS/JS generation, and theme/template plumbing) that every `ebt_*` block-type module builds on.

---

Core itself adds no visible block type; it supplies infrastructure. It defines an `ebt_settings` field type (with `ebt_settings_default` and `ebt_settings_simple` widgets and an `ebt_settings_default` formatter) that stores per-block **design options** — margins/padding/border (box model), border color/style/radius, background color, background media (image/video/remote video with parallax), edge-to-edge, and container width — as a serialized blob, and it ships the `field_ebt_settings` field storage on `block_content`. A settings form at `/admin/config/content/ebt-core` (route `ebt_core.settings`, config object `ebt_core.settings`, permission "administer site configuration") holds site-wide defaults: primary/secondary colors, primary/secondary button text colors, a background color (default `#0d77b5`), mobile/tablet/desktop breakpoints (640/1020/1320), and named container widths (xxSmall…xxLarge). At render time hook_preprocess_block reads a block's `field_ebt_settings`, calls the `ebt_core.generate_css` service to emit scoped CSS (keyed by a per-block class) and the `ebt_core.generate_js` service to emit parallax/background-video behaviors, attaching the relevant libraries (colorpicker, parallax, jquery.mb.YTPlayer, vidbg). It also registers dynamic theme hooks/template suggestions so each enabled `ebt_*` module gets `block--block-content--<name>` / `block--inline-block--<name>` / `paragraph--<name>` templates without boilerplate. It depends on Field Group, Media Library Form Element, Block Content, and Media, and bundles two submodules: `ebt_core_remove_helper` (bulk-remove EBT blocks / field storage) and `ebt_core_starterkit` (a Drush generator for scaffolding new EBT modules).

---

- Provide the shared base for installing individual EBT block-type modules (EBT Tabs, Hero, CTA, Carousel, etc.).
- Add configurable per-block design options (margin/padding/border/background) to custom block types.
- Store block design settings in the `field_ebt_settings` field on `block_content` bundles.
- Set site-wide EBT primary/secondary brand colors used as defaults across EBT blocks.
- Configure primary/secondary button text colors globally.
- Set the default EBT background color (defaults to `#0d77b5`).
- Define responsive breakpoints (mobile 640 / tablet 1020 / desktop 1320) for EBT blocks.
- Define named container widths (xxSmall through xxLarge) for EBT layout blocks.
- Give editors a color-picker UI for choosing block/brand colors.
- Attach a background image, uploaded video, or remote (YouTube) video to a block.
- Enable a parallax background effect on a block.
- Make a block edge-to-edge (full-bleed) or constrain it to a named container width.
- Apply per-block spacing utility classes generated from the design options.
- Generate scoped, per-block CSS automatically from a block's saved settings.
- Provide template suggestions so each `ebt_*` block type gets its own Twig template automatically.
- Support EBT blocks placed via Layout Builder inline blocks or reusable block_content.
- Serve as the dependency that EBT block modules require to function.
- Bulk-remove all EBT blocks (via the `ebt_core_remove_helper` submodule) before uninstalling.
- Remove the shared `field_ebt_settings` storage when no EBT block types remain (remove helper).
- Scaffold a brand-new EBT block-type module with `drush generate ebt:module` (via `ebt_core_starterkit`).
- Reuse EBT's design-options field on your own custom block type by adding `field_ebt_settings`.
- Keep design settings out of theme code by storing them on the block entity.
- Provide a consistent design-options UX across many different block types.
- Integrate media (image/video) backgrounds via Media Library Form Element.

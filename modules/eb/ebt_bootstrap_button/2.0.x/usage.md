<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
EBT Bootstrap Button adds a `block_content` type that renders a single Bootstrap-styled button (a link) placeable anywhere, including Layout Builder.

---

EBT Bootstrap Button is a member of the Extra Block Types (EBT) family. Installing it creates a `block_content` bundle named `ebt_bootstrap_button` with two fields: a core **Link** field (`field_ebt_bootstrap_button_link`, the button target + text, required) and the shared **EBT settings** field (`field_ebt_settings`, from `ebt_core`). A custom widget, `ebt_settings_bootstrap_button` (`EbtSettingsBootstrapButtonWidget`, extending ebt_core's `EbtSettingsDefaultWidget`), adds button-specific options: Bootstrap button type (primary/secondary/success/danger/warning/info/light/dark/link), outline/active/disabled toggles, size (default/small/large), alignment, stretched, open-in-new-tab, nofollow, and a custom class name. Two Twig templates render the block for reusable and inline (Layout Builder) placement, emitting Bootstrap `btn` classes; the actual visual styling requires Bootstrap CSS in your theme. The module ships only a block type, a field widget plugin, templates, and a small view CSS library — no routes, permissions, services (beyond a `hook_help` handler), Drush commands, or settings form. Global colour/breakpoint defaults come from EBT Core.

---

- Add a Bootstrap-styled call-to-action button as a placeable block.
- Drop a button into a Layout Builder layout in a few clicks.
- Add an inline button block to a specific page via Layout Builder.
- Place a reusable button block from the Block library across many pages.
- Render a link as a Bootstrap `btn-primary` / `btn-secondary` etc. button.
- Use an outline button (`btn-outline-*`) instead of a solid one.
- Show a large (`btn-lg`) or small (`btn-sm`) button.
- Mark a button visually active or disabled.
- Left/center/right align the button within its block region.
- Stretch the button to full container width.
- Open the button link in a new tab (`target="_blank"`).
- Add `rel="nofollow"` to the button link for SEO control.
- Add custom CSS classes to a button for theme-specific styling.
- Provide editors a no-markup way to add consistent Bootstrap buttons.
- Standardize CTA styling across a Bootstrap-based site.
- Combine with other EBT block types for a full block-based page builder.
- Inherit EBT Core global colour/breakpoint design defaults.
- Override `block--block-content--ebt-bootstrap-button.html.twig` to customize markup.
- Restyle via the `ebt_bootstrap_button/ebt_bootstrap_button_view` CSS library.
- Uninstall cleanly (the block type is removed only when no instances remain).

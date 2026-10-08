<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Block Styles lets you attach a template suggestion (an alternate `block--*.html.twig`) and extra CSS classes to any placed block, choosing from styles registered through the Styles API — so you can restyle a block's wrapper without writing a custom theme hook.

---

The module adds a **"Block Styles Template"** fieldset to every block configuration form. There you pick a *style* (a template suggestion registered via the Styles API's `*.themes.yml` files, filtered to `type: block`), optionally type a **button label** (only for styles whose definition sets `extras.label`), and add space-separated **CSS classes** for the block wrapper. The choice is saved as a `block_styles` config entity (config name `block_styles.blocks.<block_id>`) holding `theme`, `classes` and `text`. At render time `hook_theme_suggestions_block_alter()` injects the style's template suggestion so Drupal uses that Twig template instead of `block.html.twig`, and `hook_preprocess_block()` adds the CSS classes and exposes the button label as `configuration.button_text`. Styles whose provider is a *theme* only apply when that theme is active. The module ships one style, **Clean Wrapper** (`block__clean`), and its submodule **Block Styles Bootstrap** adds card, collapse, dropdown, modal and popover styles. It depends on the `styles_api` module and core `block`. There is no central settings page — configuration is per block, on the block's own form.

---

- Give a specific block a custom wrapper template without registering a theme hook yourself.
- Apply the bundled "Clean Wrapper" template to strip a block down to minimal markup.
- Add utility CSS classes (e.g. `bg-light p-3`) to a single block's wrapper.
- Turn a block into a Bootstrap card wrapper (via the Bootstrap submodule).
- Present a block's content inside a Bootstrap collapse/accordion.
- Render a block as a Bootstrap modal triggered by a labelled button.
- Show a block as a Bootstrap dropdown menu.
- Wrap a block in a Bootstrap popover.
- Set a custom button label for interactive styles (modal/collapse/dropdown/popover).
- Apply different templates to the same block type in different regions.
- Add a highlight/border class to a call-to-action block.
- Standardise block wrappers across a site by reusing registered styles.
- Restrict a style to a particular theme (theme-provided styles only apply when active).
- Register your own block style with a `*.themes.yml` file and a Twig template.
- Add a "featured" wrapper class to promote a block visually.
- Keep block markup changes in config (exportable `block_styles.blocks.*`) rather than in preprocess code.
- Give editors a per-block style picker on the block form.
- Provide a consistent card layout for menu, search and custom blocks.
- Wrap a newsletter signup block in a modal to reduce page clutter.
- Add responsive utility classes to a block wrapper for a specific breakpoint.
- Apply a template suggestion so a block can be themed differently per placement.
- Convert an informational block into a collapsible FAQ-style section.
- Attach classes needed by a JS widget to a block wrapper.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Block Breakpoint adds a per-block "Enable Block Breakpoint" setting that binds a block to one or more responsive breakpoints and, at render time, removes the block from the browser DOM whenever the selected breakpoints' media query does not match the current window.

---

The module works entirely through Drupal's block third-party settings, not a visibility-condition plugin. `hook_form_block_form_alter()` and `hook_form_layout_builder_configure_block_alter()` inject an **Enable Block Breakpoint** checkbox, a **breakpoint group** select (defaulting to the breakpoint group of the default theme) and a multi-value **breakpoints** select into the block configuration form; the breakpoint list is AJAX-refreshed when the group changes. Selections are stored on the block (or Layout Builder `SectionComponent`) as third-party settings under the `block_breakpoint` namespace (`enabled`, `breakpoint_group`, and a `breakpoints` sequence of `{breakpoint_id}` mappings — nested to avoid the dots in breakpoint IDs breaking the config system). On output, `hook_preprocess_block()` (and, for Layout Builder, `hook_preprocess_layout()` plus a `SectionComponentBuildRenderArrayEvent` subscriber) detects the enabled flag, adds the `block-breakpoint` class, attaches the `block_breakpoint/block_breakpoint` library, and sets a `data-block-breakpoint-media-query` attribute built by `BlockBreakpointManager::buildMediaQueryFromBreakpoints()` — the comma-joined `getMediaQuery()` values of the chosen breakpoints from core's `breakpoint.manager`. It also appends an inline-script render element (`block_breakpoint_inline_match` theme hook) into the block content. The frontend JS (`js/block-breakpoint.js`, loaded in the header) reads the media query and, if `window.matchMedia(query).matches` is false, calls `element.parentNode.removeChild(element)` to strip the block; a `DOMContentLoaded` handler and a `MutationObserver` re-run the check so AJAX/BigPipe-inserted blocks are handled too, and the inline `block-breakpoint-inline-match.html.twig` script removes a non-matching block as early as possible so embedded ad/tracking scripts inside it never execute. This is a client-side presentation/visibility feature (its stated goal is correct ad-impression counting), not server-side access control — the block is still rendered into the initial HTML and is only removed in the browser. There is no configuration UI, no permissions, no Drush, and no config entity of its own; everything lives on the host block's third-party settings.

---

- Show a block only on mobile viewports (e.g. a small-screen call-to-action).
- Show a block only on desktop/wide viewports and hide it on phones.
- Bind a block to a specific theme breakpoint (e.g. `mytheme.wide`) so it appears only in that range.
- Bind a block to several breakpoints at once by selecting multiple entries.
- Serve a mobile advertisement embed only on mobile so impression statistics stay accurate.
- Serve a desktop ad unit only on desktop, avoiding double-counted impressions from CSS hide/show.
- Prevent a heavy third-party embed script from running at all on screen sizes where it is not shown.
- Hide a large hero/carousel block on small screens where it would hurt performance.
- Show a compact summary block on mobile and a detailed block on desktop by giving each a different breakpoint.
- Restrict a block to the breakpoint group of a particular frontend theme.
- Apply breakpoint visibility to a block placed through the classic Block layout UI.
- Apply breakpoint visibility to a block/component placed inside Layout Builder.
- Keep breakpoint visibility working for blocks added dynamically via AJAX or BigPipe (MutationObserver rechecks them).
- Show a navigation or menu block only above a certain width where there is room for it.
- Hide a sidebar promo block on narrow screens to declutter the mobile layout.
- Conditionally load a map or video embed only on breakpoints wide enough to display it well.
- Export the breakpoint selection with the block configuration so it deploys via config management.
- Use the feature outside the Block UI in a custom Twig template by attaching the `block_breakpoint/block_breakpoint` library and adding the `block-breakpoint` class plus a `data-block-breakpoint-media-query` attribute.
- Wrap arbitrary conditional Twig markup with the inline-match template so its contents are never processed when the media query does not match.
- Drive block visibility from real responsive breakpoints rather than duplicating media queries in custom CSS.

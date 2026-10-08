<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Advanced Shortcodes extends the Shortcode module with a set of ready-made Bootstrap markup shortcodes that editors enable per text format.

---

The Shortcode module provides a text-format filter that turns `[tag]...[/tag]` bracket codes into HTML at render time. Advanced Shortcodes adds nine such shortcode plugins under `src/Plugin/Shortcode/*Shortcode.php`: `alerts`, `column`, `row`, `accordion`, `accordions`, `icon`, `jumbotron`, `progress` and `hr`. Each plugin's `process()` method assembles a `#theme` render array that is rendered by a matching Twig template under `templates/` (the theme hooks are declared in `advanced_shortcodes_theme()`). Bootstrap styling and an accordion accessibility script are attached on every non-admin page through `hook_page_attachments()` (`advanced_shortcodes_page_attachments()`), pulling the `advanced_shortcodes/bootstrap` and `advanced_shortcodes/accordion-a11y` libraries.

To use it, install and enable the Shortcode dependency, enable Advanced Shortcodes, then edit a text format (Configuration → Content authoring → Text formats and editors), turn on the "Shortcodes" filter, tick the individual advanced shortcodes you want to allow, save, and clear caches. Each shortcode exposes a `tips()` string that appears in the format's filter tips to remind editors of the tag syntax and attributes. The module ships no routes, permissions, services or configuration objects of its own; everything is driven by the Shortcode filter settings on each format.

---
- Enable the "Shortcodes" filter on a text format and switch on the advanced shortcodes you need.
- Wrap content in `[alerts type="info"]message[/alerts]` to render a Bootstrap alert box.
- Choose the alert style with `type` 1-success / 2-info / 3-warning / 4-danger.
- Build responsive grids with `[column cols="6" begin="1" end="1"]...[/column]`.
- Set explicit breakpoints per column via the `xs` / `sm` / `md` / `lg` attributes.
- Open a Bootstrap row wrapper with the column's `begin` attribute and close it with `end`.
- Wrap columns in an explicit `[row]...[/row]` when you prefer manual row markup.
- Group collapsible panels with `[accordions]...[/accordions]` containing `[accordion]` items.
- Give each `[accordion title="..." icon="fa fa-star"]body[/accordion]` a heading and body.
- Add an inline icon element with `[icon class="fa fa-star"]label[/icon]`.
- Render a hero banner with `[jumbotron title="Welcome"]text[/jumbotron]`.
- Show a progress bar with `[progress percent="50"][/progress]`.
- Insert a styled horizontal rule with `[hr][/hr]`.
- Pass an extra `class` attribute to most shortcodes to add your own CSS classes.
- Rely on the bundled Bootstrap CSS so the markup is styled without theme changes.
- Author shortcodes directly in CKEditor source view or in plain-text fields.
- Read each plugin's filter-tips line, shown under the text-format editor, for the exact syntax.
- Combine `[row]` and `[column]` to lay out multi-column content without Layout Builder.
- Nest shortcodes inside one another; the Shortcode service processes tags recursively.
- Let the CSS/JS stay off admin pages automatically (the module skips the admin theme).
- Use the accordion accessibility script (`js/accordion-a11y.js`) for keyboard-navigable panels.
- Add shortcodes to a Full HTML or similar editor-facing format to speed up common Bootstrap layouts.

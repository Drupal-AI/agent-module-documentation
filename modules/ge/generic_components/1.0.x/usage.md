<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Generic components ships a small library of reusable Single Directory Components (SDC) — generic HTML tag, wrapper, spacer, field range, and comment — usable by any theme or Display Builder.
---
The module provides theme-agnostic SDCs under `components/`, each defined by a `*.component.yml` schema plus a Twig template (and optional CSS/JS). Examples include `generic_html_tag` (renders a single self-closing/void element whose `tag` prop is pattern-restricted to `^[a-zA-Z0-9-]+$`), `generic_html_wrapper` (wraps `content` in a configurable tag defaulting to `div`), `generic_spacer`, `field_range`, and `comment`/`comment_links` helpers. It is intended as building blocks for the Display Builder module but works anywhere Drupal's SDC system is available.

Because these are SDCs, their props are supplied by theme/site builders (via component includes or Display Builder), not by anonymous request input. Component prop schemas constrain inputs (e.g. the HTML tag pattern), and Drupal's SDC/Twig auto-escaping applies to printed props. There is no routing, no permissions, no services, and no configuration form — the module purely registers components.

Typical setup: install the module, then reference the components from your theme templates with `{{ include('generic_components:generic_html_wrapper', {...}) }}` or select them in Display Builder.
---
- Wrap arbitrary render content in a configurable HTML element.
- Insert a self-closing/void HTML tag (e.g. `<hr>`, `<br>`) via a component.
- Add vertical/horizontal spacing with the generic spacer component.
- Build layouts in Display Builder from reusable primitives.
- Provide a consistent comment display component across themes.
- Render comment action links with the `comment_links` component.
- Use `field_range` to display a range of field values.
- Compose page sections without writing new theme templates.
- Reference components with `{{ include('generic_components:...') }}`.
- Constrain HTML tag names with the built-in prop pattern.
- Keep component CSS scoped alongside each component directory.
- Preview components via their `*.story.yml` definitions.
- Standardize wrapper markup across multiple themes.
- Drop generic building blocks into a design system.
- Avoid duplicating small HTML utilities in every theme.
- Extend or override a component by re-declaring it in a theme.
- Provide props with defaults (e.g. wrapper tag defaults to `div`).
- Use as example/reference SDC implementations.
- Combine spacer + wrapper for simple spacing layouts.
- Pair with Display Builder for no-code display assembly.

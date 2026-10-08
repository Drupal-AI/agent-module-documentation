<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Generic components ships a small library of theme-agnostic Single Directory Components (SDC) — HTML tag, HTML wrapper, spacer, conditional wrapper, field range, and Drupal comment/comment-links helpers — for use with Display Builder or any theme.
---
The module registers seven SDCs under `components/`, each defined by a `*.component.yml` schema plus a Twig template (and optional CSS/JS). Layout/utility primitives — `generic_html_tag` (a single void element whose `tag` prop is pattern-restricted to `^[a-zA-Z0-9-]+$`), `generic_html_wrapper` (wraps a `content` slot in a configurable tag defaulting to `div`), `generic_spacer` (an empty div sized from an enum of pixel `size` values in a `vertical`/`horizontal`/`both` `direction`), `conditional_wrapper` (renders its optional tag plus `before`/`content`/`after` slots only when the content slot has something attached), and `field_range` (slices a multivalued field slot by `limit`/`offset`/`order`). Two Drupal-specific helpers, `comment` and `comment_links`, reconstruct the wrapper markup, classes, and JS behaviors that core's comment system normally injects but that are lost when comments are rendered through Display Builder in a full-page (non-teaser) view.

Because these are SDCs, props are supplied by theme/site builders (via `include()`/`embed` or Display Builder), not by anonymous request input. Prop schemas constrain inputs (HTML tag pattern, spacer size/direction enums, integer minimums), and Drupal's SDC/Twig auto-escaping applies to printed props and slots. There is no routing, no permissions, no services, and no configuration form — the module purely registers components. The `info.yml` declares no module dependencies, and `ui_patterns`, `ui_icons`, and `sdc_devel` appear only under composer `require-dev`. In practice, though, the `comment_links` component's `link` prop uses UI Patterns' `ui-patterns://url` type, so `ui_patterns` is an effective runtime requirement: with this module enabled but `ui_patterns` not installed, core SDC discovery cannot resolve that reference and throws `InvalidComponentException` on every request, fatally breaking the whole site. Enable `drupal/ui_patterns` (^2) alongside this module.

Typical setup: install the module, then reference a component from theme templates with `{{ include('generic_components:generic_html_wrapper', {...}) }}` (or `embed` for slots), or select the components in Display Builder.
---
- Wrap arbitrary render content in a configurable HTML element (`generic_html_wrapper`).
- Insert a self-closing/void HTML tag such as `<hr>` or `<br>` via `generic_html_tag`.
- Add vertical, horizontal, or bidirectional spacing from a fixed pixel scale with `generic_spacer`.
- Render an optional wrapper tag with before/content/after slots only when content is attached (`conditional_wrapper`).
- Limit a multivalued field to a range of items with `field_range` (limit, offset, order).
- Reverse or randomize the display order of a multivalued field's items via `field_range`.
- Rebuild Drupal's comment wrapper markup, classes, and JS in Display Builder full-page view (`comment`).
- Highlight comments authored by the content author (`by-author`) or anonymous (`by-anonymous`).
- Restore the per-user "new" comment indicator badge in a Display Builder comment display.
- Provide the "X new comments" link for a node in full-page view with `comment_links`.
- Build layouts in Display Builder from reusable, theme-agnostic primitives.
- Reference components with `{{ include('generic_components:...') }}` from any theme.
- Constrain HTML tag names with the built-in prop pattern to avoid arbitrary element names.
- Keep component CSS/JS scoped alongside each component directory.
- Preview `generic_html_wrapper` and `generic_spacer` variations via their `*.story.yml` stories.
- Standardize wrapper and spacing markup across multiple themes.
- Drop generic building blocks into a design system or component catalog.
- Avoid duplicating small HTML utilities in every theme.
- Extend or override a component by re-declaring it in a theme.
- Provide props with sane defaults (wrapper `tag` → `div`, spacer `size` → `16px`, direction → `vertical`).
- Pair with Display Builder for no-code display assembly of comments and fields.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Twig capture is a zero-configuration Twig extension for theme developers: it rewrites templates at compile time so a value filtered once (typically `x|render`) inside an `{% if %}` test is reused rather than rendered again in the following output, avoiding double rendering of the same render array.
---
It registers a `twig.extension` service providing a node visitor (`TwigCaptureNodeVisitor`) that runs during Twig compilation. When it finds a `render` filter used as an `{% if %}` condition, it hoists the expression into a `{% set foo_rendered = foo|render %}` assignment before the `if`, rewrites the condition to use that variable, and then rewrites the matching autoescaped output (`{{ foo }}`) to `{{ (foo_rendered is defined) ? foo_rendered : foo }}`. A custom `TwigCaptureCompiler` compiles expressions without debug/line-number noise so the generated variable names match. It includes backward-compatibility handling for Twig's `NameExpression`/`ContextVariable` deprecation.

There is nothing to configure and no runtime surface: no routes, permissions, forms, services beyond the Twig extension, or config schema. Because it only transforms compiled Twig it introduces no request handling and no security-relevant endpoints; the effect is purely a rendering optimisation, most visible in patterns like `{% if content.field_x|render %}...{{ content.field_x }}...{% endif %}`.
---
- Avoid rendering the same field/render array twice in a template.
- Optimise `{% if content.field_x|render %} ... {{ content.field_x }} ... {% endif %}`.
- Reuse a `|render` result captured in an `{% if %}` test as output.
- Reduce redundant render calls in field/node/entity templates.
- Speed up templates that guard optional content with a render check.
- Keep existing template syntax unchanged (transparent, automatic rewrite).
- Enable the optimisation site-wide just by installing the module.
- Work across Twig versions via built-in NameExpression BC handling.
- Apply the optimisation to any theme without template edits.
- Simplify author intent: check-and-print an optional region once.
- Cut duplicate work for expensive lazy-built render arrays.
- Serve as a reference for Twig node-visitor / compiler techniques.
- Prevent double-execution of render-array `#lazy_builder` / `#pre_render` callbacks.
- Avoid emptiness bugs where a render-checked field then prints blank.
- Fix templates where checking `|render` consumed the value before output.
- Keep field wrapper markup from rendering around already-consumed content.
- Improve render performance on entity/field templates without markup changes.
- Remove the need to manually assign `{% set x = content.field|render %}` in templates.
- Handle both `{% if x|render %}` conditions and autoescaped `{{ x }}` output automatically.

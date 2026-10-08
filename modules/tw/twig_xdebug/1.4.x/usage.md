<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Twig Xdebug lets you set an Xdebug breakpoint from inside a Twig template by writing `{{ breakpoint() }}`, so you can step into the debugger with every template variable in scope.

---

The module is a thin wrapper that registers the third-party `ajgl/breakpoint-twig-extension` library as a Twig extension (service `twig_xdebug`, tagged `twig.extension`). That extension adds a `breakpoint()` Twig function; when Twig renders a `{{ breakpoint() }}` tag it calls PHP's `xdebug_break()`, pausing execution in your IDE. The debugger stops inside the library's `BreakpointExtension.php` (not the template itself), but the current Twig `$context` (all variables available to the template), the Twig `$environment`, and any `$arguments` you passed are all inspectable in that stack frame. You can pass a value to focus on with `{{ breakpoint(fields) }}`, which surfaces as `$arguments`. It has no configuration UI, no routes, no permissions, and no config — enabling the module is the entire setup. It requires a working Xdebug installation (with step debugging listening) to be useful; without Xdebug the `breakpoint()` call is effectively a no-op. Because it exposes a developer debugging primitive, it should only be enabled in local/development environments, never production.

---

- Pause template rendering at a chosen spot to inspect every variable in scope with `{{ breakpoint() }}`.
- Debug why a Twig variable is empty or has an unexpected value at render time.
- Inspect the full `$context` array to discover exactly which variables a template receives.
- Focus the debugger on one value by passing it as an argument, e.g. `{{ breakpoint(node) }}`.
- Explore a field render array to see its structure before theming it.
- Verify what a preprocess hook actually put into `variables` by breaking in the template.
- Step through a loop by placing `{{ breakpoint(item) }}` inside a `{% for %}` block.
- Understand an unfamiliar theme by dropping breakpoints into its templates.
- Inspect the Twig `$environment` to see which functions/filters are registered.
- Confirm a template suggestion is the one actually being used by breaking inside it.
- Check the value of a `drupalSettings` or attribute variable mid-render.
- Diagnose a "variable does not exist" or type error deep inside a template.
- Debug a paragraph, block, or view row template that only renders in specific contexts.
- Teach or demo how Drupal passes data into the theme layer.
- Trace conditional theming logic by breaking on either side of an `{% if %}`.
- Inspect the render array of an embedded entity or reference field.
- Validate that a custom Twig function/filter returns what you expect at the call site.
- Debug email or other non-HTML templates rendered through Twig.
- Replace scattered `{{ dump() }}` calls with an interactive breakpoint that shows everything at once.
- Quickly enable/disable debugging by adding or removing the module without touching template logic.

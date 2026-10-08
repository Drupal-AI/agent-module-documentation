<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twig Renderable (twig_renderable) — agent index

A single Twig extension that adds one function and two filters for working with render arrays
and `Attribute` objects **from inside a Twig template**. No dependencies, no configuration, no
permissions, no config schema. Version **8.x-1.5**, core `^8 || ^9 || ^10 || ^11`.

Registered as one service, `twig_renderable.twig.attr_extension`
(`Drupal\twig_renderable\TwigExtension\RenderablesExtension`), tagged `twig.extension`,
constructed with `@renderer`.

## What it provides

- **`will_have_output(variable, ...parents)`** — function. Returns a **boolean**: whether the
  named render array (or scalar) in the template context produces non-empty output once rendered.
  Variadic path of nested keys; `needs_context` + `needs_environment`.
  Example: `{% if will_have_output('content', 'field_foo') %}`.
- **`add_class(class)`** — filter. Appends a class to a render array's `#attributes.class`, or
  calls `->addClass()` on an `Attribute`. Returns the modified renderable/attribute.
- **`merge_attributes(attributes)`** — filter. Merges an attributes array (or `Attribute`) into a
  render array's `#attributes` (via `array_merge_recursive`) or into an `Attribute` object.

## Mechanism to know

`will_have_output` walks the context with `NestedArray::getValue`; if the value is an array it
renders it through the real renderer, then **overwrites the context entry with the rendered
`#markup`** (so a later `{{ ... }}` prints the cached result instead of rendering again), strips
HTML comments when Twig debug is enabled, and returns `trim($output) != ''`. For a scalar it
returns `trim($value) != ''`. A missing/`NULL` value returns `FALSE`. Testing a variable therefore
also **finalises** it — a deliberate side effect, not a leak.

## Safety

None of the callbacks set an `is_safe` flag. `will_have_output` returns a boolean, and the filters
return renderables/`Attribute` objects that Twig escapes normally; the rendered markup carries the
safety the renderer already gave it. There is no new escaping bypass here.

## Detail

- `twig/functions-and-filters.md` — the function and both filters, signatures, examples, gotchas.

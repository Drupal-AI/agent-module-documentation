# CVA (Class Variance Authority) — manual setup guide

**CVA** (`cva`) exposes Twig's `html_cva` function inside Drupal templates so you
can build reusable, variant-driven component class lists — the *Class Variance
Authority* pattern — right in your `.html.twig` files. If you've used the CVA
library in a JavaScript project, this is the same idea for Drupal's Twig: define a
component's classes once, with named variants, and compute the final `class`
string per render instead of scattering long `class="..."` ternaries across
templates.

The module does one focused thing. It registers the `html_cva` function (shipped
by the `twig/html-extra` package) as a Drupal Twig extension, and it teaches
Drupal's Twig sandbox to allow the method calls that function needs. In a template
you call `html_cva(...)` to define a component with a `base` class, named
`variants`, `default_variant` fallbacks, and `compound_variants`; then you call
`.apply({...})` on the result to get the final class string for a given set of
variant selections.

It pairs naturally with Tailwind CSS, and with the optional `tailwind_merge`
filter (from `tales-from-a-dev/twig-tailwind-extra`) to resolve conflicting
utility classes. There is **no admin UI, no configuration, no permissions, and no
Drush commands** — you enable it and use the function in templates.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Nowhere — there is no settings page. CVA adds a Twig function you use in theme and
component templates, not an admin screen.

## How to use it

Once the module is enabled, `html_cva` is available in any Twig template. Define a
component, then apply variant selections:

```twig
{% set alert = html_cva(
  base: 'alert',
  variants: {
    color: { blue: 'bg-blue', red: 'bg-red', green: 'bg-green' },
    size:  { sm: 'text-sm', md: 'text-md', lg: 'text-lg' },
  }
) %}

<div class="{{ alert.apply({color: 'red', size: 'lg'}) }}">…</div>
{# renders class="alert bg-red text-lg" #}
```

The `html_cva()` call accepts:

- **`base`** — classes that are always applied.
- **`variants`** — a map of option name → `{ value: classes }`. Selecting a value
  adds its classes.
- **`default_variant`** — values used for any option you omit in `apply()`.
- **`compound_variants`** — extra classes applied only when several options match
  together, e.g. `[{ color: ['red'], size: ['lg'], class: 'font-bold' }]`.

`.apply(selections, extra)` takes your chosen variant values as the first
argument and, optionally, a string of extra classes as the second — handy for
passing through Drupal's own `class`/attributes:

```twig
<div class="{{ alert.apply({color: color, size: size}, class) }}">…</div>
```

Output order is deterministic: **base**, then matched **variant** classes (in
declaration order), then matching **compound** classes, then the **extra**
argument — which keeps your class strings predictable in diffs. If you use
Tailwind and want conflicting utilities de-duplicated, install
`tales-from-a-dev/twig-tailwind-extra` and chain its `tailwind_merge` filter after
`apply()`:

```twig
<div class="{{ alert.apply({color: color, size: size}, class)|tailwind_merge }}">…</div>
```

This works well for driving Single Directory Components (SDC), theme templates,
status pills, badges, cards, and any UI atom whose styling varies by a small set
of named options.

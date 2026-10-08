# Tailwind Merge Classes — manual setup guide

**Tailwind Merge Classes** (`tailwind_merge_classes`) is a developer/theming module
for people building with **Tailwind CSS** in a component-based way. It provides a
**Twig extension** that merges multiple Tailwind class lists intelligently:
conflicting utilities are resolved so the last one wins, and duplicates are removed,
leaving you with one clean, optimized class string. For example,
`tw_merge(['p-2', 'p-4'])` keeps only `p-4`. This mirrors the behaviour of the
well-known JavaScript `tailwind-merge` utility, brought into Twig.

You use it directly in your Twig templates. Alongside the default string output, it
can return an **array** via `tw_merge` with `as='array'` (or the legacy
`tw_merge_as_array` function), which is the recommended form when combining with
Drupal's `addClass()`.

There is **no configuration** — once you install and enable the module, you simply
start calling the function in your templates. It affects only class-string output
and has no content or access-control role.

One version note: the module's major version tracks Tailwind's. **Module 2.x (this
line) works with Tailwind CSS 4.x**, while module 1.x works with Tailwind CSS 3.x —
so match the module version to your Tailwind version.

This guide is written for a **human**. If you are an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (which brings in
   the underlying PHP library) and enable the module.

## How to use it

In your Twig templates, wrap your Tailwind classes in the merge function:

```twig
{# Conflicting utilities resolve to the last one; duplicates are dropped #}
<div class="{{ tw_merge(['p-2', 'p-4', base_classes]) }}">…</div>

{# Array output, recommended when feeding Drupal's addClass() #}
{% set classes = tw_merge(['p-2', 'p-4'], as='array') %}
```

The module's own "How to use" and "Real-world examples" guides on drupal.org cover
more patterns.

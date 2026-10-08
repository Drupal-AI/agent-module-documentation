# Generic components — manual setup guide

**Generic components** (`generic_components`) ships a small library of reusable
**Single Directory Components (SDC)** that any theme or Display Builder can use.
Instead of every theme reinventing the same tiny bits of markup, this module
provides theme‑agnostic building blocks — a generic HTML tag, a wrapper, a
spacer, a field range, and comment helpers — ready to drop into your templates or
assemble visually with Display Builder.

The components are deliberately plain. `generic_html_wrapper` wraps whatever
content you give it in a configurable HTML element (a `div` by default);
`generic_html_tag` renders a single self‑closing/void element such as `<hr>` or
`<br>` (its `tag` prop is restricted to a safe character pattern);
`generic_spacer` adds vertical or horizontal spacing; `field_range` displays a
range of field values; and `comment` / `comment_links` provide Drupal‑specific
comment display helpers. They are meant as primitives for the **Display Builder**
module but work anywhere Drupal's SDC system is available.

Because these are SDCs, their inputs (props) are supplied by theme and site
builders — through component includes or Display Builder — not by anonymous
visitors. Each component's schema constrains what it accepts, and Drupal's normal
SDC/Twig auto‑escaping applies to anything printed. The module has no routes, no
permissions, no services, and no configuration form: it purely registers
components.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module. Once enabled, the components
are simply available to your themes and to Display Builder.

## Where it lives in the admin menu

Generic components adds no admin page. After enabling it, the components become
available to Twig templates and to **Display Builder**. There is nothing to
configure in the admin UI.

## How to use it

From a theme or module template, include a component and pass it props:

```twig
{{ include('generic_components:generic_html_wrapper', { tag: 'section', content: content.body }) }}
```

```twig
{{ include('generic_components:generic_html_tag', { tag: 'hr' }) }}
```

The `generic_html_wrapper` tag defaults to `div` if you don't set one, and
`generic_html_tag` only accepts tag names matching its built‑in pattern
(letters, numbers, and hyphens), so you can't inject arbitrary markup through it.
If you use **Display Builder**, you can instead select these components visually
when composing a display — no template editing required. You can also override or
extend any component by re‑declaring it in your own theme.

# Twig Xdebug — manual setup guide

**Twig Xdebug** (`twig_xdebug`) lets you drop an Xdebug breakpoint straight into a
Twig template. Write `{{ breakpoint() }}` anywhere in a template and, when Twig
renders it, execution pauses in your IDE's step debugger — with every variable
the template has access to right there in scope. It is the interactive
alternative to sprinkling `{{ dump() }}` around: instead of dumping text, you stop
and inspect everything at once.

This is a **theme-development / debugging tool**. It is a thin wrapper that wires
in the third-party `ajgl/breakpoint-twig-extension` library, which adds the
`breakpoint()` Twig function. Behind the scenes that function calls PHP's
`xdebug_break()`. There is no configuration, no settings page, no routes and no
permissions — enabling the module is the entire setup.

To actually stop on a breakpoint you need a working **Xdebug** installation with
step debugging enabled and your IDE listening; without it, `breakpoint()` simply
does nothing. And because it exposes a debugging primitive, it should only ever
be enabled on **local/development** environments — never on production.

This guide is written for a **human** doing theme work. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — the required library and installing
   with Composer.

## How to use it

Once the module is enabled and Xdebug step debugging is running (with your IDE
listening), add the function to any Twig template:

```twig
{{ breakpoint() }}          {# stop here; inspect everything in scope #}
{{ breakpoint(node) }}      {# stop here, and pass `node` to focus on #}
{{ breakpoint(fields) }}    {# common: focus on the fields render array #}
```

When rendering reaches the tag, your debugger pauses. A couple of things worth
knowing:

- Execution stops **inside the library file** (`BreakpointExtension.php`), one
  frame above your template — that is expected. Your template's data is available
  from that frame.
- In the paused stack frame you can inspect:
  - **`$context`** — all variables available to the template (the Twig context);
  - **`$environment`** — the Twig environment (registered functions, filters,
    globals);
  - **`$arguments`** — whatever you passed, e.g. `fields` from
    `{{ breakpoint(fields) }}`.

Common uses: find out why a variable is empty, discover exactly which variables a
template receives, step through a `{% for %}` loop, or confirm which template
suggestion is actually rendering. When you're done debugging, remove the
`{{ breakpoint() }}` tag (or disable the module).

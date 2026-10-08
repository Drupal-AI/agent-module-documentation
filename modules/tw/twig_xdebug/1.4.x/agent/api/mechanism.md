<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twig Xdebug — mechanism & usage

## What it registers

`twig_xdebug.services.yml` registers one service:

```yaml
services:
  twig_xdebug:
    class: Ajgl\Twig\Extension\BreakpointExtension
    tags:
      - { name: twig.extension }
```

That is the entire module — it wires the third-party library
`ajgl/breakpoint-twig-extension` (Composer require `^0.3.4`) in as a Twig extension. The
extension adds a single Twig function: **`breakpoint()`**.

`twig_xdebug.install` implements `hook_requirements()` and blocks install if the class
`\Ajgl\Twig\Extension\BreakpointExtension` is missing (i.e. the Composer library was not
installed).

## Using it in a template

```twig
{{ breakpoint() }}            {# stop here, inspect everything in scope #}
{{ breakpoint(node) }}        {# stop here, and pass `node` to inspect #}
{{ breakpoint(fields) }}      {# common: focus on the fields render array #}
```

When Twig renders the tag, the extension calls PHP's `xdebug_break()`, which triggers your
IDE's step debugger (the same as a breakpoint in PHP code). Execution pauses **inside the
library file `BreakpointExtension.php`**, one frame above your template — that is expected;
your template's data is available from that frame.

## What you can inspect at the breakpoint

| Variable | Contents |
|---|---|
| `$context` | All variables available to the template (the Twig context). |
| `$environment` | The Twig environment: registered functions, filters, globals, etc. |
| `$arguments` | Whatever you passed, e.g. `fields` from `{{ breakpoint(fields) }}`. |

## Requirements & scope

- Needs a working **Xdebug** with step debugging enabled and your IDE listening; otherwise
  `breakpoint()` does nothing observable.
- No Drupal configuration, routes, permissions, config schema, or plugins — nothing to set
  up beyond enabling the module (`drush en twig_xdebug`).
- **Development only.** Do not enable on production; it exposes a debugging primitive and
  depends on Xdebug being active.

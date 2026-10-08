<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Twig Xdebug — agent index

Adds a `breakpoint()` Twig function. Writing `{{ breakpoint() }}` in a template calls
PHP `xdebug_break()`, pausing execution in your IDE with the template's variables in scope.
**No config, no routes, no permissions, no schema, no plugins.** Enabling the module is the
whole setup; you also need a working Xdebug (step debugging) to hit the breakpoint.

- **How it works, how to use `breakpoint()`, what's inspectable, the service it registers** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Service `twig_xdebug` → class `Ajgl\Twig\Extension\BreakpointExtension`, tagged `twig.extension`.
- Requires Composer lib `ajgl/breakpoint-twig-extension` (^0.3.4).
- Usage: `{{ breakpoint() }}` or `{{ breakpoint(someVar) }}`. The passed value appears as
  `$arguments` at the breakpoint; all template vars are in `$context`.
- Dev-only: enable locally, never on production.

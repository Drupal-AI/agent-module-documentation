<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Aide provides a single static utility class of convenience helpers for the routine lookups developers repeat inside Drupal hooks.
---
The `Drupal\aide\Aide` class exposes static methods such as `getCurrentPath()` (alias-aware), `getRequestUri()`, `getCurrentRouteName()`, `getCurrentNode()` and `getCurrentUser()`, plus helpers for image styles/responsive image styles, blocks and users. Each caches the underlying core service in a static so repeated calls are cheap. The class docblock explicitly reminds developers that dependency injection is preferred inside services — Aide is meant for hook code where a container isn't already injected.

It is a pure library module: no routes, permissions, config, services or database. Enabling it just makes the `Aide` class autoloadable. Because every method wraps standard core APIs read-only, it carries no security-relevant surface of its own.
---
- Get the current path as an alias in a hook.
- Read the current request URI conveniently.
- Get the current route name without boilerplate.
- Extract the current node from the route, if any.
- Get the current user object quickly.
- Build an image style URL for a file.
- Work with responsive image styles.
- Load a block entity in theme/hook code.
- Reduce repeated `\Drupal::service()` calls in hooks.
- Cache core services in statics for cheap re-use.
- Write terser `hook_preprocess` implementations.
- Avoid copy-pasting current-node lookup logic.
- Keep utility lookups consistent across a codebase.
- Use as a lightweight helper where DI is unavailable.
- Provide a common vocabulary of helpers for a team.
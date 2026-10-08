# Config Route Requirements — manual setup guide

**Config Route Requirements** (`config_route_requirements`) is a small developer
primitive that lets a module turn one of its routes on or off based on a
configuration value. It adds a new `_config` route requirement you can use in a
`*.routing.yml` file: when the referenced configuration evaluates to false, the
route is simply removed from the routing table and requests to it return a 404 — as
if the route never existed.

This is a *build-time* mechanism, not a per-request access check. The evaluation
happens when routes are rebuilt (for example after `drush cr`), so a disabled route
does not exist at all rather than being blocked on each request. The syntax mirrors
Drupal core's own module route subscriber: the value is a dot-delimited config path
(`config_object_name.key`), and you can combine several with `,` for OR and `+` for
AND. It is meant for module authors and site builders who
want a clean on/off toggle for optional endpoints — a debug route, an API endpoint,
a feature that ships disabled — without writing a custom access checker.

Because the route is *removed* rather than access-checked, this is not itself a
security boundary and does not grant or expose anything on its own: you still add
the normal `_permission` or `_access` requirements a route needs. Think of `_config`
as a feature flag for whether the route is available, and the usual access controls
for who may reach it when it is.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

The module has **no menu, settings form, or permission of its own** — it is a
developer primitive you use from code, so there is no configuration page.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. In a module's `*.routing.yml`, add a `_config` requirement to the route you want
   to gate, pointing at the configuration key that should control it:

   ```yaml
   my_module.debug_report:
     path: '/my-module/debug'
     defaults:
       _controller: '\Drupal\my_module\Controller\DebugController::report'
     requirements:
       _config: 'my_module.settings.debug_enabled'
       _permission: 'access my module debug'
   ```

   The value is a dot-delimited config path (`config_object.key`). You can combine
   several keys — `,` means OR, `+` means AND — and you can keep normal requirements
   like `_permission` on the same route.
3. Rebuild routes so the change takes effect:

   ```bash
   drush cr
   ```

   When `my_module.settings.debug_enabled` is false, the route disappears and
   returns 404; set it to true and rebuild again to bring it back. This makes it
   easy to ship optional or debug endpoints that an administrator can enable through
   configuration without any custom access code.

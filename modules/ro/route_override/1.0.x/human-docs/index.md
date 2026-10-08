# Route Override — manual setup guide

**Route Override** (`route_override`) is a **developer API module**. It does the
heavy lifting needed to cleanly take over an existing route's controller and/or
access behavior from your own custom module — without patching the module that
originally defined the route, and without hand‑writing a fragile `RouteSubscriber`
for every case.

There is **no user interface, no admin page, no routes, and no permissions** of
its own. On its own it does nothing visible; it is pure infrastructure that other
code builds on. You use it by writing a small amount of custom module code:
register a service tagged `route_override` that implements the module's override
controller interface, targeting the route you want to change. Route Override's
manager collects these tagged services, a route subscriber/filter swaps in your
controller for matching routes, and dedicated cacheable access checks
(`_route_override_access_cacheability`, `_route_override_custom_access`) let you
layer access logic on top while staying cache‑correct.

Because it changes nothing by itself, the access posture of any route you override
is entirely defined by the controller and access logic *you* write in the
implementing module. Review that code as carefully as you would any code that
governs who can reach a route.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** — this module is consumed entirely from custom
code, as described below.

## How to use it

Route Override is meant to be a dependency of your own module. In outline:

1. Have your custom module **depend on** `route_override`.
2. Add a service **tagged `route_override`** that implements the module's route
   override controller interface, targeting the route you want to change.
3. Implement your controller and (optionally) the custom/cacheable access checks
   to define the new behavior.

For the exact interfaces and service definitions, see the developer reference in
the sibling `agent/` docs (for example `agent/extend/api.md`) and the module's own
project page.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User Route Context (user_route_context) — agent index
**Context provider exposing the routed User entity as a plugin context.**

- **Version:** 2.0.x — core `^8.8 || ^9 || ^10`
- **Service:** context provider `UserRouteContext` (arg `@current_route_match`) — provides `EntityContext` of type `user`, not required
- **Behavior:** reads the route's `user` upcast parameter when present and a `UserInterface`; sets cacheable metadata
- **Security:** developer building block; no routes/permissions/forms/external calls; only reads the already access-checked route parameter.

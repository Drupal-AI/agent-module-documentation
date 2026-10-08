<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
User Route Context supplies a runtime plugin context that grabs the `User` entity from the current route, so context-aware plugins (blocks, conditions, Layout Builder, etc.) can react to the user whose page is being viewed.

---

The provider (`Drupal\user_route_context\ContextProvider\UserRouteContext`) inspects the current route's parameters; if the route declares a `user` upcast parameter and it resolves to a `UserInterface`, it exposes an `EntityContext` of type `user` with appropriate cacheability. This mirrors core's node route context but for user pages such as `/user/{user}` and its sub-routes.

Operationally it is a developer building block: a single tagged service, no routes, permissions, forms, or external calls. It only reads the already-access-checked route parameter.
---
- Show a block only on a specific user's pages
- Pass the routed user into a context-aware block
- Use the current profile user in Layout Builder
- Drive a condition plugin from the route user
- Build blocks that render data about the viewed user
- Reuse core-style context in contrib/custom plugins
- Avoid custom context providers for user routes
- Combine with block visibility conditions
- Target user edit/canonical routes with context
- Provide the user object to token or twig contexts via plugins
- Support optional context (not required) so blocks still build
- Add per-user personalization on profile pages
- Feed the routed user into a context-aware field/formatter
- Show role-specific blocks on user pages
- Enable Layout Builder overrides that reference the profile user
- Provide the user object to inline blocks
- Build a user dashboard whose blocks read the route user
- Avoid loading the user manually in block plugins

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Next.js JWT — agent index

Experimental preview URL generator for [next](../../../../2.1.x/agent/start.md) that signs preview
URLs with **JSON Web Tokens** (user-based access), as an alternative to the default `simple_oauth`
generator. Depends on `next`, `jwt`, `jwt_auth_consumer`. No configure route of its own — you select
it in `next.settings`.

- **The jwt plugin, how to select it, route/event subscribers, config** →
  [plugins/jwt.md](plugins/jwt.md)

Key facts:
- Adds preview_url_generator plugin `@PreviewUrlGenerator(id="jwt")` (label "JSON Web Tokens").
- Activate globally: `next.settings.preview_url_generator = jwt`;
  `preview_url_generator_configuration` holds `secret_expiration` + `access_token_expiration`
  (schema `next.preview_url_generator.configuration.jwt`).
- `RouteSubscriber` adds `jwt_auth` to `decoupled_router.path_translation` and
  `subrequests.front-controller` routes; `JwtEventSubscriber` adds claims on token generation.
- Access is scoped to the JWT's user/roles instead of OAuth scopes.

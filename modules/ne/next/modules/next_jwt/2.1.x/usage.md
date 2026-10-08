<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Next.js JWT is an experimental preview URL generator for the Next.js module that signs preview/draft URLs with JSON Web Tokens, giving user-based (rather than OAuth role-based) access control for decoupled preview.

---

The submodule adds a `jwt` **preview_url_generator** plugin (`@PreviewUrlGenerator(id="jwt")`) as an alternative to the default `simple_oauth` generator. Select it globally in `next.settings` (`preview_url_generator: jwt`, with `preview_url_generator_configuration` holding `secret_expiration` and `access_token_expiration`; schema `next.preview_url_generator.configuration.jwt`). When active, `NextSite::getPreviewUrlForEntity()` uses the JWT plugin to mint a signed preview URL; a `JwtEventSubscriber` adds the needed claims when the token is generated, and a `RouteSubscriber` adds the `jwt_auth` authentication provider to the `decoupled_router.path_translation` and `subrequests.front-controller` routes so the Next.js app's JWT-authenticated requests resolve paths and run subrequests as the token's user. It depends on `next`, `jwt`, and `jwt_auth_consumer`. Access is thus tied to the JWT's user/roles rather than OAuth scopes — useful when you want per-user preview permissions. There is no configuration UI of its own; you switch to it via the Next.js settings. The Next.js front end itself is external.

---

- Use JSON Web Tokens instead of simple_oauth to authenticate Next.js preview/draft requests.
- Enforce user-based (per-user) access control for decoupled preview URLs.
- Switch the Next.js preview URL generator to `jwt` in next.settings.
- Configure the JWT preview secret/token expiration for preview links.
- Let the Next.js app resolve entity paths via decoupled_router as the JWT's user.
- Run subrequests (`subrequests.front-controller`) authenticated with `jwt_auth`.
- Give editors preview access scoped to their own account rather than a shared OAuth scope.
- Add JWT auth to the decoupled data endpoints without hand-editing route options.
- Provide draft-mode preview for a headless site that already uses JWT auth.
- Integrate with the jwt / jwt_auth_consumer modules' key configuration.
- Choose a per-user preview strategy where OAuth scopes are too coarse.
- Sign preview URLs so only holders of a valid token can view unpublished content.
- Inspect the live next.settings to confirm the active generator is `jwt`.
- Set `access_token_expiration` to control how long a preview token stays valid.
- Swap between `simple_oauth` and `jwt` generators without code changes.
- Support a Next.js app that sends a JWT bearer token for preview.
- Add claims to the generated JWT via the module's event subscriber.
- Audit which preview URL generator (simple_oauth vs jwt) a site uses.
- Combine JWT preview with the iframe site previewer in Drupal.
- Provide an alternative auth path for multi-user editorial preview workflows.

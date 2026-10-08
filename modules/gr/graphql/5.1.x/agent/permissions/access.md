<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions & endpoint access model

## Static permissions (`graphql.permissions.yml`)
- `administer graphql configuration` — create/edit/delete servers; also the entity's
  `admin_permission`. `restrict access: true`.
- `bypass graphql access` — use any server regardless of per-server restrictions.
  `restrict access: true`.

## Dynamic per-server permissions (`PermissionProvider::permissions()`)
For **each** `graphql_server` entity `<id>` the module generates four permissions:
- `execute <id> arbitrary graphql requests` — run any ad-hoc query on that endpoint.
- `execute <id> persisted graphql requests` — run only persisted (stored-id) queries.
- `use <id> graphql explorer` — access the GraphiQL Explorer for that server.
- `use <id> graphql voyager` — access the Voyager graph for that server.

## Endpoint access check (`_graphql_query_access` → `QueryAccessCheck::access()`)
Evaluated per request against the server in the route:
1. `bypass graphql access` → allowed.
2. `execute <id> arbitrary graphql requests` → allowed.
3. Otherwise it inspects the parsed `operations`. **No operations → forbidden.** If any operation
   carries an inline `query` (an arbitrary query), access requires
   `execute <id> arbitrary graphql requests`. If it is a persisted query (a `queryId` with no
   inline query), access requires `execute <id> persisted graphql requests`.

So a new site grants no GraphQL access to any role by default — you must assign the relevant
per-server permission (e.g. to the *anonymous* role for a public API, or to an authenticated role
for a private one). Explorer/Voyager use `_graphql_explorer_access` / `_graphql_voyager_access`
(`ExplorerAccessCheck`, `VoyagerAccessCheck`): `bypass graphql access`, or *both* the matching
`use <id> graphql explorer|voyager` permission and `execute <id> arbitrary graphql requests`.

## CSRF handling on the POST endpoint (`QueryRouteEnhancer::assertValidPostRequestHeaders()`)
POST requests must arrive with a content type that either triggers a CORS pre-flight or carries an
explicit non-simple header:
- `application/json` and the non-standard `application/graphql` are accepted (they trigger CORS).
- `multipart/form-data` / form content (used for file uploads) is a "simple" request, so it is
  accepted only when the client sends a preflight-forcing header (`Apollo-Require-Preflight`,
  `X-Apollo-Operation-Name`, `x-graphql-yoga-csrf`), sends no `Origin`, sends an `Origin` matching
  the site host, or matches the configured CORS `allowedOrigins`; otherwise a
  `BadRequestHttpException` is thrown.

The endpoint route enables **all** authentication providers (`_auth`), so requests can be
authenticated via cookie, OAuth, basic auth, etc. Field-level access is the resolver's
responsibility (see [../extend/build-a-schema.md](../extend/build-a-schema.md)); the checks above
only gate *who may execute operations* on the endpoint.

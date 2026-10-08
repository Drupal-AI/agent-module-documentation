Consumers provides a "Consumer" entity so a Drupal site can declare every application (mobile app, SPA, third-party service) that consumes its API, and negotiate which consumer is making the current request. It is the foundation used by OAuth (Simple OAuth) and other decoupled/API modules.

---

In a decoupled setup many different clients hit the same API, and modules often need to behave differently per client — different token lifetimes, different image styles, different available scopes. Consumers models each client as a `consumer` content entity carrying a `client_id`, label, description, logo image, a "third party" flag, a "status" flag, and an "is default" flag. Site builders manage these at Admin → Configuration (the Consumers collection, route `entity.consumer.collection`), including designating one consumer as the default. At request time the `consumer.negotiator` service inspects the incoming request (a `client_id` query/header/parameter) and returns the matching Consumer, falling back to the default; a cache-vary event subscriber ensures responses vary correctly per consumer. Because Consumer is a fieldable entity, other modules (and site builders) can attach extra fields — scopes, allowed origins, secrets — so the consumer becomes a per-client configuration record. The module integrates with JSON:API (filter access hook), provides a themeable display template, granular permissions, and an alter hook for the admin list builder. It intentionally ships almost no business logic itself: it is the shared registry that Simple OAuth, JSON:API extras and similar modules build on. Installing it sets `container_rebuild_required` because it registers services and an entity type.

---

- Register a mobile app as a Consumer with its own `client_id`.
- Register a single-page/JS front end as a distinct API consumer.
- Declare a third-party integration and flag it as "3rd party".
- Designate a default consumer used when no client is specified.
- Detect which consumer is making the current API request in code.
- Provide the client registry that Simple OAuth uses to issue tokens.
- Attach custom fields (scopes, secret, allowed origins) to each consumer.
- Give each client a logo/label shown in an app catalog or admin list.
- Vary cached API responses per consumer so clients don't see each other's data.
- Enable/disable a consumer via its status flag to revoke access.
- Serve different image styles or content variants per client app.
- Restrict who can create/edit/delete consumers via permissions.
- Let API-owning teams self-register their own consumer entities.
- Filter JSON:API access to consumer entities per user.
- Alter the consumers admin list to show extra per-client columns.
- Theme a public "our apps" page using the consumer display template.
- Look up a consumer by its `client_id` from custom services.
- Fall back gracefully to a default consumer for anonymous/unknown clients.
- Track which apps consume the API for governance and auditing.
- Store per-client token expiration settings for OAuth flows.
- Build a developer portal listing all registered API consumers.
- Migrate/seed a set of known consumers during site provisioning.
- Branch business logic (rate limits, features) on the negotiated consumer.
- Provide per-client CORS or origin configuration via added fields.

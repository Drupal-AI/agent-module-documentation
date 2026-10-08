# Configuration

Configuration in miniOrange Custom API means **defining endpoints** and, just as
importantly, **securing each one**. There is no site-wide behaviour to tune — the
whole module is the endpoints you create, so treat every new endpoint as a
deliberate decision about what data leaves your site and who may fetch it.

## Open the module's admin pages

Log in as a user with permission to administer the module (an administrator by
default) and open the miniOrange Custom API admin pages from the admin menu, under
the miniOrange section.

## Define an endpoint

Working through the module's UI you will typically:

1. **Create a new API endpoint** and give it a path.
2. **Choose the data it returns** — the entity/fields or database data you want to
   expose. Return only the fields the consumer actually needs; don't expose whole
   records "just in case."
3. **Pick the HTTP method(s)** the endpoint supports. Read-only **GET** endpoints
   are available on the free tier; mutating methods (POST/PUT/DELETE) and advanced
   SQL/CRUD are premium features.
4. **Add filters or query parameters** if consumers need to narrow results
   (premium, for the advanced filtering options).
5. **Shape the response** if you need a specific JSON structure for your frontend
   (customisable responses are a premium capability).

## Secure every endpoint

This is the part that matters most, because the endpoint configuration is where
over-exposure happens:

- **Require authentication.** Do not leave an endpoint anonymous unless the data is
  genuinely public. Apply role-based access so only the intended callers can reach
  it (per-endpoint role control is a premium capability; plan your endpoints
  accordingly).
- **Expose the minimum.** Never return sensitive fields (passwords, tokens,
  personal data you don't need to share). Scope each endpoint tightly to its
  purpose.
- **Review before publishing.** Test each endpoint with the credentials a real
  caller would use, and confirm an unauthenticated request is refused when it
  should be.

## External integrations and dependent APIs

If your plan includes them, the module can also call external APIs (returning
JSON/XML/SOAP/GraphQL results) and chain "dependent" APIs for token-based
authentication flows. Store any credentials those integrations need as secrets
(environment variables / a Key entity), never hard-coded in configuration.

## Save

Save each endpoint from its form. Changes take effect for subsequent API requests
— verify the endpoint responds (and refuses unauthorised callers) before relying on
it.

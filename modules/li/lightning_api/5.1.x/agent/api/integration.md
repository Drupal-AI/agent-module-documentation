# What enabling Content API does (hooks, subscriber, helper)

Content API mostly configures and glues core JSON:API + Simple OAuth + OpenAPI. Its own code is
small:

## Operation links

- **`entity_json`** on → content entities get a "View JSON" operation linking to the entity's
  JSON:API resource URL. The helper `lightning_api_entity_json(EntityInterface $entity): ?Url`
  computes that URL from the `jsonapi.resource_type.repository` and the entity UUID.
- **`bundle_docs`** on → bundle config entities (content types, vocabularies, …) get a
  "View API Documentation" operation.

## Hooks

- `hook_entity_insert` — when `entity_json` is enabled and a **bundle** entity is created, flags
  the router for rebuild so the new type's JSON route exists.
- `hook_ENTITY_TYPE_presave` for the `content` view — on first creation, disables the Operations
  field's "Include destination" so JSON:API operations don't throw a `BadRequestHttpException`.

## RequestSubscriber (`lightning_api.request_subscriber`)

An event subscriber (constructed with the current route match + class resolver) that adjusts
API requests/responses. It is internal wiring; you do not call it directly.

## Service provider

`LightningApiServiceProvider` alters the container at build time (compatibility tweaks for the
JSON:API/OAuth stack).

## The moving parts you actually configure

| Concern | Provided by | Where |
|---|---|---|
| JSON:API resource endpoints | core `jsonapi` | `/jsonapi/...`, `jsonapi.settings` |
| OAuth2 tokens & clients | `simple_oauth` | `simple_oauth.settings`, Consumer entities |
| OAuth signing keys | this module's key form | writes paths into `simple_oauth.settings` |
| OpenAPI spec + UI | `openapi_jsonapi` + ReDoc/Swagger | `/api-docs` alias |
| "View JSON" / "View docs" links | this module | `lightning_api.settings` toggles |

So to operate the API: enable JSON:API (dependency), optionally Simple OAuth for auth, generate
keys via the key form, and toggle the two `lightning_api.settings` links as desired.

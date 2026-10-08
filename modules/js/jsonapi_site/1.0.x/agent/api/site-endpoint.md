# The site endpoint, response shape, access and alter hook (API)

## Route — `jsonapi_site.basic_settings`

`jsonapi_site.routing.yml`:

```yaml
jsonapi_site.basic_settings:
  path: '/jsonapi/site/site'
  options:
    _auth: [ 'key_auth' ]
  defaults:
    _controller: '\Drupal\jsonapi_site\Controller\JsonapiSiteController::returnJson'
    _is_jsonapi: TRUE
  methods: [ 'GET' ]
  requirements:
    _content_type_format: api_json
    _format: api_json
    _user_is_logged_in: 'TRUE'
```

- `GET` only. Both the request `Content-Type` and the negotiated response format must be
  `api_json` (`application/vnd.api+json`) — a plain `Accept: application/json` request will not match.
- `_is_jsonapi: TRUE` marks it as a JSON:API route (JSON:API's exception/normalization handling
  applies; errors come back as JSON:API `errors` documents).

## Access model

Two things gate the route:

1. `requirements._user_is_logged_in: 'TRUE'` — the resolved user must not be anonymous. Anonymous
   requests receive `403 "This route can only be accessed by authenticated users."`
   (runtime-verified on Drupal 11.4, jsonapi_site 1.0.2).
2. `options._auth: ['key_auth']` — authentication for this route is limited to the **Key Auth**
   provider. Session-cookie authentication does **not** apply here; a caller authenticates by sending
   a valid Key Auth API key. Key Auth's provider only authenticates a user who holds the
   `use key authentication` permission (`key_auth`'s `KeyAuth::access()`, `src/KeyAuth.php:92`), so
   the effective requirement is: a user account with an API key **and** the `use key authentication`
   permission. That permission is not granted to the `authenticated` role by default.

The module defines **no permissions of its own** and there is no admin/config form. The API key is
sent in the header or query parameter named by Key Auth's own `param_name` config (default `api-key`),
e.g. `curl -H 'api-key: <key>' https://site.example/jsonapi/site/site`.

## Controller and response shape

`Drupal\jsonapi_site\Controller\JsonapiSiteController::returnJson()`
(`src/Controller/JsonapiSiteController.php`) reads three config objects and returns a `JsonResponse`
(status `200`, `Content-Type: application/vnd.api+json`). Shape:

```json
{
  "jsonapi": { "version": "1.0", "meta": { "links": { "self": { "href": "http://jsonapi.org/format/1.0/" } } } },
  "data": {
    "type": "site--site",
    "id": "<system.site uuid>",
    "links": { "self": { "href": "<scheme+host><current-path>/<uuid>" } },
    "attributes": {
      "name":            "system.site:name",
      "mail":            "system.site:mail",
      "slogan":          "system.site:slogan",
      "page_front":      "system.site:page.front",
      "page_403":        "system.site:page.403",
      "page_404":        "system.site:page.404",
      "default_langcode":"system.site:default_langcode",
      "default_theme":   "system.theme:default",
      "admin_theme":     "system.theme:admin",
      "global_logo":     "system.theme.global:logo.path",
      "global_favicon":  "system.theme.global:favicon.path"
    }
  },
  "links": { "self": { "href": "<request uri>" } }
}
```

Every attribute is read straight from config with `$config->get(...)`. `data.id` is the site UUID
(`system.site:uuid`). The value is JSON:API-shaped by hand — this module does not go through JSON:API's
resource/normalizer pipeline for the payload itself.

## Extension point — `hook_jsonapi_site_data_alter(&$data)`

Right before responding, the controller calls
`\Drupal::moduleHandler()->alter('jsonapi_site_data', $data['data']['attributes'])`
(`JsonapiSiteController.php:64`). The `$data` passed by reference is the **`attributes` array**, so an
implementation can add, change, or unset any attribute. Documented in `jsonapi_site.api.php`:

```php
/**
 * Alter the information provided by jsonapi_site module.
 */
function hook_jsonapi_site_data_alter(&$data) {
  $data['additional'] = t('Some text');
  // Or adjust an existing value, e.g. unset($data['mail']);
}
```

Use it to surface additional front-end configuration values, or to tailor the payload to a given
integration. Pairing the module with **JSON:API Extras** gives a decoupled client a fuller view of
the backend API alongside these settings.

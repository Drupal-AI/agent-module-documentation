# Calling APIs & defining services

## Call an operation from code

```php
/** @var \Drupal\http_client_manager\HttpClientManagerFactoryInterface $factory */
$factory = \Drupal::service('http_client_manager.factory');
$client  = $factory->get('example_services');           // returns an HttpClient for that API
$result  = $client->call('FindPost', ['postId' => 1]);  // a GuzzleHttp\Command\ResultInterface
$data    = $result->toArray();
```

`HttpClientInterface` methods:
- `get($service_api)` (on the factory) → `HttpClient`.
- `call($command_name, array $params = [])` → executes and returns a Guzzle Command `Result`.
- `getCommands()` / `getCommand($name)` → inspect available operations.
- `getApi()` / `getClientConfig()` → the resolved API definition / Guzzle client config.
- `prepare($command_name, $params)` → a lazy client for deferred execution.
- Magic `__call`: `$client->FindPost(['postId' => 1])` also works.

## Define a service API as its own service

Extend the abstract `http_client_manager.client_base` in your `MODULE.services.yml` so the client
is injectable:

```yaml
services:
  my_api.http_client:
    parent: http_client_manager.client_base
    arguments: ['my_api']        # the service_api id
```

Then inject `my_api.http_client` (an `HttpClientInterface`).

## Declare the API

1. `MODULE.http_services_api.yml` — one entry per API:

```yaml
my_api:
  title: "My API"
  api_path: "src/api/my_api.json"   # relative to the module dir; Guzzle description (json/yml/php)
  config:
    base_uri: "https://api.example.com"
    timeout: 10
    # auth: ['user', 'pass', 'Basic']
```

2. The Guzzle **service description** at `api_path` lists `operations` (each with `httpMethod`,
   `uri`, `parameters` with a `location` of `uri`/`query`/`json`/`header`/`body`/…, `responseModel`)
   and `models`. See the example submodule's `src/api/resources/posts.yml` for a full sample
   (`FindPosts`, `FindPost`, `CreatePost`, `FindComments`).

## The services (from `http_client_manager.services.yml`)

- `http_client_manager.factory` — `HttpClientManagerFactory`; `->get($id)` builds/caches an `HttpClient`.
- `http_client_manager.http_services_api` — `HttpServiceApiHandler`; discovers all `*.http_services_api.yml`,
  applies overrides, replaces tokens, and `load($id)`s a definition.
- `http_client_manager.client_base` — abstract client (factory: `http_client_manager.factory:get`).
- `http_client_manager.api_wrapper.factory` / `.base` — the API-wrapper facade pattern (see plugins doc).
- Cache bins: `cache.http_client_manager`, `cache.http_client_manager_result`.

## Overriding a definition per environment

Overridable properties: `title`, `api_path`, `config`, `commands`. Two mechanisms (both gated by
`http_client_manager.settings: enable_overriding_service_definitions`):

```php
// settings.php
$settings['http_services_api']['example_services'] = [
  'config' => ['base_uri' => 'https://staging.example.com'],
  'commands' => ['blacklist' => ['CreatePost']],   // or 'whitelist'
];
```

You cannot set both `blacklist` and `whitelist` for one API. Definitions can also be overridden
via the `overrides` key of `http_client_manager.settings`. Parameter values support Drupal tokens,
resolved when the definition is built.

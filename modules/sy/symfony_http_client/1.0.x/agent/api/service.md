<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Consuming the Symfony HTTP client

## Install / enable
- `composer require drupal/symfony_http_client` (pulls `symfony/http-client: ^6.4 || ^7.3`).
- `drush en symfony_http_client`. PHP **8.3+** required; core `^10.3 || ^11.0`.
- Nothing to configure — no settings form, no config objects, no schema.

## How it registers (source)
`symfony_http_client.services.yml` contains only:

```yaml
services:
  _defaults:
    autoconfigure: true
    autowire: true
  Symfony\Contracts\HttpClient\HttpClientInterface: ~
```

The concrete wiring is done in PHP, not YAML, so nothing can bind to the factory service.
`SymfonyHttpClientServiceProvider::register()` adds one compiler pass:

```php
$container->addCompilerPass(new SymfonyHttpClientCompilerPass());
```

`SymfonyHttpClientCompilerPass::process()` creates a private factory definition and aliases
the interface to it (`src/SymfonyHttpClientCompilerPass.php`):

```php
$id = ContainerBuilder::hash(\sprintf('symfony_http_client.factory%s', \mt_rand()));
$container->setAlias(HttpClientInterface::class, $id);
$container->setDefinition(
  $id,
  (new Definition(HttpClient::class))
    ->setFactory([HttpClient::class, 'create'])
    ->setPublic(FALSE),
);
```

Notes:
- The alias key is `Symfony\Contracts\HttpClient\HttpClientInterface` — that is the service id
  you inject/fetch.
- The backing definition id is randomised per build (`mt_rand()`), so it is not a stable id;
  never reference `symfony_http_client.factory*` directly.
- `HttpClient::create()` is called with **no arguments** — no default options (timeout, base
  URI, headers, proxy, TLS flags) are set by this module. Behaviour is Symfony's default:
  cURL transport when available, TLS peer/host verification **on**.

## Consuming it

### Autowiring (preferred)
Because `autowire` is enabled, type-hint the interface in a service constructor:

```php
use Symfony\Contracts\HttpClient\HttpClientInterface;

final class MyService {
  public function __construct(
    private readonly HttpClientInterface $httpClient,
  ) {}

  public function fetch(): string {
    return $this->httpClient
      ->request('GET', 'https://example.com/api')
      ->getContent();
  }
}
```

### Explicit fetch
```php
$http = \Drupal::service(\Symfony\Contracts\HttpClient\HttpClientInterface::class);
$response = $http->request('GET', 'https://example.com');
```

`request()` is lazy — the transfer runs when you read the response
(`->getContent()`, `->toArray()`, `->getStatusCode()`), which enables concurrency across
multiple `request()` calls. See `tests/src/Kernel/SymfonyHttpClientTest.php`, which fetches
the service by `HttpClientInterface::class` and asserts a `ResponseInterface` is returned.

## Relationship to core `http_client`
This does not replace or alter core's Guzzle `http_client`. Both coexist. Because this client
is a bare `HttpClient::create()`, it ignores the `settings.php` proxy config, timeouts, and
core client middleware (logging, test HTTP interception) that `http_client_factory` applies to
`http_client`. Use core's `http_client` when you need those; use this when a library or Symfony
component requires the `HttpClientInterface` contract.

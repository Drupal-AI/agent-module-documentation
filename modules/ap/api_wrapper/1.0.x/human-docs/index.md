# Api Wrapper — manual setup guide

**Api Wrapper** (`api_wrapper`) is a developer tool that turns methods on your
Drupal services into HTTP endpoints without you writing a `routing.yml`. You
annotate a service class with a `#[ApiWrap]` PHP attribute and each method you
want exposed with an `#[Endpoint]` attribute; the module reflects over your
services at route-build time and registers a route for every endpoint, plus an
auto-generated documentation page describing each API's endpoints, methods and
parameters.

It is meant for quickly prototyping an internal API surface or sharing an API
contract with front-end developers via the generated docs. There is no settings
page — everything is driven by the attributes you place in your code.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Annotate a registered service class and its methods:

```php
use Drupal\api_wrapper\Attribute\ApiWrap;
use Drupal\api_wrapper\Attribute\Endpoint;

#[ApiWrap(basePath: '/my-api', label: 'My API', docPath: '/my-api/docs')]
class MyApiService {
  #[Endpoint(method: 'GET', path: 'items', label: 'List items')]
  public function list(): array { /* ... */ }
}
```

The class must be a registered service. Routes appear at
`/{basePath}/{endpoint}`, and the generated documentation for each API renders at
its `docPath` (or `/api-wrapper/docs/{apiName}`). Method parameters become route
path parameters. The documentation template can be overridden per module if you
want to restyle it.

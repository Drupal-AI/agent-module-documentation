<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTTP Request Mock — writing a ServiceMock plugin

The module registers an `http_client_middleware` (`HttpRequestMockMiddleware`)
that, for every outgoing request made through Drupal's `http_client`, asks the
`plugin.manager.service_mock` manager for the first matching **ServiceMock**
plugin and, if one applies, short-circuits the request with the plugin's mocked
`ResponseInterface` (wrapped in a `FulfilledPromise`). If no plugin applies, the
request is passed to the normal handler stack.

## Plugin location & shape
Put plugins in a module's `src/Plugin/ServiceMock/`. Implement
`ServiceMockPluginInterface` and declare the `#[ServiceMock(...)]` attribute
(legacy `@ServiceMock` annotation also supported).

```php
namespace Drupal\my_module\Plugin\ServiceMock;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\http_request_mock\Attribute\ServiceMock;
use Drupal\http_request_mock\ServiceMockPluginInterface;
use GuzzleHttp\Psr7\Response;
use Psr\Http\Message\RequestInterface;
use Psr\Http\Message\ResponseInterface;

#[ServiceMock(
  id: 'my_api',
  label: new TranslatableMarkup('Mock my API'),
  weight: 0,
)]
class MyApiPlugin implements ServiceMockPluginInterface {

  public function applies(RequestInterface $request, array $options): bool {
    return $request->getUri()->getHost() === 'api.example.com';
  }

  public function getResponse(RequestInterface $request, array $options): ResponseInterface {
    return new Response(200, [], json_encode(['ok' => TRUE]));
  }
}
```

## Selection rules
- Plugins are sorted by `weight` (ascending); the first whose `applies()` returns
  TRUE handles the request. Lower weight = higher priority.
- `hook_service_mock_info_alter(&$plugins)` can remove, reweight, or swap plugin
  classes.
- Tests can narrow the active set by setting the `http_request_mock.allowed_plugins`
  State variable to an array of plugin IDs; empty/unset = all plugins allowed.

## Intended use
Enable this module (and the module shipping your plugins) only in test/CI. It ships
a test-only `example_com` plugin under `tests/modules/` that is not enabled by the
base module. There are no routes, forms, or config — everything is code + State.

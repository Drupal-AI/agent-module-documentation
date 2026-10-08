# Plugin types

## Request Location plugins (`http_client_manager_request_location`)

Defined via `http_client_manager.plugin_type.yml` (manager service
`plugin.manager.http_client_manager.request_location`, base
`\Drupal\http_client_manager\RequestLocation\RequestLocationBase`, attribute/annotation
`RequestLocation`). These map a parameter's declared `location` in a Guzzle description to how it is
placed on the outgoing request.

Shipped locations (`src/Plugin/HttpClientManager/RequestLocation/`): `Body`, `RootlessBody`,
`FormParam`, `Header`, `Json`, `MultiPart`, `Query`, `Xml` (extending `GuzzleRequestLocationBase`).

Implement a new one when you need custom placement/serialization of request data:

```php
use Drupal\http_client_manager\Annotation\RequestLocation;
use Drupal\http_client_manager\Plugin\HttpClientManager\RequestLocation\GuzzleRequestLocationBase;

/**
 * @RequestLocation(id = "my_location", label = @Translation("My location"))
 */
class MyLocation extends GuzzleRequestLocationBase { /* visit()/after() */ }
```

## HTTP Service API Wrapper (typed facade)

Not a plugin *type* but a service-collector pattern: register a service tagged
`http_service_api_wrapper` (with an `api:` attribute) that extends
`http_client_manager.api_wrapper.base` (`HttpServiceApiWrapperBase`) to expose convenience methods
over an API. Retrieve one by tag key via the `http_client_manager.api_wrapper.factory`
(`->get('posts')`).

```yaml
services:
  my_module.api_wrapper.posts:
    class: Drupal\my_module\Plugin\HttpServiceApiWrapper\Posts
    parent: http_client_manager.api_wrapper.base
    tags:
      - { name: 'http_service_api_wrapper', api: 'posts' }
```

The wrapper's `getHttpClient()` picks the underlying service API; its methods call
`$this->call('CommandName', $args)->toArray()`. See the example submodule's
`HttpServiceApiWrapperPosts` (`findPosts()`, `findPost()`, `createPost()`, `findComments()`).

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Api Wrapper — attributes and routing

## Declare a wrapped API
```php
use Drupal\api_wrapper\Attribute\ApiWrap;
use Drupal\api_wrapper\Attribute\Endpoint;

#[ApiWrap(basePath: '/my-api', label: 'My API', docPath: '/my-api/docs')]
class MyApiService {
  #[Endpoint(method: 'GET', path: 'items', label: 'List items')]
  public function list(): array { /* ... */ }

  #[Endpoint(method: 'POST', path: 'items', label: 'Create item')]
  public function create(Request $request): array { /* ... */ }
}
```
The class must be a registered service. `ApiWrapperRoutesProvider::routes()` reflects over the cached container definitions, finds `#[ApiWrap]` classes, and for each `#[Endpoint]` builds a route at `/{basePath}/{endpoint}/{params}` bound to `serviceId:method`, plus a documentation route.

Method parameters become route path parameters (a `Request` parameter is skipped); default values become route defaults.

## Documentation
Docs render at `docPath` (or `/api-wrapper/docs/{basePath}`) through `ApiWrapperDocumentationController::documentation` using the themeable `api_wrapper_documentation` template (override `templates/api-wrapper-documentation.html.twig` in your module). Endpoint metadata is cached in State (`api_wrapper.documentation.*`).

## Access
All generated routes use `_permission: 'access content'`.

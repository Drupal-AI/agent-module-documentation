# Configuration

Swagger-PHP has one small settings form plus two permissions to grant, and then
the real work happens in your code's attributes.

## Choose the folder to scan

1. Log in as a user with the **administer swagger_php settings** permission (an
   administrator by default).
2. Go to **Configuration → Web services → Swagger-PHP**, or navigate directly to
   `/admin/config/services/swagger_php`.
3. Set the **scan folder** — the folder, relative to your Drupal root, that the
   module scans for OpenAPI attributes. The default is `modules/custom`, which
   scans all your custom modules. You can point it at any DRUPAL_ROOT‑relative
   path.
4. Save.

On each request to the spec endpoint, the module scans that folder with
`zircote/swagger-php` (automatically excluding `.git`, `.svn`, and `node_modules`),
builds the OpenAPI 3 document, and returns it. The spec response is uncached, so
it always reflects your current code. Remember the scanner only reads attributes —
it never runs the scanned code.

## Grant the spec and docs permissions

The module defines two access permissions on the **People → Permissions** page:

- **access swagger_php spec** — who may fetch the raw OpenAPI JSON at `/api/spec`.
- **access swagger_php docs** — who may view the Swagger UI page at `/api/docs`.

Neither is granted by default, so the spec and docs are not public until you assign
them. Grant them only to the roles that should see your API — an OpenAPI document
enumerates your endpoints and their parameters, so only expose it to anonymous
users if you genuinely intend the API to be publicly documented.

## Document your code with attributes

Add `zircote/swagger-php` attributes (`use OpenApi\Attributes as OA;`) to the code
inside your scan folder. For example, to document a custom REST resource:

```php
#[OA\Info(
  version: "1.0.0",
  description: "API documentation for my custom API",
  title: "My Custom API"
)]
#[RestResource(
  id: 'my_custom_resource',
  label: new TranslatableMarkup('Custom API endpoint to send data to.'),
  uri_paths: [
    'create' => '/api/v1/custom/add',
  ],
)]
class MyCustomResource extends ResourceBase {

  #[OA\Post(path: '/api/v1/custom/add', operationId: 'my_custom_resource_add')]
  #[OA\Response(response: '200', description: 'The processed data')]
  public function post(array $data): ModifiedResourceResponse {}

}
```

Once annotated, visit `/api/docs` to browse the generated documentation, or fetch
`/api/spec` for the JSON. See the
[swagger-php documentation](https://zircote.github.io/swagger-php/) for the full
range of `#[OA\...]` attributes.

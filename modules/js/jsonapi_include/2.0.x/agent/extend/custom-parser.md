<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Customize the parsing

The flattening is done by the service **`jsonapi_include.parse`**
(`Drupal\jsonapi_include\JsonapiParse`, implementing `Drupal\jsonapi_include\JsonapiParseInterface`).
The response subscriber `jsonapi_include.response` calls `->parse($response)` on it. To change the
output, replace or extend that service.

## Interface

```php
interface JsonapiParseInterface {
  public function parse(\Symfony\Component\HttpFoundation\Response $response): \Symfony\Component\HttpFoundation\Response;
}
```

## Override the service

Add a `ServiceProvider` in your module (`src/YourModuleServiceProvider.php`) that swaps the class:

```php
use Drupal\Core\DependencyInjection\ContainerBuilder;
use Drupal\Core\DependencyInjection\ServiceProviderBase;

class MyModuleServiceProvider extends ServiceProviderBase {
  public function alter(ContainerBuilder $container): void {
    if ($container->hasDefinition('jsonapi_include.parse')) {
      $container->getDefinition('jsonapi_include.parse')
        ->setClass(\Drupal\my_module\MyJsonapiParse::class);
    }
  }
}
```

Then subclass and override the pieces you need:

```php
namespace Drupal\my_module;

use Drupal\jsonapi_include\JsonapiParse;
use Symfony\Component\HttpFoundation\Response;

class MyJsonapiParse extends JsonapiParse {
  public function parse(Response $response): Response {
    $response = parent::parse($response);   // do the normal flattening first
    // …post-process the (already-flattened) body, e.g. strip internal fields…
    return $response;
  }
}
```

`JsonapiParse` takes only `@request_stack` as a constructor argument, so keep that (or extend it)
when defining your replacement. Typical customizations: rename or drop fields, add computed
properties, or skip flattening for certain resource types.

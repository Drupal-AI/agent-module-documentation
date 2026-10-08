<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using the `lazy.` prefix

## How to make an injected service lazy
In your `*.services.yml`, reference the target service id **prefixed with `lazy.`** instead of the plain id:

```yaml
services:
  my_module.consumer:
    class: Drupal\my_module\Consumer
    arguments: ['lazy.some_module.heavy_service']
```

On container build, `Drupal\lazy_service\LazyServiceServiceProvider::alter()`:
1. Detects the `lazy.` prefix and resolves the real id `some_module.heavy_service`.
2. Generates a proxy class with Symfony's `ProxyBuilder`, written to `sites/default/files/php/ProxyClass/<Namespaced/Class>.php` (namespace path preserved to avoid collisions).
3. Registers the original service as `drupal.proxy_original_service.<id>` and replaces `<id>` with the proxy, so `Consumer` receives a proxy that instantiates `heavy_service` only on first method call.

## Notes / caveats (it is an alpha PoC)
- Array-form arguments are not recursed (`// TODO: Make all this recursive`).
- Proxy files live under the public files directory; clear/regenerate on container rebuilds.
- Throws `ServiceNotFoundException` if the un-prefixed target id does not exist.

See the `lazy_service_example` submodule for a working `myLazy` service consumed via an event subscriber.

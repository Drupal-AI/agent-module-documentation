<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
lazy-service is a developer proof-of-concept that makes on-demand (lazy) service loading possible without having to declare the target service as `lazy: true` up front or hand-generate its proxy class.

---

Normally in Drupal, lazy-loading an injected service requires the *defining* module to mark it `lazy: true` and to generate a ProxyClass into that module — awkward when the consumer, not the owner, wants a service lazy. This module's `LazyServiceServiceProvider::alter()` scans all service definitions for arguments whose id is prefixed with `lazy.` (e.g. `lazy.my_module.my_lazy`). For each, it resolves the real service (the part after `lazy.`), auto-generates a proxy class via Symfony's `ProxyBuilder`, writes it to `sites/default/files/php/ProxyClass/` (keeping the namespace path so two same-named classes don't collide), registers the proxy in the container, and rewires the definition so the consumer receives a lazy proxy that only instantiates the real service when first used.

This is infrastructure/container code, not a runtime feature: it has no routes, permissions, config, forms, or external calls. The bundled `lazy_service_example` submodule demonstrates the pattern with a `myLazy` service and an event subscriber. Operational note for reviewers: it writes generated PHP proxy files under the public files directory (`sites/default/files/php/ProxyClass`) and `require`s them via the container — the source class names come from the container definitions (developer-controlled), not from request input, so there is no user-driven code path; still, ensure that directory is not web-writable by untrusted processes, as with any generated-PHP location.

---
- Inject an existing service lazily without editing its owning module.
- Prefix a service argument with `lazy.` to defer its instantiation.
- Auto-generate a proxy class instead of running a manual script.
- Avoid loading a heavy service in code paths that don't use it.
- Keep proxy classes out of contrib modules (written to files dir).
- Prevent proxy-file collisions across namespaces.
- Study the example submodule for the lazy pattern.
- Prototype lazy DI ideas on Drupal 8–11.
- Reduce container instantiation cost for rarely-used services.
- Make a third-party service lazy from your consumer module.
- Demonstrate Symfony lazy proxies inside Drupal.
- Wire a lazy dependency into an event subscriber (see example).
- Benchmark lazy vs. eager service loading.
- Explore moving lazy-by-consumer support toward core.
- Regenerate proxies automatically on container rebuild.
- Use as a reference `ServiceProviderBase::alter()` implementation.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# lazy-service (lazy_service) — agent index

**Developer PoC: inject any service lazily by prefixing its id with `lazy.`; the proxy class is auto-generated into the files directory.**

- **Version:** 1.0.x (1.0.0-alpha1) · **Core:** ^8 || ^9 || ^10 || ^11 · **Package:** Custom
- **Mechanism:** `LazyServiceServiceProvider::alter()` rewrites definitions whose argument id starts with `lazy.`; builds a proxy via `ProxyBuilder` into `sites/default/files/php/ProxyClass/` and registers it lazily.
- **Submodule:** `lazy_service_example` (a `myLazy` service + `LazyServiceSubscriber`).
- **Routes/permissions/config:** none — container-alter infrastructure only.
- **Security:** no request-facing surface. Generates and `require`s PHP proxy files under the public files dir; class names derive from developer-controlled container definitions, not user input. Keep the generated-PHP dir non-writable by untrusted processes. No exploitable findings.

See [extend/lazy-prefix.md](extend/lazy-prefix.md)

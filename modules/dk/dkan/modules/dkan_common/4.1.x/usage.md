<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Shared foundation for the DKAN submodules — utility services, common functions, and the base API endpoints the metastore, datastore and harvest APIs build on.

---

Shared foundation for the DKAN submodules — utility services, common functions, and the base API endpoints the metastore, datastore and harvest APIs build on. It is a dependency, not a feature: enabling DKAN pulls it in, and nothing about a portal is configured here directly. It also carries a nested `dkan_alt_api` submodule providing an alternate API surface.

---

- Provide shared services to DKAN modules.
- Expose base API endpoints.
- Underpin the metastore API.
- Underpin the datastore API.
- Underpin the harvest API.
- Supply common utility functions.
- Serve as a DKAN dependency.
- Enable an alternate API via dkan_alt_api.
- Keep cross-cutting code in one place.
- Avoid duplicating utilities per submodule.
- Support the decoupled front end's API needs.
- Anchor the DKAN pipeline.
- Ship with the base DKAN install.
- Stay enabled while any DKAN submodule is on.
- Provide base classes for API controllers.
- Centralise DKAN's HTTP conventions.
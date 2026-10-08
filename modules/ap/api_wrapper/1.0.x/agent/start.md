<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Api Wrapper (api_wrapper) — agent index

**Registers HTTP routes for any service method tagged with `#[ApiWrap]`/`#[Endpoint]`, plus an auto-generated docs page.**

- **Version:** 1.0.x (1.0.1)  •  **Core:** ^9 || ^10 || ^11
- **Routes:** dynamic, via `ApiWrapperRoutesProvider::routes()` (route_callbacks); docs at `/api-wrapper/docs/{apiName}` (`access content`).
- **Attributes:** `#[ApiWrap(basePath,label,docPath)]` (class), `#[Endpoint(method,path,label,description)]` (method).
- **Controller:** `ApiWrapperDocumentationController`.  **Library:** `api_wrapper/api_wrapper.styles`.

**Access:** every generated endpoint route and every documentation route uses `_permission: 'access content'` (`src/Routing/ApiWrapperRoutesProvider.php`). See [api/attributes.md](api/attributes.md).

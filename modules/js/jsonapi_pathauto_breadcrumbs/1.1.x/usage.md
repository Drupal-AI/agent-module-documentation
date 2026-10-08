<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON:API Pathauto Breadcrumbs adds a breadcrumb to JSON:API responses based on the URL alias.

---

JSON:API Pathauto Breadcrumbs enriches JSON:API responses with breadcrumb data — deriving a breadcrumb
trail from the entity's URL alias (Pathauto) and including it in the JSON:API output, so decoupled/headless
front ends can render breadcrumbs without recomputing them. It depends on core JSON:API and JSON:API Extras,
in the Web services package.

Use it in decoupled setups that need breadcrumb data from JSON:API. It is a web-services feature adding
derived data to API responses; the breadcrumb reflects the URL alias/structure (public routing info) and it
has no access-control role (it doesn't change what JSON:API exposes — JSON:API's own access still applies).
Enable it to include breadcrumbs in responses.

---

- Add breadcrumbs to JSON:API responses.
- Derive breadcrumbs from the URL alias.
- Support decoupled front ends.
- Depend on JSON:API and JSON:API Extras.
- Include breadcrumb trail in output.
- Avoid recomputing breadcrumbs client-side.
- Rely on JSON:API's own access.
- Have no access-control role.
- Reflect the URL alias/structure.
- Enable breadcrumbs in responses.
- Enrich API responses.
- Handle headless breadcrumbs.
- Add derived breadcrumb data.
- Configure the feature.
- Include breadcrumbs.
- Support headless.
- Add breadcrumb output.
- Handle JSON:API breadcrumbs.
- Provide breadcrumb data.
- Enrich JSON:API.

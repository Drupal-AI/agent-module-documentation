<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GraphQL for Apigee adds GraphQL support to the catalogue, so a schema-based API can be documented alongside OpenAPI ones — an experimental submodule of Apigee API Catalog.

---

Apigee API Catalog models each documented API as an `apidoc` node whose specification drives the rendered documentation. That works for OpenAPI, but not every API is described that way. This submodule adds GraphQL support to the catalogue, so a schema-based API can be documented alongside OpenAPI ones. It is marked **Apigee (Experimental)** in its package, depends on `apigee_api_catalog` plus core `file`, `file_link` and `text`, and adds no configuration, permissions or Drush commands of its own — enabling it extends what the catalogue can hold, and the rest of the workflow (node creation, revisions, access, re-import where applicable) is inherited from the parent module.

---

- Document a GraphQL API in the same catalogue as REST APIs.
- Give developers one place to find every API.
- Reuse the apidoc node type's editorial workflow.
- Keep documentation under normal Drupal access control.
- Version documentation through node revisions.
- Publish alongside OpenAPI specifications.
- Add editorial context around the generated reference.
- Keep the catalogue consistent for developers.
- Avoid a separate documentation tool.
- Support teams whose APIs are not REST.
- Trial the format while it is still experimental.
- Combine with the parent module's breadcrumb and 404 handling.
- Manage docs with the site's existing roles.
- Migrate existing documentation into Drupal.
- Present all API styles under one navigation.
- Let API owners self-serve updates.
- Keep documentation close to the developer portal.
- Extend the catalogue without custom code.
- Disable it again cleanly if the format is not needed.
- Evaluate the format before committing to it.

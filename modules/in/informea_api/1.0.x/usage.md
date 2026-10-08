<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
InforMEA API provides tools to aid in creating views of content that should be exposed via REST.

---

InforMEA API provides **tools to expose content via REST** for the InforMEA platform (the UN environmental
treaties knowledge hub) — helping build REST views/endpoints that publish content in the format InforMEA
consumes. It depends on core REST, in the InforMEA package.

Use it to expose content to InforMEA over REST. It is a decoupled/integration feature. Security note: it
publishes content through **REST endpoints**, so ensure the exposed resources/views only surface content that
is meant to be **public** (REST resources bypass page-level UI, so rely on the resource/view access and Drupal
entity access to avoid exposing unpublished/restricted data), and secure the endpoints appropriately. It has
no access-control role of its own. Configure the REST resources/views.

---

- Expose content via REST for InforMEA.
- Build REST views/endpoints.
- Publish in InforMEA's format.
- Depend on core REST.
- Serve the InforMEA platform.
- Publish content over REST.
- Ensure only public content is exposed.
- Rely on resource/view + entity access.
- Secure the endpoints.
- Have no access-control role of its own.
- Configure the REST resources.
- Handle REST exposure.
- Expose content.
- Configure the views.
- Publish via REST.
- Handle the integration.
- Expose resources.
- Provide REST endpoints.
- Restrict exposure.
- Provide InforMEA REST.

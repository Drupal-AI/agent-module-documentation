<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A framework for creating and managing SOAP web-service endpoints.

---

SOAP Manager provides a framework to create and manage SOAP-based web service endpoints within Drupal — so a site can expose its own SOAP services (the server side), with WS-Security authentication handling and request processing.

Its inbound XML parsing uses `DOMDocument::loadXML` / `simplexml_load_string` with default flags — external entities are not resolved on modern PHP (libxml 2.9+), so it is not XXE-exploitable by default. Depends on core `serialization`; supports Drupal 10 and 11.

---

- Expose SOAP endpoints.
- Provide a SOAP server framework.
- Handle WS-Security auth.
- Process SOAP requests.
- Parse XML default-safe.
- Depend on core `serialization`.
- Support Drupal 10 and 11.
- Configure endpoints.
- Aid web-service publishing.
- Handle SOAP management.
- Serve SOAP.
- Manage endpoints
- Support Drupal.
- Support Drupal.
- Support Drupal.

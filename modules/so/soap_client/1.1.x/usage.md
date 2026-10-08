<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity-based SOAP integration with WSDL parsing and Feeds import.

---

Entity SOAP Client provides entity-based SOAP integration with WSDL parsing, service/operation management, and Feeds integration — so a site can consume external SOAP web services (parsing their WSDL, managing services/operations as entities) and import the results via Feeds.

The SOAP endpoint credentials are handled via a Key entity (`key` dependency, env-backed). Its XML parsing uses `DOMDocument::loadXML` with default flags (external entities are not resolved on modern PHP/libxml). Depends on `dx_toolkit`, core `key`, `views`, `feeds`, and `feeds_enhanced`; supports Drupal 10 and 11.

---

- Consume SOAP web services.
- Parse WSDL.
- Manage services/operations as entities.
- Import results via Feeds.
- Handle credentials via a Key entity.
- Parse XML default-safe.
- Depend on `dx_toolkit`/`key`/`views`/`feeds`/`feeds_enhanced`.
- Support Drupal 10 and 11.
- Configure the SOAP service.
- Handle SOAP integration.
- Call SOAP APIs.
- Import SOAP data
- Support Drupal.
- Support Drupal.
- Support Drupal.

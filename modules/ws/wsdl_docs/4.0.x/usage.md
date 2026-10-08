<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WSDL Docs imports a SOAP service's WSDL and renders its operations as documentation nodes.

---

**WSDL Docs** lets you document a SOAP web service in Drupal. A `soap_service` node stores a WSDL source URL (`field_wsdl_docs_source`); a `SoapClientManager` service fetches the WSDL (`file_get_contents` / PHP `SoapClient`), parses it with `DOMDocument::loadXML`, and generates `wsdl_docs_operation` nodes plus a Views listing of operations. It bundles content types, fields, and views config, and depends on core Link, Menu UI, Node, Path, Options, Text, User and Views.

The WSDL URL is supplied by an editor authoring a `soap_service` node, so the server-side fetch is an authenticated action. Note: in this release `saveSoapNode()` is effectively a stub (logs only).

---

- Document a SOAP service inside Drupal.
- Import a WSDL from a SOAP endpoint URL.
- Generate operation nodes from a WSDL.
- List SOAP operations via an embedded View.
- Store the WSDL source URL on a node field.
- Parse WSDL/XSD with DOMDocument.
- Create SOAP service and operation content types.
- Render an operations list on the service node.
- Provide human-readable API docs for SOAP.
- Follow XSD imports/includes when parsing.
- Depend on core Node, Views, Link and friends.
- Attach a library to operation pages.
- Build a browsable SOAP API reference.
- Keep SOAP docs in sync with a WSDL.
- Load the WSDL with PHP SoapClient.
- Clean up generated nodes on uninstall.
- Author services as editors via node forms.
- Show request/response structure per operation.
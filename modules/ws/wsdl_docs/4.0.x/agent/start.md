<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# WSDL Docs — agent index

Imports a **SOAP WSDL** (from a `soap_service` node's `field_wsdl_docs_source` URL) and generates `wsdl_docs_operation` nodes + a Views listing. `SoapClientManager` fetches via `file_get_contents`/`SoapClient`, parses with `DOMDocument::loadXML`. Core `^10`, deps node/views/link/etc. `saveSoapNode()` is a stub in this version.
# Entity SOAP Client — manual setup guide

**Entity SOAP Client** (`soap_client`) is a comprehensive layer for **consuming
external SOAP web services** from Drupal. Instead of hand‑coding SOAP calls, you
import a service's WSDL and the module turns it into manageable Drupal entities —
one **SOAP Service** entity for each service (endpoint, namespaces, ports) and a
**SOAP Operation** entity for each operation (typed parameters and response
schemas) — which you then configure and call through the admin UI and code.

Beyond the entities it adds WSDL import with batch processing (to generate the
service and operation entities automatically), response logging that records every
request and response with execution times and error details, a plugin‑based
operation dispatcher, and integration with the **Feeds** module through a SOAP
Fetcher plugin so you can import data from a SOAP service like any other feed.
Credentials for the SOAP endpoint are stored securely through the **Key** module
rather than in plain configuration.

There is also an optional **Webform** submodule (enabled as
`soap_client_webform`) that extends Webform with SOAP capabilities — a SOAP
handler for submitting webform data to a SOAP endpoint with field mapping, and a
"SOAP Conditions Responder" element that creates hidden, field‑type‑aware form
elements for Webform `#states` conditionals. That lets a form show or hide fields
in real time based on a SOAP response — useful for account verification, service
eligibility checks, real‑time validation, and multi‑step forms with external
dependencies.

This module is not a one‑click feature: it depends on several other modules and
requires the PHP SOAP extension, and you configure it by importing WSDL and
managing the resulting entities. Two safety points worth noting from its own
docs: credentials are held in Key entities (env‑backed), and its XML parsing uses
`DOMDocument::loadXML` with default flags, so external entities are not resolved
on modern PHP/libxml. It is a **Beta** release intended for community testing and
is not covered by Drupal's security advisory policy.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   dependencies with Composer, enable it (and optionally the Webform submodule),
   and confirm the PHP SOAP extension.

## How to use it

The module is administered through its entities rather than a single settings
form:

1. Create a **Key** holding the credentials for the SOAP service you will call.
2. Import the service's **WSDL**; the batch process generates a SOAP Service
   entity and its SOAP Operation entities.
3. Review and adjust the generated service (endpoint, namespaces, port) and
   operations (parameters, response schemas), attaching the Key for
   authentication.
4. Call operations from code or via the dispatcher, and inspect the SOAP Response
   log to see requests, responses, execution times, and any errors.
5. Optionally wire a SOAP service into a **Feeds** importer (SOAP Fetcher) or,
   with the Webform submodule enabled, into a webform via the SOAP handler and
   Conditions Responder element.

See the module's comprehensive README on drupal.org for detailed configuration and
API usage examples.

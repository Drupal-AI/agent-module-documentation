# SOAP Manager — manual setup guide

**SOAP Manager** (`soap_manager`) is a framework for the **server side** of SOAP:
it lets you expose Drupal functionality as SOAP web‑service endpoints, so external
systems that speak the SOAP protocol can integrate with your site. Where the
similarly named Entity SOAP Client consumes remote SOAP services, SOAP Manager
publishes your own.

Through a friendly administrative interface you create and manage multiple SOAP
endpoints, each with its own name, path, and description, and choose which SOAP
resources to expose through it. You can supply your own custom WSDL files instead
of relying on auto‑generated ones, secure endpoints with Drupal authentication,
and configure security settings such as request timeouts, rate limiting, and
maximum request sizes. It logs SOAP requests, responses, and errors in detail. The
architecture is plugin‑based, so developers can add custom SOAP operations by
implementing a resource plugin with the `@SoapResource` annotation.

The module depends only on core's **Serialization** module and requires the PHP
SOAP extension. It needs configuration to be useful — after enabling it you create
at least one endpoint before anything is exposed. A security note from its own
docs: inbound XML is parsed with `DOMDocument::loadXML` / `simplexml_load_string`
using default flags, so external entities are not resolved on modern PHP
(libxml 2.9+) and it is not XXE‑exploitable by default. The project is **not**
covered by Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   confirm the PHP SOAP extension, and enable it.
2. [Configuration](configuration/index.md) — create and secure your SOAP
   endpoints and adjust the global settings.

## Where it lives in the admin menu

After enabling the module, manage your endpoints at **Configuration → Web services
→ SOAP Endpoints**, and adjust module‑wide options at **Configuration → Web
services → SOAP Endpoint Settings**. Each endpoint you create is served at the
path you give it (for example `/soap/my-service`), with its WSDL available at that
path plus `?wsdl` (`/soap/my-service?wsdl`).

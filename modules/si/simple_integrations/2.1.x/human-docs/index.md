# Simple Integrations — manual setup guide

**Simple Integrations** (`simple_integrations`) is a small developer framework for
connecting your Drupal site to external APIs. Instead of hard‑coding endpoints,
credentials, and timeouts throughout your custom code, you describe each external
service once as an **Integration** configuration entity, and a ready‑made connection
client applies that configuration to your outbound requests. Connection details move
out of code and into exportable config that site administrators can view and edit.

Each Integration holds an external **endpoint**, an **authentication type** (none,
headers, basic auth, or certificate), any **credentials**, a **certificate path**,
a **timeout**, and **active** / **debug** flags. The bundled `ConnectionClient`
extends Drupal's core HTTP (Guzzle) client and automatically applies the chosen
integration's configuration and credentials to requests — and it refuses to make
requests for an integration that is marked inactive. Debug mode gives you a flag for
triggering your own request logging. This is mostly aimed at **REST** connections;
for SOAP, the maintainer suggests pairing it with the Meng AsyncSoap library.

On its own the module does nothing visible — it is a framework other code builds on.
It provides an admin **interface for viewing and editing** integrations, an admin
**"Perform connection test"** action that sends a GET to the endpoint and reports the
status, and permissions that separate viewing, editing (restricted to trusted
admins), and testing. Note that **Integration entities cannot be created through the
UI**: you ship them as config in your custom module's `config/install/` directory,
after which they become editable in the admin interface. Endpoints and credentials
are administrator‑configured (not user‑supplied), and outbound TLS verification uses
Guzzle's defaults.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — how Integration entities are created,
   what fields they hold, and how to run a connection test.

## Where it lives in the admin menu

The integrations list is the module's configure route,
`entity.integration.collection` — you reach it under **Configuration → Integrations**
(the *Integrations* menu link). From there, administrators with the right permission
can view and edit the Integration entities that your custom modules have shipped.

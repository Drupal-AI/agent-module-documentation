# Sharepoint API — manual setup guide

**Sharepoint API** (`sharepoint_api`) is the base integration layer that connects
Drupal to Microsoft SharePoint. It provides the client and services needed to
authenticate against and call the SharePoint (Microsoft 365) API, and it exposes
Drupal services that other modules can build on. On its own it does not add any
visible feature — it is the connectivity plumbing that companion modules such as
**SharePoint File Download** (`sharepoint_file_download`) rely on to read documents
and data from SharePoint.

Think of it as the foundation: install it when another module needs to talk to
SharePoint, or when you are writing custom code that calls the SharePoint API. It
has no content of its own and no access-control role — it simply handles the
connection and app authentication (OAuth against your SharePoint app registration).

An important operational note: SharePoint app credentials (client id, client
secret, tenant) should be stored securely, backed by an environment variable, and
never committed to your repository. This module is the connectivity layer that uses
those credentials, so handle them with the same care you would any secret.

This guide is written for a **human**. If you want terse, token-cheap references for
an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

This module does not add an admin settings page of its own in this version; it
provides the base client and Drupal services. In practice you enable it because
another module — for example SharePoint File Download — depends on it, or because
you are calling its services from custom code. Store your SharePoint app credentials
in an environment variable (never in exported config or version control) so the
client can authenticate securely.

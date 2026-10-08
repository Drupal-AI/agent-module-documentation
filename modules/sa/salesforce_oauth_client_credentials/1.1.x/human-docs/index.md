# Salesforce Client credentials Auth Provider — manual setup guide

**Salesforce Client credentials Auth Provider** (`salesforce_oauth_client_credentials`)
adds an authentication option to the **Salesforce Suite**: the OAuth 2.0
**client-credentials** flow. This is a server-to-server flow with no user context —
your Drupal site exchanges a connected app's consumer key and consumer secret for
an access token, running as a designated integration user.

It is the right choice when two applications need to share data directly, without a
person in the loop — for example sending leads from a Drupal webform to Salesforce
through a connected app. Salesforce itself recommends the client-credentials flow as
a **more secure alternative** to the older username-password flow, precisely because
it does not pass a user's password around.

This module only provides the auth plugin; it has no features you interact with
day to day and no access-control role. You configure it once through the Salesforce
Suite's authorization screen. It depends on the **Salesforce Suite** module and has
no submodules or third-party PHP libraries of its own.

> **Maintenance note:** at the documented version this module is marked *minimally
> maintained / no further development* and is **not covered** by Drupal's security
> advisory policy. Weigh that when choosing it for a production integration.

This guide is written for a **human** using the admin UI. If you are an AI coding
agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — Composer, the Salesforce Suite
   dependency, and enabling the module.
2. [Configuration](configuration/index.md) — adding a client-credentials auth
   provider on the Salesforce authorization screen.

## Where it lives in the admin menu

It plugs into the Salesforce Suite's own authorization configuration
(`salesforce.auth_config`), at **Configuration → Salesforce → Salesforce
Authorization**. Once enabled, "Salesforce OAuth Client Credentials" becomes an
available provider type there.

## Security, in plain terms

The client-credentials flow authenticates with a connected app's **consumer key and
consumer secret**. Treat those as secrets: store them outside exported
configuration (environment variables or a Key entity), always operate over HTTPS,
and grant the connected app and its integration user only the **minimum** Salesforce
permissions the integration actually needs.

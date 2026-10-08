# Salesforce Integration — manual setup guide

**Salesforce Integration** (`salesforce`) is a suite of modules that connects a
Drupal site to a Salesforce org. The base module you install here is the API
layer: it provides an authenticated REST client that talks to the Salesforce
REST API (creating, reading, and updating records, running SOQL queries, and
describing objects), an auth‑provider plugin system that manages how Drupal logs
in to Salesforce, a set of `salesforce:*` Drush commands, and an event system
that other modules hook into. On its own the base module does not sync any
content — it gives you the connection and the tools; the submodules do the
actual work.

Authentication is handled through **auth‑provider plugins**. Each connection to
Salesforce is stored as a *Salesforce Auth* config entity that names a provider
(OAuth or JWT, supplied by the `salesforce_oauth` and `salesforce_jwt`
submodules) plus its settings such as the consumer key and login URL. You pick
one of these authorizations as the site default. Because completing an OAuth or
JWT handshake means talking to Salesforce, you create and authorize connections
through the auth submodule's own UI rather than by hand.

The real data flow lives in the submodules. **Salesforce Mapping**
(`salesforce_mapping`, with its UI in `salesforce_mapping_ui`) is where you
define maps that tie a Drupal entity type and bundle to a Salesforce object and
line up their fields. **Salesforce Push** (`salesforce_push`) sends Drupal
changes to Salesforce and **Salesforce Pull** (`salesforce_pull`) brings
Salesforce changes back into Drupal. Additional submodules add logging
(`salesforce_logger`), SOAP support (`salesforce_soap`), address and webform
helpers, and a worked example (`salesforce_example`).

This guide is written for a **human** setting the suite up through the admin UI
and Composer. If you want terse, token‑cheap references for an AI coding agent,
read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the suite with Composer, meet
   its library and module requirements, and enable the base plus the submodules
   you need.
2. [Configuration](configuration/index.md) — set up an authorization, choose the
   default auth provider, and tune the suite‑wide settings.

## Where it lives in the admin menu

Once enabled, the suite adds a **Salesforce** admin section at
**Configuration → Salesforce** (`/admin/config/salesforce`, route
`salesforce.admin_config_salesforce`). That is where the suite‑wide settings,
the list of authorizations, and (with the mapping submodules) the mappings live.
Reaching it requires the **Administer Salesforce** permission.

## How to use it

The typical order is: install the base module and the auth + mapping submodules,
create and authorize a connection to your Salesforce org, set that connection as
the default auth provider, then define one or more mappings so Drupal entities
and Salesforce objects are tied together. From there you enable Push and/or Pull
depending on which direction you want data to flow. Developers can also call the
`salesforce.client` service directly to run SOQL queries or read and write
records in code, and the `salesforce:*` Drush commands (for example
`drush salesforce:list-objects` or `drush salesforce:query-object Contact`) let
you exercise the connection from the command line.

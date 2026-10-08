# SharePoint Integration — manual setup guide

**SharePoint Integration** (`sharepoint_integration`), by miniOrange, establishes a
connection between Microsoft SharePoint and your Drupal site — enabling
SharePoint-based integration, SSO, and content access from Drupal. You point it at
your SharePoint / Azure app registration, and it manages the connection so the two
systems can talk.

The module is configured on its own connection form (route
`sharepoint_integration.connection`) and provides its own permissions to control who
can manage it. It sits in the miniOrange package and supports Drupal 10 and 11. It
has no submodules and no additional module dependencies.

As with any SharePoint integration, treat the app credentials (client ID and
secret) as secrets — store them securely and operate the connection over HTTPS.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set up the SharePoint connection.

## Where it lives in the admin menu

The module adds a **SharePoint Integration** connection configuration form (route
`sharepoint_integration.connection`), reached from its link in the site's
Configuration area. See [Configuration](configuration/index.md) for what to fill in.

# Microsoft Graph Mailer — manual setup guide

**Microsoft Graph Mailer** (`microsoft_graph_mailer`) lets Drupal send — and
optionally receive — email through the **Microsoft Graph Mail API** instead of a
local SMTP server or PHP's `mail()`. If your organisation runs on Microsoft 365
and would rather have Drupal deliver mail through a proper Azure AD application
than open an SMTP relay, this module is the bridge. It registers a mail plugin
that authenticates to Microsoft Graph with **OAuth app credentials** (a tenant
id, a client id, and a client secret from an Azure AD app registration) and
hands your outgoing messages — including file attachments — to Graph for
delivery.

The problem it solves is a common one: modern Microsoft 365 tenants increasingly
disable legacy SMTP AUTH, which breaks the usual "point Drupal at an SMTP server"
approach. Graph-based sending uses the same OAuth app model Microsoft now expects,
and it supports easy `hook`-based alterations of the message on the way out.

The module does **not** work on enable alone — it needs configuration. You must
create an Azure AD app registration, grant it the appropriate Graph Mail
permissions, and enter the tenant/client/secret on the module's settings form
before any mail will go out. It has no third‑party module dependencies and no
Composer libraries beyond Drupal core.

> **Important security caveat.** This module stores the OAuth **`client_secret`
> in its own module configuration** (`microsoft_graph_mailer.settings`), which is
> included in Drupal's config export/sync — the files teams routinely commit to
> Git. A committed client secret is a leaked credential. The
> [Configuration](configuration/index.md) guide explains how to keep the secret
> out of version control by supplying it from an environment variable / Key
> entity instead.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create the Azure AD app, enter the
   tenant/client/secret, and store the secret safely.

## Where it lives in the admin menu

Once enabled, configure the mailer on its settings form (backed by the
`microsoft_graph_mailer.settings` configuration). See
[Configuration](configuration/index.md) for the full walkthrough, including how
Drupal chooses this mailer to send your site's mail.

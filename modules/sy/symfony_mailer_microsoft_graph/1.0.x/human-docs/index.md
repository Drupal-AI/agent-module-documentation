# Symfony Mailer Microsoft Graph — manual setup guide

**Symfony Mailer Microsoft Graph** (`symfony_mailer_microsoft_graph`) sends
Drupal's mail through **Microsoft Graph** rather than SMTP, as a transport for
the **Symfony Mailer** module. It is aimed at Microsoft 365 tenants where SMTP
authentication has been disabled — the same problem that breaks the conventional
`smtp.office365.com` username-and-password setup — for which Graph's `sendMail`
with OAuth application credentials is the supported replacement.

There are two Graph transports for Symfony Mailer, and it helps to know which is
which: the other one, `symfony_mailer_graphapi`, wraps the community
`vitrus/symfony-office-graph-mailer` library (pre-1.0). **This** module instead
uses **`microsoft/microsoft-graph`** (Composer requirement `^2.7`) — Microsoft's
own official SDK — plus `symfony/http-client`. For something sitting in the mail
path, the official SDK is the more conservative choice. The module depends on
**Symfony Mailer** (`symfony_mailer`), needs **PHP 8.1 or higher**, and works on
Drupal 10, 11, and 12.

The credentials are an **Azure app registration** — tenant ID, client ID, and
client secret. The client secret is a live credential: treat it as sensitive,
preferably keeping it in an environment variable surfaced through a Key entity,
and rotate it if it may have been exposed.
And scope the app registration to a **specific mailbox** with an application
access policy rather than granting `Mail.Send` tenant-wide — otherwise a
compromised Drupal site could send as anyone in the organisation. (Note also that
the module's `composer.json` sets `minimum-stability: dev`, which matters if you
resolve versions strictly.)

This guide is written for a **human** setting the module up through the admin
UI. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the official
   Graph SDK, and enable it.
2. [Configuration](configuration/index.md) — add the Graph transport in Symfony
   Mailer and enter your Azure credentials.

## Where it lives in the admin menu

This module has no admin page of its own — you configure it through **Symfony
Mailer's transport list**, where you add a Microsoft Graph transport and enter
your Azure app credentials.

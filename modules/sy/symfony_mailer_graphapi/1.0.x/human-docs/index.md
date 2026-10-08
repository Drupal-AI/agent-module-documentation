# Symfony Mailer Graph API Transport — manual setup guide

**Symfony Mailer Graph API Transport** (`symfony_mailer_graphapi`) lets Drupal
send its mail through the **Microsoft Graph API** instead of SMTP. Microsoft has
been progressively disabling basic authentication for SMTP in Microsoft 365,
which breaks the familiar "point Drupal at `smtp.office365.com` with a username
and password" setup that many organisations relied on. The supported
alternative is the Graph API's `sendMail` endpoint with OAuth application
credentials, and this module makes that available as a Symfony Mailer
**transport**.

It adds a transport plugin to Symfony Mailer; the actual Graph protocol work is
done by the `vitrus/symfony-office-graph-mailer` library. Authentication uses the
client-credentials workflow with a client secret — you register an application
in **Microsoft Entra** granting the **Mail.Send** permission, and supply its
**client ID**, **client secret**, and **tenant ID**. The module depends on
**Symfony Mailer** (`symfony_mailer` ^1.5) and works on Drupal 10.3 and 11.

Two things are worth planning for. The underlying library is at **0.0.x**, so
its API is not yet stable — pin `vitrus/symfony-office-graph-mailer` explicitly
rather than letting it float. And the client secret is a **live credential**:
keep it out of exported config — store it in an environment variable and surface
it through a Key entity — and scope the Entra app registration narrowly.
Granting `Mail.Send` tenant-wide would let a compromised Drupal site send as
anyone in the organisation, so scope it to the specific mailbox with an
application access policy. One Graph limitation to be aware of: although the
sender address is read from the message, mail is always sent from the primary
SMTP address configured on the Entra application.

This guide is written for a **human** setting the module up through the admin
UI. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its library,
   and enable it.
2. [Configuration](configuration/index.md) — add the Graph transport in Symfony
   Mailer and enter your Entra credentials.

## Where it lives in the admin menu

This module has no admin page of its own — you configure it through Symfony
Mailer's transport collection at **Configuration → System → Mailer → Mailer
Transport** (route `entity.mailer_transport.collection`), where you add a new
transport of type **MS Graph API**.

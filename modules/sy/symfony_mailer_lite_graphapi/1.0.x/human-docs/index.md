# Symfony Mailer Lite Graph API Transport — manual setup guide

**Symfony Mailer Lite Graph API Transport** (`symfony_mailer_lite_graphapi`)
provides a mail transport that sends email through the **Microsoft Graph API**,
for sites using the **Symfony Mailer Lite** module. It lets Drupal send mail via
Microsoft 365 / Office 365 using OAuth-authenticated Graph API calls instead of
SMTP — the route organisations need once Microsoft has disabled SMTP
authentication on their tenant.

It is the Symfony Mailer *Lite* counterpart to the Graph transport for the full
Symfony Mailer module: same idea, wired into Symfony Mailer Lite's transport
system. Authentication uses the client-credentials workflow with a client
secret; you register an application in **Microsoft Entra** granting the
**Mail.Send** permission and supply its **client ID**, **client secret**, and
**tenant ID**. The module requires the **Symfony Mailer Lite** module and works
on Drupal 10.1 and 11.

Because it authenticates with OAuth application credentials, treat those
credentials with care: the **client secret is sensitive** — store it as a secret
(an environment variable surfaced through a Key entity), not in plaintext
config. Scope the Entra app registration to mail-send only, and ideally to a
specific mailbox, so a compromised site cannot send as arbitrary users. Requests
to Graph go over HTTPS/TLS. The module is a transport only — it does not modify
outgoing mail, and it has no content or access-control role. One Graph
limitation: although the sender address is read from the message, mail is always
sent from the primary SMTP address configured on the Entra application.

This guide is written for a **human** setting the module up through the admin
UI. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — add the Graph transport in Symfony
   Mailer Lite and enter your Entra credentials.

## Where it lives in the admin menu

There is no admin page of its own — you configure it through Symfony Mailer
Lite's transport collection at **Configuration → System → Drupal Symfony Mailer
Lite → Transport** (route `entity.symfony_mailer_lite_transport.collection`),
where you add a transport of type **MS Graph API**.

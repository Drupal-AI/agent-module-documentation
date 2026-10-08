# Symfony Mailer Office 365 — manual setup guide

**Symfony Mailer Office 365** (`symfony_mailer_office365`) adds a Microsoft 365
("Office 365") transport to the [Symfony Mailer](https://www.drupal.org/project/symfony_mailer)
module, so a Drupal site can send its mail out through an organisation's existing
Microsoft tenancy using OAuth 2.0 instead of SMTP username-and-password.

The reason it exists is a change on Microsoft's side: Microsoft 365 has been
retiring **basic authentication** for SMTP, so putting a username and password
into a settings form no longer works on a modern tenancy. The modern replacement
is **OAuth 2.0**, which needs a registered application in Microsoft Entra (Azure
AD), a client secret, and permissions granted by a tenant administrator. This
module supplies the OAuth transport that bridges that gap for Symfony Mailer —
useful when your organisation requires all mail to leave through Microsoft 365
so it stays inside the tenancy's audit trail, retention policy, data-residency
commitment and anti-abuse controls.

It does **not** work on-enable — you must register an app with Microsoft,
configure the transport with the resulting credentials, complete a one-time
OAuth sign-in, and add the transport to your mailer policy before mail flows.
It targets Drupal 10 and 11. Two important cautions from the module's own docs:
this is an **alpha** release for the component that carries every password-reset
email, so treat it accordingly; and treat the **client secret like an API key** —
keep it in an environment variable or a Key entity, never in exported
configuration. Azure client secrets also **expire** on a date set when they are
created, so record that date — the failure mode is that all site mail stops on a
day nobody wrote down. The module is currently marked *not covered* by Drupal's
security advisory policy.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — register the Azure app, fill in the
   credentials, sign in to save the OAuth state, and keep the token refreshed.

## Where it lives in the admin menu

Once enabled, the module's settings and status page sits at
`/admin/config/system/mailer/office365`. That is where you enter the app
credentials, find the sign-in link that saves your OAuth state, and check the
status and any error messages. You then add the **Office 365 – OAuth** transport
to your Symfony Mailer mailing policy so mail is routed through it.

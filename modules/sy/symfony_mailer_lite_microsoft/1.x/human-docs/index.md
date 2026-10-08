# Symfony Mailer Lite Microsoft — manual setup guide

**Symfony Mailer Lite Microsoft** (`symfony_mailer_lite_microsoft`) sends Drupal
email through the **Microsoft Graph API** using the **Symfony Mailer Lite**
module. It provides a custom transport plugin for delivering mail through
Microsoft Office 365 / Azure in environments where SMTP authentication is not
permitted — using Microsoft's official API instead of SMTP while still going
through Drupal's normal mail system.

Under the hood it extends Symfony Mailer Lite with a Graph API transport, so
notification and transactional email is sent directly through Microsoft's
infrastructure. It supports HTML email and integrates with Symfony Mailer Lite's
templating, and it includes a built-in **test connection** feature so you can
confirm the setup before relying on it. The module depends on **Symfony Mailer
Lite** and **Symfony HTTP Client for Drupal** (`symfony_http_client`), needs
**PHP 8.3 or higher**, and works on Drupal 10 and 11.

To use it you set up a Microsoft **Azure** application: register it in Azure
Active Directory, grant the Microsoft Graph **Mail.Send** permission (granting
admin consent if required), and note its **Client ID**, **Client Secret**, and
**Tenant ID**. Those credentials are sensitive — the client secret in particular
is a live credential that belongs in an environment variable / Key entity, never
in plaintext config — and because Graph mail-send permissions can be broad, scope
the app registration minimally. Unlike the transport-collection variants, this
module has its **own settings form** where you enter the credentials, set the
sender address, and test the connection.

This guide is written for a **human** setting the module up through the admin
UI. If you want terse, token-cheap references for an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set up the Azure app, enter your
   credentials, and test the connection.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Symfony Mailer Lite
Settings** (`/admin/config/system/symfony-mailer-lite`), where you configure the
Microsoft Graph API transport.

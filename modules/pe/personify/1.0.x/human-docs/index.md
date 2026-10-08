# Personify — manual setup guide

**Personify** (`personify`) connects your Drupal site to the **Personify
CRM / membership platform** — the system many associations and YMCAs use to manage
membership, events, and transactions. It is part of the **YMCA Website Services**
ecosystem, and it provides the connection plus a set of helpers for calling the
Personify API functions, so other modules and your own code can read and exchange
membership data with Personify.

The integration talks to Personify over **SOAP**, which means your PHP
installation needs the SOAP extension enabled. It supports both a **production**
and a **staging** Personify endpoint, along with single‑sign‑on (SSO) vendor
credentials, so you can point a non‑production environment at Personify's stage
service while production talks to the live one.

Because Personify holds **member personal data (PII)**, this is a privacy‑sensitive
integration: the module sends and receives personal/membership information to an
external service, so handle that data according to your privacy obligations, keep
the connection over HTTPS, and store the API credentials as **secrets** rather
than committing them. Personify itself has no access‑control role on your Drupal
site — it is purely the CRM connection.

> **Note:** this project is **not covered by Drupal's security advisory policy**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — enable the PHP SOAP extension, install
   the module with Composer, and enable it.
2. [Configuration](configuration/index.md) — enter the Personify endpoints and
   credentials, stored securely.

## Where it lives in the admin menu

Personify has **no admin settings form**. Its connection details (WSDL/endpoint
URLs, vendor SSO credentials, and per‑environment usernames/passwords) are set as
**configuration overrides in `settings.php`** under the `personify.settings` key.
See [Configuration](configuration/index.md) for the full list.

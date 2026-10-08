# Azure Communication Service Mailer — manual setup guide

**Azure Communication Service mailer** (`azure_mailer`) is a Drupal mail backend
that delivers your site's outgoing email through the Azure Communication Services
(ACS) Email REST API instead of PHP's built‑in `mail()` or a local SMTP server.
If your site runs in Azure — or you simply want to centralize email
deliverability and reputation management there — this module lets Drupal hand each
message off to ACS over an authenticated HTTPS request.

Under the hood it registers one mail plugin ("Azure Communication Service") and
relies on the [Mailsystem](https://www.drupal.org/project/mailsystem) module to
make that plugin the active mail backend, either site‑wide or per module. When
Drupal sends a message, the plugin builds an ACS email payload (recipients,
sender, reply‑to, headers, and both HTML and plain‑text bodies) and POSTs it to
your ACS endpoint. Each request is signed automatically with Azure's HMAC scheme
using a shared access key, so no SMTP credentials ever sit on the web server.

Configuration is intentionally split for safety. You enter the ACS **endpoint**
host on the module's settings form, but the **secret** (the ACS access key) is set
out‑of‑band — in `settings.php` or via Drush — and the secret field on the form is
deliberately disabled so the key is never editable or displayed in the UI. This
keeps the key out of the database and out of exported configuration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its Composer
   dependencies, and enable it.
2. [Configuration](configuration/index.md) — set the endpoint and secret, and wire
   the mailer up through Mailsystem.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → Azure Communication Service
mailer** (`/admin/config/config/azure_mailer`), reachable by any user with the
**Administer site configuration** permission. You will also use **Configuration →
System → Mailsystem** (`/admin/config/system/mailsystem`) to select this mailer as
the active backend.

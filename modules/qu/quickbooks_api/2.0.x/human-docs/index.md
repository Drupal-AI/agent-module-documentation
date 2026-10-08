# Quickbooks API — manual setup guide

**Quickbooks API** (`quickbooks_api`) connects your Drupal site to **QuickBooks
Online** and exposes the official QuickBooks PHP SDK to other modules. It handles
the OAuth 2.0 connection to Intuit's cloud accounting service and then hands you a
ready‑to‑use service object, so custom or contributed code can read and write
QuickBooks data such as invoices, customers, and payments.

This is a simplified rework of the old Drupal 7 *QuickBooks Online API* module. It
does not add contexts or a public‑facing UI — it simply lets one site connect to
one QuickBooks Online company and use the SDK. It is aimed at developers: the only
screen it provides is its admin settings form, where you enter the app credentials
and complete the OAuth handshake. Using it requires your own QuickBooks Online
account and an app created in the Intuit developer portal.

Because it talks to a leading business accounting platform, everything it touches
is financial data and personal information. Treat the OAuth client ID, client
secret, and the access/refresh tokens as secrets, keep every call over HTTPS, and
grant the connected app only the QuickBooks scopes you actually need.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer (it
   pulls in the QuickBooks PHP SDK) and enable it.
2. [Configuration](configuration/index.md) — create an Intuit app, enter the OAuth
   credentials, and connect your site to QuickBooks Online.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Quickbooks API**
(`/admin/config/quickbooks_api/adminsettings`). This is the only page the module
provides.

## How to use it

After you have connected the site, other modules and custom code reach QuickBooks
through the module's service. Initialize it and then use the SDK's data service:

```php
$qbo = \Drupal::service('quickbooks_api.QuickbooksService');
$result = $qbo->dataService()->query('SELECT * FROM Customer');
```

Every function provided by the QuickBooks Online API SDK is available through that
`dataService()` object.

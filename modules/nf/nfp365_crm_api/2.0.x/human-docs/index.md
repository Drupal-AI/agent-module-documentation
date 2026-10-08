# NfP365 CRM API — manual setup guide

**NfP365 CRM API** (`nfp365_crm_api`) is a developer‑oriented integration module
that connects Drupal to **NfP365 CRM** — the Microsoft Dynamics 365 platform
tailored for the not‑for‑profit sector (from Mhance, a Microsoft Solutions
Partner). It provides authenticated connectivity to the two APIs NfP365 exposes —
the **WebAPI** and the **OpenAPI** — each of which surfaces resources such as
Donations, Orders, and Campaigns, so a nonprofit's donor and campaign data can flow
between the site and the CRM.

It is a foundation for developers rather than a turnkey feature: once you have
entered credentials, you use service clients in your own code to make requests.
For example, `\Drupal::service('nfp365_crm_api.manager')->getOpenApiClient()`
returns an OpenAPI client (with resource methods like `paymentProcessors()->all()`),
and `getWebApiClient()` returns a WebAPI client (with methods like
`campaigns()->all()`), each returning a response object you can read status and
data from. Developers can add new resources by dropping classes into the module's
`Resources/` folders and adding methods to the client classes.

The one piece of admin configuration is credentials: the module has a settings form
where you enter the OpenAPI and WebAPI credentials and can turn on a **Debug Mode**
that logs all requests and responses. Because those credentials grant access to your
CRM, store them as secrets — see [Configuration](configuration/index.md). It
supports Drupal 8 through 11 and provides its own permissions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enter the OpenAPI / WebAPI
   credentials, optionally enable Debug Mode, and store the secrets safely.

## Where it lives in the admin menu

The settings form is at **Administration → Configuration → Web Services → NfP365
CRM API** (`/admin/config/services/nfp365-crm-api`).

## How to use it

After entering credentials on the settings form, developers obtain a client from
the API manager service and call resource methods, for example:

```php
$openApi = \Drupal::service('nfp365_crm_api.manager')->getOpenApiClient();
$response = $openApi->paymentProcessors()->all();

$webApi = \Drupal::service('nfp365_crm_api.manager')->getWebApiClient();
$campaigns = $webApi->campaigns()->all()->getData();
```

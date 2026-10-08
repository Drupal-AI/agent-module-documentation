# ROI Solutions — manual setup guide

**ROI Solutions** (`roisolutions`) is an integration module that gives Drupal a
ready-made API client for **ROI Solutions** — the nonprofit constituent-relationship
(CRM/fundraising) platform also known as *Revolution CRM*. With it enabled and
configured, your custom code can talk to ROI Solutions' REST API to fetch and sync
constituents, donors, donations, and other fundraising data.

This is a developer-oriented integration: the module itself adds no visible
content or blocks. It provides one thing — a client service you call from your own
code — plus a small settings page where you store the API credentials it needs.
Because those credentials are sensitive, the module leans on Drupal's **Key**
module (its only dependency) so the username and password are read from an
environment variable rather than being saved in plain configuration.

Administration of the connection is gated by the **Administer ROI Solutions**
(`administer roisolutions`) permission, so only trusted administrators can view or
change the API settings. The module supports Drupal 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module
   and its Key dependency.
2. [Configuration](configuration/index.md) — store your ROI Solutions API
   credentials securely and point the module at the REST API.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → ROI Solutions → REST API**
(`/admin/config/roisolutions/settings/rest-api`). You need the *Administer ROI
Solutions* permission to reach it.

## How to use it

The module exposes a single service — the REST API client. From your own module or
custom code you fetch it from the service container and call its methods, for
example:

```php
/** @var \Drupal\roisolutions\RestApi $restApi */
$restApi = \Drupal::service('roisolutions.rest_api');
$donor = $restApi->getClient()->getDonor('123456');
```

Note that only the REST API is supported at present. If something goes wrong,
check the recent log messages at **Reports → Recent log messages**
(`/admin/reports/dblog`) — the module logs API errors there.

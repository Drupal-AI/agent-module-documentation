# Engaging Networks — manual setup guide

**Engaging Networks** (`engaging_networks`) provides an API client that connects
Drupal to the [Engaging Networks](https://www.engagingnetworks.net/) platform —
the fundraising and advocacy service used by many nonprofits. It lets your site
talk to the Engaging Networks Services (ENS) **REST API** to submit supporter
data and integrate campaigns. It stores its API credentials through the **Key**
module and provides its own permissions.

At its core the module exposes a single service — a REST API client — that other
code calls. For example, custom code can fetch a page or submit supporter data
through the client. The module itself is the plumbing; what you build on top of it
depends on your campaigns.

> **Data and secrets to be aware of.** This integration **sends supporter data —
> personal data such as names, email addresses, and potentially donation
> information — to the Engaging Networks API**. Treat that as personal-data egress
> to a third party and disclose it in your privacy policy. On the positive side,
> the module stores its API credentials via the **Key** module rather than in
> plain configuration; keep those credentials in a secure Key provider and always
> talk to the API over HTTPS. The module has no access-control role beyond its own
> permission.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Key dependency.
2. [Configuration](configuration/index.md) — set the REST API authentication
   credentials.

## Where it lives in the admin menu

The REST API settings are at **Configuration → Engaging Networks → REST API**
(`/admin/config/engaging-networks/settings/rest-api`).

## How to use it

Once configured, the module provides one service — the REST API client — for use
from custom code:

```php
/** @var \Drupal\engaging_networks\RestApi $restApi */
$restApi = \Drupal::service('engaging_networks.rest_api');
$page = $restApi->getClient()->getPage(1234);
```

If you hit problems, check the recent log entries at **Reports → Recent log
messages** (`/admin/reports/dblog`) — API errors are logged there.

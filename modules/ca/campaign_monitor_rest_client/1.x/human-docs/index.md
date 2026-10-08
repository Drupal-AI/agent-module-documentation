# Campaign Monitor REST Client — manual setup guide

**Campaign Monitor REST Client** (`campaign_monitor_rest_client`) is the plumbing
that lets Drupal talk to [Campaign Monitor](https://www.campaignmonitor.com/), the
email‑marketing platform, over its REST API. It provides the basic settings and a
service that other code builds on to create subscriber and list integrations — it
is **infrastructure**, not a finished feature you point‑and‑click.

On its own it doesn't send any subscribers anywhere. You enable it so that a
consumer module — such as the companion
[Campaign Monitor webform handler](https://www.drupal.org/project/campaign_monitor_webform)
— can use its service to call Campaign Monitor. It needs a Campaign Monitor **API
key**, which is a credential you must keep out of plain, committed configuration
(see [Configuration](configuration/index.md)).

Be aware of what building on this implies: any integration that uses this client
will forward subscriber personal data (email, name, and so on) to Campaign Monitor,
so the usual marketing‑data duties — consent and disclosure — fall on you as the
consumer.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — supplying the Campaign Monitor API
   key and handling that secret safely.

## How to use it

Enable it when a module that depends on it needs to reach Campaign Monitor, and
leave it disabled otherwise. After enabling, supply your API key (see
Configuration), then set up whatever consumer module actually maps and sends your
data.

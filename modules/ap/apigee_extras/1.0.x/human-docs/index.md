# Apigee Extras — manual setup guide

**Apigee Extras** (`apigee_extras`) adds extended functionality on top of the
**Apigee Edge** module — the integration that turns Drupal into an API developer
portal over Google's Apigee API-management platform. It builds on features that
Apigee Edge already provides (apps, API products, developer-key management) and is
only useful when Apigee Edge is installed and connected.

There is no configuration of its own to speak of: it depends entirely on Apigee
Edge, and it is configured alongside it. This release is an early beta
(1.0.0-beta1), so treat it as work in progress.

On data handling: like Apigee Edge, it works with the **Apigee Edge API**, and the
**credentials for that connection live in the Apigee Edge module** (stored via a
Key, not plain config — see the Apigee Edge guide). It manages developer-app and
API-key data, which includes secrets belonging to your portal's developers, so
handle that data carefully. Apigee Extras adds no access-control role of its own
beyond what Apigee Edge already enforces.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   (it requires Apigee Edge).

## How to use it

Because it extends Apigee Edge, there is nothing to configure in isolation. Get
Apigee Edge installed and connected to your Apigee organization first, then enable
Apigee Extras to add its features on top. Any credential handling and access
control is inherited from Apigee Edge — configure that module as described in its
own guide.

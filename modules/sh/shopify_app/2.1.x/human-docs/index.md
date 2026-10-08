# Shopify App — manual setup guide

**Shopify App** (`shopify_app`) is a developer framework, not a ready-to-use
feature. It gives you the scaffolding to build an *embedded Shopify app* backed by
Drupal — one of those apps that appears inside the Shopify admin screen — and it
handles the fiddly plumbing so you can concentrate on your app's behavior.

Concretely, it takes care of three things that every Shopify app has to do: the
Shopify **OAuth install flow** (the handshake that installs your app into a
merchant's store), **session storage** for those installations, and **webhook
processing**. It leans on the official Shopify PHP SDK to do this properly. You
implement your own **webhook handlers as plugins**, and you serve your Drupal-based
interface as an app inside Shopify's administration. Because of that plugin-based
design, this module is aimed at developers building a custom integration rather than
site builders looking for a configuration screen.

There is no settings form to fill in through the admin UI. The Shopify API
credentials your app needs are configured by the developer and should be kept as
secrets — store them in an environment variable (env-backed) rather than committing
them. On the security side, the webhook endpoint is public by design, but that is
fine because the module verifies Shopify's `X-Shopify-Hmac-Sha256` signature (via the
SDK's `Registry::process()`) before handling any webhook — so forged webhook calls
are rejected. Note that this project's releases are not covered by Drupal's security
advisory policy.

This guide is written for a **human** working with the module. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the framework with Composer and
   enable it.

## How to use it

This is a framework you build on, so there is no click-through configuration. After
enabling it you work as a developer: register your Shopify API credentials (kept as
secrets), let the module handle the OAuth install and session storage, and implement
your webhook handlers as plugins. Your app's own interface is then served inside the
Shopify admin.

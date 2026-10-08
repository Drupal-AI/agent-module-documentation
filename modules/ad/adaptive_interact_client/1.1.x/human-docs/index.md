# Interact client (Adaptive Interact) — manual setup guide

**Interact client (Adaptive Interact)** (`adaptive_interact_client`) is the
client-side integration for **Adaptive Interact**, a personalization and
engagement platform. It connects a Drupal site to that service so its
personalization and interaction features can run on your pages.

In practice the module loads the platform's client (JavaScript) into your site
and connects it to your Adaptive Interact account. Install it when your site uses
Adaptive Interact and you want its engagement features to operate on the Drupal
front end. It sits in the "Adaptive Interact" package and runs on Drupal 10, 11,
and 12.

Because it loads a third-party client and may send visitor and interaction data
to the platform, treat it as a privacy-relevant integration. Store any API
credentials as secrets (not in committed configuration), and consider the consent
and disclosure obligations for the data sent to the service — obtain consent and
disclose the data sharing where that is required.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — connect the module to your Adaptive
   Interact account, with credentials stored as secrets.

## Where it lives in the admin menu

After enabling, connect the module to the Adaptive Interact platform using your
account's connection details / credentials (see
[Configuration](configuration/index.md)). Once connected, the platform's client
runs on your site and its personalization features become active.

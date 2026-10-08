# Sender.net Integration — manual setup guide

**Sender.net Integration** (`sender_net`) connects your Drupal site to the
[Sender.net](https://sender.net) email‑marketing service so you can collect email
subscribers on your site and push them into Sender.net for list management and
campaigns. It adds new subscribers to Sender.net directly from Drupal, lets you
choose which Sender.net **groups** (lists) they go into, and provides a
subscription block you can place on your pages.

The typical flow is: connect the module with your Sender.net API token, pick the
group(s) you want new subscribers to land in, then place the **Sender.net
Subscription Block** in a region so visitors can sign up. Behind the scenes the
module talks to the Sender.net API to register each subscriber.

Because the module sends contact/subscriber data (personal data) out to the
Sender.net API, treat that egress the way your privacy policy requires, and store
the Sender.net API token as a secret — via an environment variable or the Key
module — never committed to code, and always over HTTPS. The module has no
access‑control role of its own. It requires a Sender.net account and a valid API
token, runs on Drupal 9, 10, and 11, is minimally maintained, and *is* covered by
Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set your API token and base URL,
   choose groups, and place the subscription block.

## Where it lives in the admin menu

Once enabled, the settings form is at **Configuration → System → sender.net**.
The subscription block is placed from **Structure → Block Layout**.

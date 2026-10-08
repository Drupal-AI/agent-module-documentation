# Consumer Base URL — manual setup guide

**Consumer Base URL** (`consumer_base_url`) lets you give each **consumer** its own
base URL, and then uses that URL when Drupal generates links for that consumer —
entity canonical URLs, URL tokens, and other URL generation. In a decoupled /
headless setup you typically have one or more front‑end applications talking to
Drupal through the **Consumers** module; without this module, links Drupal builds
tend to point back at the Drupal backend rather than at the front end that will
actually render them. Set a base URL on a consumer, and links generated for that
consumer point at the right front end instead.

It depends on core's **Path Alias** module and the **Consumers** contrib module,
and supports Drupal 10.3 and 11. The maintainer notes it has so far been tested
mainly with a single default consumer together with **GraphQL 4.x**, so treat other
combinations as less well‑trodden. The current release is a **beta**
(`1.0.0-beta2`), and the project is **not covered by Drupal's security advisory
policy**.

This module has no settings page of its own — you configure it by editing a
consumer and filling in its base URL. That process is short enough to cover here
under "How to use it".

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its dependencies.

There is **no dedicated settings page** — configuration happens on the consumer
entity itself (see "How to use it" below).

## Where it lives in the admin menu

Consumer Base URL adds a base‑URL field to consumers rather than a page of its own.
You manage it at **Configuration → Web services → Consumers**
(`/admin/config/services/consumer`).

## How to use it

1. Go to **Configuration → Web services → Consumers**.
2. **Edit** the consumer you want to give a base URL to.
3. Enter the base URL in the form `https://example.com` (the scheme and host of the
   front end that consumer represents).
4. **Save** the consumer.
5. If you added or changed a base URL on an existing consumer, you may need to
   **clear caches** for the change to take effect.

From then on, URLs Drupal generates for that consumer — canonical links, URL tokens
and the like — use its base URL and point at the correct front end.

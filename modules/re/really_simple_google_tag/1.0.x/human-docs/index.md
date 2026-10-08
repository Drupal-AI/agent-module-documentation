# Really Simple Google Tag — manual setup guide

**Really Simple Google Tag** (`really_simple_google_tag`) does one thing and does
it dependably: it adds one or more **Google Tag Manager** (GTM) container tags to
your site. You paste in your container ID(s), pick a couple of simple conditions,
click save, and the GTM snippet is injected into your pages.

The whole point of the module is its simplicity. There is already a larger
**Google Tag** (`google_tag`) module with fine‑grained conditions for exactly when
a tag should or shouldn't fire — but that flexibility also means more moving parts
that can, over time, cause a tag to quietly stop firing and lose you
business‑critical analytics data. Really Simple Google Tag deliberately offers only
a minimal set of conditions so that, once configured, it just keeps inserting your
tags. If your needs are basic, this is the reliable choice.

> **Privacy and consent.** Google Tag Manager can load third‑party tracking scripts
> and set cookies, and what those tags do is defined in the GTM console, not in
> Drupal. Pair this module with appropriate cookie‑consent handling and privacy
> disclosures for your jurisdiction. The module can exclude particular roles from
> loading tags (see Configuration), but managing consent is your responsibility.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter your GTM container IDs and set
   the inclusion/exclusion options.

## Where it lives in the admin menu

Once enabled, open the module's settings form from the modules list (**Extend**,
then the module's **Configure** link) or from the site's configuration section.
Enter your container ID(s) and save, as described in
[Configuration](configuration/index.md).

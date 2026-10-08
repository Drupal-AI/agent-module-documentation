# Microwave (content warmer) — manual setup guide

**Microwave** (`microwave`) rebuilds — "warms" — your page cache after a
deployment so the first real visitor doesn't pay the cold‑cache cost. Right after
a release, every page has to be regenerated from scratch, and if that happens
under real traffic it can mean slow first loads or a load spike. Microwave lets
you queue the URLs you care about (nodes, taxonomy term pages, custom URLs, and —
with the commerce submodule — commerce product pages) and then request each one
in the background, so the caches are already hot when humans arrive.

You tell Microwave *what* to warm on its settings form, then use Drush commands
to fill per‑target queues, and queue workers request each URL with a plain GET.
The commands are designed to be run from a CI pipeline straight after a delivery,
or from cron. Microwave is a bit more granular than a general warmer: for nodes
you can restrict warming to recent items using a date field and a period, rather
than warming every node of a type.

The module needs configuration before it does anything useful — you must pick the
content types, vocabularies and custom URLs to warm. It runs on **Drupal 10.3 or
11** (PHP 8.0+) and has no third‑party dependencies. One optional submodule,
**Microwave Commerce** (`microwave_commerce`), adds warming of Drupal Commerce
product pages using the same queue‑and‑warm approach.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and (optionally) the Commerce submodule.
2. [Configuration](configuration/index.md) — choose what to warm, then queue and
   run the warming.

## Where it lives in the admin menu

Microwave's settings form sits at **Configuration → System → Microwave**
(`/admin/config/system/microwave`). Access is gated by the **`configure
microwave`** permission, so grant that permission to whoever manages cache
warming. Full field‑by‑field guidance and the Drush workflow are in
[Configuration](configuration/index.md).

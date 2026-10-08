# Index Now — manual setup guide

**Index Now** (`index_now`) automatically pings IndexNow‑compatible search engines
— Bing, Yandex, and others — whenever content is created, updated, or deleted on
your site, so your changes get recrawled faster instead of waiting for the search
engine's own schedule. It implements the [IndexNow protocol](https://www.indexnow.org/):
on each entity change it submits the page's absolute canonical URL to your chosen
search‑engine endpoint (and, per the protocol, all participating engines share that
submission).

Which content types are handled is driven by an extensible **entity indexer**
plugin system. Out of the box the base module pings for **nodes** and **taxonomy
terms**, and the bundled **Index Now Commerce** submodule adds **products** and
**stores**; developers can register more entity types with a plugin. On the
settings form you choose the search engine, and per entity type you can exclude
specific bundles and specific events (created / updated / deleted). To prove you own
the domain, the module generates an **API key** (a UUID) and serves it as a small
public text file at `/index_now_api_key_{key}.txt` — this file is intentionally
reachable by anonymous users because the search engine has to fetch it to verify
your site. The IndexNow key is not a secret by design, so there is nothing to hide
here.

Submissions can be sent immediately, or in **async mode** queued and flushed on
cron to keep request latency low on busy sites. Insert pings are skipped for content
anonymous users can't see, CLI operations only ping when you opt in, and two alter
hooks let you rewrite the submitted URL or the key‑file URL for headless/decoupled
setups. The module requires the **Config Split** and **Path Alias** modules and the
`league/commonmark` library (pulled in automatically), runs on PHP 8+, and provides
two permissions and a Drush command.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the entity‑indexer
plugin type, service, and hooks — read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and note the optional Commerce submodule.
2. [Configuration](configuration/index.md) — the settings form, search‑engine
   choice, exclusions, async/verbose/CLI modes, and the API key.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → Web services → Index Now**
(`/admin/config/services/index_now`).

## How to use it

Enable the module (the API key generates itself), open the settings form, pick your
search engine, and exclude any content types or events you don't want to submit.
From then on, saving or deleting content pings the search engine automatically — no
per‑action steps for editors. See [Configuration](configuration/index.md) for the
details.

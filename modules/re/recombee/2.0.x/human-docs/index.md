# Recombee — manual setup guide

**Recombee** (`recombee`) adds personalized recommendation blocks to a Drupal
site, powered by [Recombee](https://www.recombee.com/) — a hosted, subscription
recommendation service. Recombee watches what visitors view, combines that
behaviour with an index of your content, and returns "recommended for you" /
"related items" results. All of the rendering happens **client-side**, so the
blocks work for anonymous visitors as well as logged-in users.

The module gives you two kinds of block. The **Recombee Tracker** block embeds a
tracking script that reports the content a visitor views back to Recombee — you
target it at the content types and roles that represent "normal" site use (the
maintainers advise **not** tracking administrators or editors). The **Recombee
Public Scenario** blocks then display recommendations: each one pulls the client
id and item id from the current page, requests recommendations from Recombee's
public API, and renders the JSON result client-side through the
[JSON Template](https://www.drupal.org/project/json_template) module. Recombee
ships a basic "Recombee titles" Handlebars template, and themers can add their
own for richer output.

Because this is a third-party service, two things deserve care from the start.
**Privacy:** the tracker sends visitor behaviour data (views, clicks, and
identifiers) to Recombee, which carries GDPR/ePrivacy obligations — disclose the
data sharing and gate tracking behind consent where your jurisdiction requires
it. **Credentials:** the module authenticates with Recombee API tokens; treat
them as secrets and keep them out of committed configuration.

A companion module,
[Search API Recombee](https://www.drupal.org/project/search_api_recombee), pushes
your content into the Recombee index the same way other Search API backends push
to Solr or the database — the maintainers strongly recommend configuring it so
recommendation results carry your field data. It is a separate install.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its JS Cookie
   and JSON Template dependencies with Composer, and enable it.
2. [Configuration](configuration/index.md) — enter your Recombee database and API
   credentials, then place and configure the tracker and recommendation blocks.

## Where it lives in the admin menu

The module's settings form is at `recombee.settings`. The Tracker and Public
Scenario blocks are placed and configured through the standard **Structure →
Block layout** page, where each block instance carries its own options
(scenario, number of items, template).

## How it works, step by step

1. Create an account on the Recombee site — it is a SaaS, so a subscription is
   needed to host your data and produce recommendations.
2. Enable this module and enter your **private** and **public** API credentials
   on the settings form; these are used for indexing and querying.
3. (Recommended) Install **Search API Recombee** so your content is pushed into
   the Recombee index when it changes — this drives item-similarity and supplies
   the field data returned in recommendation results.
4. Place the **Recombee Tracker** block, targeted at the content and roles that
   should be tracked.
5. Place **Recombee Public Scenario** blocks where recommendations should show,
   choosing the scenario, item count, and template on each.
6. When a page loads, the recommendation blocks read the client id and item id
   from the page, query the Recombee public API, and JSON Template transforms the
   response into HTML that is inserted into the page.

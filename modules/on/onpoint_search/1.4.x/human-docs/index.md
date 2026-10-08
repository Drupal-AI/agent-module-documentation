# OnPoint Search — manual setup guide

**OnPoint Search** (`onpoint_search`) connects your Drupal site to
[OnPoint Search](https://search.onpointsuite.com/), a cloud‑hosted (SaaS) site
search service. Instead of building and maintaining a local search index, you
point OnPoint's crawler at your site, it indexes your content in the cloud, and
this module surfaces OnPoint‑powered search results on your pages. There are no
servers to set up on your side and no local index to maintain.

OnPoint handles the crawling, relevance, analytics, and result customization on
its platform; the Drupal module is the integration glue that connects your
OnPoint account to the site and renders the search experience. It ships an
`onpoint_search_d8` submodule and provides its own permissions.

To connect, you supply an **API key** from your OnPoint account. Because that key
authenticates your site to a third‑party service, store it securely rather than
committing it to code. And keep in mind the usual SaaS trade‑off: search queries
(and the content OnPoint crawls) are sent to and processed by an external service,
so you gain "no local infrastructure" in exchange for a dependency on OnPoint's
availability and its handling of your data.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enter your OnPoint API key and store
   it securely.

## Where it lives in the admin menu

The settings form is registered as `onpoint_search.settings` — reach it from the
**Extend** page (**Configure** next to *OnPoint Search*) or the **Configuration**
section of the admin menu. See [Configuration](configuration/index.md).

## How to use it

1. Sign up at [search.onpointsuite.com](https://search.onpointsuite.com/) (a free
   trial is available) and let OnPoint's crawler index your site.
2. Copy your **API key** from the OnPoint dashboard.
3. Add the key to the module's settings form (see
   [Configuration](configuration/index.md)) and save.
4. Surface the OnPoint search experience on your site and confirm results are
   returned. Manage crawling, analytics, and result tuning from the OnPoint
   dashboard itself.

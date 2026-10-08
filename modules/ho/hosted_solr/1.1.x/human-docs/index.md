# Hosted Solr — manual setup guide

**Hosted Solr** (`hosted_solr`) is a small connector plugin for the
[Search API Solr](https://www.drupal.org/project/search_api_solr) module that makes
it painless to point your site at the managed **Hosted Solr** service
(hosted‑solr.com) instead of running and maintaining your own Solr server. It
doesn't add any pages, permissions, or settings of its own — it simply appears as a
new **connector** option when you configure a Search API server.

What it saves you is fiddly configuration. The connector pre‑fills the parts that
are always the same for Hosted Solr: it forces the **HTTPS** scheme and **port
443**, hides the scheme/port/path fields, and derives the Solr path automatically
from your username. In practice you paste just two things from your Hosted Solr
dashboard — the **host** and your **user/password** — and you're connected. The
connection is pinned to TLS with no option to turn encryption off, and your
credentials are stored the standard Search API way, in the server configuration.

Everything else — indexing your content, faceting, full‑text queries — is provided
by Search API and Search API Solr exactly as normal; this module only handles the
connection.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Search API Solr.

There is **no configuration page** for this module. You set it up entirely on the
Search API server form, described in "How to use it" below.

## Where it lives in the admin menu

Hosted Solr adds no admin page of its own. You use it from **Configuration →
Search and metadata → Search API** (`/admin/config/search/search-api`), when you
add or edit a **server**.

## How to use it

1. Make sure Search API and Search API Solr are installed and enabled (see
   [Installation](installation/index.md)).
2. Go to **Configuration → Search and metadata → Search API** and click **Add
   server**.
3. Choose **Solr** as the backend, then select the **Hosted Solr** connector.
4. From your Hosted Solr account dashboard, copy the **host** value and your
   **username / password**, and paste them into the connector fields. You do not
   need to set the scheme, port, or path — the connector fixes HTTPS/443 and works
   the path out from your username.
5. Save the server. Use the server's status/**ping** to confirm connectivity, then
   create a Search API **index** against it and add the fields you want to search —
   this part is standard Search API and works the same as with any Solr server.

> **Handling the credentials safely:** the Hosted Solr username and password are
> secrets. They're stored in the Search API server configuration, so treat any
> configuration export that contains them accordingly — keep it out of public
> version control, and follow your project's usual approach for keeping secrets out
> of committed config. The connection itself is always encrypted (HTTPS only), so
> credentials are not sent in the clear.

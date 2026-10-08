# Entity Share — manual setup guide

**Entity Share** (`entity_share`) shares content between separate Drupal sites over
JSON:API. One site acts as a **server**, exposing selected content as "channels";
another acts as a **client**, connecting to that server and **pulling** the content
in. It turns Drupal's built-in JSON:API into a content-staging and syndication
pipeline — useful for pushing editorial content from a staging site to production,
syndicating shared news from a central hub to satellite sites, or keeping a content
type in sync across a fleet of sites that do not share a database. Because the
transport is standard JSON:API, no custom endpoints or migration classes are
needed, and a single site can be both a client and a server.

An important structural point: the base `entity_share` module is essentially a
**shell**. On its own it only adds a landing page and an access permission — all the
real functionality lives in submodules you enable depending on the role each site
plays. You enable **Entity Share Server** on the site that holds the content and
**Entity Share Client** on the site that consumes it (or both, on a site that does
both jobs).

The module requires Drupal 10.3 or 11 and bundles the `league/oauth2-client` PHP
library (for OAuth authentication). It works well with the **Key** module (to store
remote credentials securely) and, if you want OAuth, **Simple OAuth** on the server
side. Note that a real end-to-end sync needs **two sites** — on a single site you
can create and inspect the configuration but cannot complete a pull.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent — the `channel`, `remote`, and
`import_config` entity keys, the plugin types, and the client services — read the
sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   base module plus the server and/or client submodules.
2. [Configuration](configuration/index.md) — define channels on the server, set up
   a remote and import config on the client, and pull content.

## The submodules

- **Entity Share Server** (`entity_share_server`) — enable on the content-holding
  site. Defines **Channel** config entities (what content to expose).
- **Entity Share Client** (`entity_share_client`) — enable on the consuming site.
  Defines **Remote** config entities (which server to connect to), **Import config**
  entities (how to import), and the Pull form and Drush commands.
- **Entity Share Async** (`entity_share_async`) — queue large imports to run
  asynchronously. Requires the client.
- **Entity Share Lock** (`entity_share_lock`) — lock imported content on the client
  so local editors cannot overwrite synced content. Requires the client.
- **Entity Share Diff** (`entity_share_diff`) — show a field-by-field diff of local
  vs remote content before importing. Requires the client.

## Where it lives in the admin menu

The base landing page is at **Configuration → Web services → Entity Share**
(`/admin/config/services/entity_share`). With the server submodule enabled, you
manage **Channels** there; with the client submodule enabled, you manage **Remotes**
and **Import config** there, and you run pulls from **Content → Entity Share**
(`/admin/content/entity_share`).

## How to use it

On the server site, enable Entity Share Server and create a **Channel** for each set
of content you want to share. On the client site, enable Entity Share Client, create
a **Remote** pointing at the server (with the right authentication), create an
**Import config** describing how content should be created/updated, then use the
**Pull** form (or Drush) to bring content across. The
[Configuration](configuration/index.md) page walks through the whole flow.

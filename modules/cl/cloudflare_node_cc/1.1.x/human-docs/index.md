# Cloudflare Node Cache Clear — manual setup guide

**Cloudflare Node Cache Clear** (`cloudflare_node_cc`) gives editors a simple way
to purge Cloudflare's CDN cache from inside Drupal — either for a single node or
for the whole site (zone). It talks to the Cloudflare API and adds a purge action
right where you need it: a button on the node edit form to clear that node's URL,
and an admin‑toolbar item (and route) to purge the entire configured zone.

It solves the everyday problem of stale pages at the edge after you publish a
change. Rather than logging into the Cloudflare dashboard, an editor can clear the
cache for the page they just edited with one click. The module works with either
Cloudflare authentication style — a Global API Key (with account email) or an API
token — and it can manage **multiple zones per language or domain**, which is handy
for multilingual sites served from different hostnames.

This **1.1.x** branch runs on **Drupal 10 and 11**. It depends on the **Node**,
**Admin Toolbar Tools** and **Key** modules, and pulls in the `cloudflare/sdk`
PHP library via Composer. Your Cloudflare credentials are stored in a **Key**
entity (via the Key module) and referenced by name from the module's settings; the
module reads the secret through the Key repository at runtime. It provides its own
permissions so you control who may purge.

The branch also ships **Drush commands** so you can flush the cache from the
command line or a deployment script, and can place a zone into Cloudflare's
under‑attack mode.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and its
   dependencies with Composer and enable them.
2. [Configuration](configuration/index.md) — create the Key, choose an auth type,
   set your zone(s) and grant the purge permissions.

## Where it lives in the admin menu

Configure it at **Configuration → Web services → Cloudflare Node Cache Clear**
(`/admin/config/services/cloudflare-node-cache-clear`), which requires the
**Administer cloudflare_node_cc** permission. Site‑wide purges are available from
the Admin Toolbar Tools menu item **Purge Cloudflare Cache**, or at
`/admin/cloudflare-node-cache-clear/purge-cache`. Per‑node purges appear as an
action button on each node's edit page.

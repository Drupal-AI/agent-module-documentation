# Nextcloud DAM — manual setup guide

**Nextcloud DAM** (`nextcloud_dam`) turns a **Nextcloud** instance into a digital
asset management (DAM) source for Drupal — much as modules for Bynder or Acquia DAM
do. A separate team can curate documents, images, and video in Nextcloud, and your
Drupal editors can then browse and reference those assets as Drupal **media**. It
is built on core **Media**, **Entity Browser**, and the **Social Auth Nextcloud**
module, and it ships a ready‑made `nextcloud` media type plus a `nextcloud
filepicker` entity browser.

The clever part of its design is where the credentials live. Rather than storing
Nextcloud passwords in Drupal, it uses a dedicated Vue.js file‑picker front end
that talks to Nextcloud's API **client‑side, in the browser**, authenticating each
user via **Social Auth Nextcloud** (OAuth2). Those OAuth2 tokens are short‑lived
and can be revoked from Nextcloud at any time, which keeps a site admin's power over
a user's Nextcloud data limited. Because it authenticates per user, a single site
can even connect to **multiple** Nextcloud instances (each user's Social Auth
settings determine which Nextclouds they can pick from). On the Nextcloud side it
requires the **Webapppassword** app to be installed.

Setting it up involves two things beyond enabling the module: connecting to
Nextcloud through Social Auth Nextcloud, and wiring the entity browser widget onto
a field so editors can pick assets. Neither happens automatically — see
[Configuration](configuration/index.md).

> **Heads up:** this is a `1.0.0-alpha` release, is *seeking co‑maintainers*, and
> is **not covered by Drupal's security advisory policy**. Evaluate it carefully
> before production use.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and its Media / Entity Browser / Social Auth Nextcloud dependencies.
2. [Configuration](configuration/index.md) — connect to Nextcloud, wire the entity
   browser onto a field, and store the OAuth credentials safely.

## Where it lives in the admin menu

The module has no single settings dashboard. You work with it across a few core
areas: the media type at **Structure → Media types**
(`/admin/structure/media`), the entity browser at **Configuration → Content
authoring → Entity browsers**
(`/admin/config/content/entity_browser/nextcloud_filepicker/widgets`), and the
Social Auth Nextcloud connection. It provides its own permissions.

## How to use it

Once configured (see [Configuration](configuration/index.md)), an editor opens a
node's edit form, uses the **Nextcloud filepicker** entity‑browser widget on the
media field to browse their connected Nextcloud(s), and selects the assets to
reference. If a user has several Nextcloud credentials in Social Auth, the entity
browser renders one picker per connected Nextcloud.

# Social Simple — manual setup guide

**Social Simple** (`social_simple`) adds lightweight social share links to your
content — Twitter/X, Facebook, LinkedIn, Google+, share-by-email, browser print, and
(with the Entity Print module) print-to-PDF. The links are built from the current
page's URL and title, and you can show them on nodes and taxonomy terms in two ways:
as a display element on a content type, or as a placeable block.

There is no central settings page. Instead you configure sharing where it is used. On
a content type's edit form, a **"Social simple share"** section lets you turn sharing
on, pick which networks appear, set a heading like "Share on", and even source
Twitter hashtags from an entity-reference field (such as Tags). Alternatively, drop
the **"Social simple block"** into any region and choose its title and networks in the
block settings.

The buttons open in a correctly sized popup window (via a small bundled script) and
use FontAwesome icons. An optional submodule, **Social Simple Per Node**
(`social_simple_per_node`), adds a checkbox to the node form so editors can hide the
share links on an individual node. Developers can add or override networks by
registering a tagged service — see the sibling `agent/` docs for that.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the module,
   and optionally enable the per-node submodule.
2. [Configuration](configuration/index.md) — turn on sharing per content type, place
   the block, choose networks, and control the permission.

## Where it lives in the admin menu

Social Simple has no dedicated settings page. You configure it in two places:

- **Per content type** — the *Social simple share* section on
  **Structure → Content types → *(your type)*** (and its **Manage display** tab).
- **As a block** — the *Social simple block* under **Structure → Block layout**.

It provides one permission, **Administer social simple**, which (together with core's
*Administer content types*) controls who can see the per-content-type share settings.

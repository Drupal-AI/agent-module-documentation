# Nodeinfo — manual setup guide

**Nodeinfo** (`nodeinfo`) adds support for the **NodeInfo** and **NodeInfo2**
protocols to your Drupal site. These are standardized JSON endpoints that publish
machine‑readable metadata about a server instance — the software it runs and its
version, the protocols it supports, optional usage statistics, and whether registration
is open — used across the federated social web (the "fediverse") and by
instance‑discovery tools to catalogue and describe servers.

Enable it if your Drupal site participates in, or wants to be catalogued by, fediverse
tooling that reads NodeInfo. Once on, the site advertises this metadata at the
well‑known NodeInfo endpoints so other servers and directories can discover it. You can
enable NodeInfo, NodeInfo2, or both.

**A privacy note worth reading before you enable it:** NodeInfo intentionally
**discloses server metadata publicly** — including your software name and version, and
optionally usage statistics. Publishing your exact version can help attackers
fingerprint the site, so expose only what you are comfortable revealing. This is an
integration/protocol feature and has no access‑control role beyond serving that public
metadata document. It has no other module dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable
   it.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. The site now serves NodeInfo/NodeInfo2 metadata at the well‑known endpoints, which
   fediverse tools and directories query automatically.
3. Because the endpoints publish server software, version, and optionally usage
   statistics publicly, review that you are comfortable disclosing that information
   before pointing federation tools at your site.

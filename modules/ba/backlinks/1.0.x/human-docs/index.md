# Backlinks — manual setup guide

**Backlinks** (`backlinks`) works out which of your nodes link to which. When a
node is saved, it renders the fields you tell it to scan, reads the HTML, finds
the `<a href>` links that point at other nodes on your site, and records those
relationships. Each node can then display a list of the other nodes that link
*to* it — a "backlinks" or "cited by" list.

You use it by adding two fields to your content types: a `linked_node` entity
reference field that captures the target nodes, and a `linked_url` field that
captures the raw hrefs. The module fills these in automatically on save, and a
bulk tool lets you rebuild the links across all existing content in one pass. If
Views is enabled, a provided "Linked Content" view uses the `linked_node`
relationship so you can build a related-content block from incoming links.

The module only reads markup that is already stored on your nodes and resolves
internal node routes — it never fetches remote URLs, so there is no outbound
request or SSRF surface. Both of its admin screens require the *Administer site
configuration* permission. It depends on core's **Node** module and runs on
Drupal 9 through 12.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — add the fields, choose which fields
   are scanned, and run the bulk rebuild.

## Where it lives in the admin menu

The settings form is at **Configuration → Content authoring → Backlinks**
(`/admin/config/content/backlinks`), and the bulk rebuild tool is at
`/admin/config/content/backlinks/update`.

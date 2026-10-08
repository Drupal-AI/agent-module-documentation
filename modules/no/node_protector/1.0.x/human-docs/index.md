# Node Protector — manual setup guide

**Node Protector** (`node_protector`) is a lightweight safety net that stops one
specific node from being deleted — typically your site's front page. Many themes
and site builds designate a particular node as the homepage, and deleting it by
accident (a stray click, a bulk‑delete gone wrong) can break the site and mean
rebuilding the page from scratch. Node Protector guards against exactly that.

It works by intercepting the delete operation: when someone tries to delete the
protected node, the module shows a warning, redirects them back to the node, and
halts execution so the delete never actually completes. This is **fail‑closed** —
execution stops before Drupal removes anything — and it applies to *everyone*,
including administrators, without depending on user permissions (so there is no
permission rebuild to worry about).

Its scope is deliberately narrow. It protects **exactly one node**: either a
specific node you name by its node ID (NID), or — if you turn on the automatic
option — whatever node is currently set as the site's front page. It is not a
content‑type‑wide guard and not a general access‑control system; think of it as an
active insurance policy for a single critical landing node, complementing (not
replacing) your backups. It has no dependencies beyond core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose the node to protect, or enable
   automatic front‑page protection.

## Where it lives in the admin menu

The settings form is at **Configuration → System → Node Protector**
(`/admin/config/system/node_protector/settings`), gated by the **Administer site
configuration** permission.

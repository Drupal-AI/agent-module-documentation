# Protected Nodes — manual setup guide

**Protected Nodes** (`protected_nodes`) password‑protects individual nodes. When a node
is protected, visitors see a password form instead of its content until they enter the
correct password. It is meant for content you want to gate behind a single shared
password without creating per‑user accounts or roles.

The gate is enforced at Drupal's **entity‑access layer**: the module's
`hook_node_access()` returns "forbidden" for a protected node until it is unlocked. That
means the protection is respected wherever `view` access is checked — the node's own
page, and per‑entity access checks in Views and JSON:API — not just on the canonical
page.

Two things are worth understanding before you rely on it. First, it is a **shared‑
password** gate: everyone who can reach the node uses the same password, so it is a
coarse control rather than per‑user access. Rotate the password periodically, and don't
use it for genuinely high‑sensitivity content that deserves real role‑based
permissions. Second, watch out for **files**: a node's uploaded files served from the
public file system have their own public URLs that bypass node access, so protecting a
node does not automatically hide its attachments. Use the private file system for files
that must stay gated.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — choose which content types can be
   protected, set the permissions, and place the field on the node form.

## Where it lives in the admin menu

Protected Nodes adds its options where you would expect them: content‑type settings
choose which types support protection, the **People → Permissions** page controls who
can manage it, and the per‑node "Protected" control lives on the node edit form once
you place it. See [Configuration](configuration/index.md) for the full walk‑through.

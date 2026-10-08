# Custom Nid — manual setup guide

**Custom Nid** (`custom_nid`) adds a field to the node‑creation form that lets a
permitted user choose the node's **ID** (`nid`) instead of taking the next value from
the sequence. If a node with the chosen ID already exists, the module refuses it with
a "Nid already exists" message. It's the node‑specific counterpart to *Custom Entity
Id*.

It exists for one real problem: **preserving URLs and references** when content moves
into Drupal from somewhere else. If a legacy system's article 4217 is linked from a
thousand external pages and its Drupal URL must stay `/node/4217`, the node ID has to
be *set*, not assigned. Migrate can do that at scale, but for a handful of nodes
recreated by hand — or content restored after an accidental deletion — a field on the
form is the proportionate tool. It's also handy when business logic or theming keys off
a specific node ID.

Setting a primary key by hand is powerful and easy to get wrong, so the module gates
the field behind a single **restricted** permission, **`custom_nid access`**. That
restriction is load‑bearing: choosing an ID can collide with an existing node, jump the
auto‑increment sequence so future IDs skip ranges, and surprise anything that assumes
IDs are dense or monotonic (paging by ID, incremental sync, external references). Grant
the permission for a migration window, then revoke it — it isn't a permission to leave
assigned. The module has no dependencies and no configuration; it works on Drupal 10,
11, and 12. (The version number 12.0.0 tracks the core major, not semantic versioning;
the code is unchanged from the 11.0.x branch.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** — the module has no settings. All you do is grant
the permission and use the field on the node form, as described in "How to use it"
below.

## How to use it

1. At **People → Permissions**, grant **`custom_nid access`** to the specific, trusted
   role that needs it — typically a migration or administrator role. Because setting a
   node ID by hand is sensitive, keep this permission tightly scoped.
2. As a user who holds that permission, go to **Content → Add content** and start
   creating a node. You'll see a field for entering the node's ID.
3. Enter an unused ID and save. Entering an ID that already exists produces a "Nid
   already exists" message.
4. When your migration or restore task is finished, **revoke the permission**.

For anything repeatable or large, use Drupal's **Migrate** system instead, which sets
IDs as part of a mapped, rollbackable process. Reserve Custom Nid for a small number of
hand‑created nodes or a short migration window.

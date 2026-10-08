# Node Preview Permissions — manual setup guide

**Node Preview Permissions** (`node_preview_permissions`) puts Drupal's node
**Preview** feature behind a permission. By default, whether a user can use the
"Preview" button when saving a node is tied to their edit access. This module
replaces that check with dedicated permissions — a general **use node preview** and
a per‑bundle **use *(content type)* node preview** — so you can grant preview to
roles such as reviewers **without** giving them permission to edit the content.

The typical use case is an editorial workflow where a reviewer needs to see how a
draft will look, but should not be able to change it. With this module you grant
that role the preview permission (globally or for specific content types) and
nothing more.

There is an important safety point worth understanding: a node preview is stored in
the **previewing user's own private, session‑scoped tempstore**. That means this
permission governs whether a user can use the preview feature **on their own
preview** — it does *not* let a permission‑holder view *other* users' drafts,
because the preview data is per‑session. So granting it does not expose anyone
else's unsaved work. The module depends only on core's **Node** module and has no
other access‑control role.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

Configuration is entirely a matter of assigning permissions — there is no settings
form. See "How to use it" below.

## How to use it

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. For each role that should be able to preview content, grant **use node
   preview** (to allow preview across all content types) and/or the per‑bundle
   **use *(content type)* node preview** permissions (to allow preview only for
   specific types).
3. Members of those roles now see and can use the **Preview** button when adding or
   editing the relevant nodes, without needing broader edit rights.

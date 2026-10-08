# Node View Language Permissions — manual setup guide

**Node View Language Permissions** (`node_view_language_permissions`) adds
fine‑grained view permissions to nodes based on the node's **language**. For every
content type, and for every language on your site, it provides a **"View own content"**
and a **"View any content"** permission — so you can, for example, let one role view
French‑language articles while another role can only view English ones.

This is a genuine, hard access boundary — not a UI‑only tweak. It is built on Drupal's
**node‑grants system** (`hook_node_access_records()` + `hook_node_grants()`), which
enforces access at the **database‑query level**. That means nodes a user isn't
permitted to view are filtered out of listings, search results, and Views — not merely
hidden on their full page. This is the strong, correct pattern for node access, and it
is an extended version of the **Node View Permissions** module.

Two things follow from using node grants. First, the permissions are **additive**: a
user needs a granting permission to see a node, so grant the per‑type/per‑language
permissions to match your intent and then **test** that the right users can and cannot
see nodes in each language. Second, after enabling the module (and whenever you change
which permissions apply), Drupal needs to **rebuild node access permissions** so the
grants take effect. The permission lists can get very long if you have many languages
and content types.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

Configuration is done entirely on Drupal's standard **Permissions** page and the
**Node access permissions** report — there is no dedicated settings form. The steps are
described below.

## How to set it up

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **People → Permissions** (`/admin/people/permissions`) and find the **Node
   view language permissions** section. For each role, grant the per‑content‑type,
   per‑language **View own content** and **View any content** permissions that match
   your intent.
3. Go to **Reports → Node access permissions**
   (`/admin/reports/status/rebuild`) and **rebuild permissions** so the new grants are
   written to the node‑access tables.
4. **Test** with real accounts: confirm that a user with a language permission can see
   nodes in that language (in listings, search, and Views), and that a user without it
   cannot. Remember grants are additive — a user with no matching permission sees
   nothing extra.

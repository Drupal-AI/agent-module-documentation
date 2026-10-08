# Node Authorize Link — manual setup guide

**Node Authorize Link** (`node_authlink`) creates per‑node secret "magic links" that let an
unauthenticated visitor view, view a revision of, edit, or delete **one specific node** —
without logging in and without an account. Each link carries an `?authkey=` token, and anyone
who has the link gets exactly the operations you've allowed on that one node, while the rest of
your site stays private.

It's built for sharing workflows: send a client a preview link to a draft that isn't published,
let an outside editor update a single page, give a reviewer access to a particular revision, or
hand a trusted party a one‑off "delete this" link. The URLs are also exposed as tokens
(`[node:authlink:view-url]`, `:edit-url`, `:delete-url`, `:authkey`), so you can drop a
personalized, node‑scoped link straight into a notification email or a field.

You turn the feature on **per content type**, and for each type you choose which operations a
valid key authorizes (view / view revision / edit / delete). Each node gets its own strong
random 256‑bit key stored in the database; keys are minted on demand from the node's **Authlink**
tab (or in bulk from the content‑type form), can optionally be auto‑rotated by cron, and are
deleted when the node is deleted. A bundled view lists every issued link for auditing.

**Read this before you use it.** These links *are* credentials. Because the token is a 256‑bit
random value, nobody can guess or enumerate their way to a node — that part is solid. But there
are real operational risks to understand: the key rides in the **URL query string**, so it can
leak through server logs, browser history, and `Referer` headers; a valid key grants access
**regardless of whether the node is published**, so treat any leaked link as full (configured)
access to that node; the **same key authorizes every enabled operation** (there's no separate
key per operation, so a "view" link is also the edit/delete link if those grants are on); and
keys are **permanent by default** unless you set a regeneration age. Share links carefully, grant
only the operations you need, and consider turning on key rotation.

The module depends only on core's **Node** module and ships no submodules.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.
2. [Configuration](configuration/index.md) — enable authlinks per content type, choose grants
   and rotation, mint links per node, set permissions, and the security caveats in full.

## Where it lives in the admin menu

There is no central settings page. You enable and configure authlinks on each **content type's
edit form** (**Structure → Content types → [type] → Edit**), in a *Node authorize link* section.
You mint and copy a node's links from that node's **Authlink** tab (`/node/{node}/authlink`).

## How to use it

At a glance: enable authlinks for a content type and tick the operations to allow, open a node's
**Authlink** tab and click **Create authlink**, then copy the ready‑made view/edit/delete link
and share it. The full walkthrough — plus the security notes — is in
[Configuration](configuration/index.md).

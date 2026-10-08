# Content Access — manual setup guide

**Content Access** (`content_access`) gives you fine‑grained control over who can
**view**, **edit**, and **delete** nodes, by role. You set the rules once per
content type, can optionally override them on individual nodes, and — with the
companion ACL module — can even grant access to specific named users.

Drupal core lets you say who may create or edit a content type, but view access
is largely all‑or‑nothing. Content Access fills that gap. On each content type it
adds an **Access control** tab where you tick which roles may perform each
operation, including two new options it introduces: *view any* and *view own*. The
edit and delete rows on the same screen mirror core's own permissions, so you can
see and manage all access for a content type in one place.

Turn on **per‑node access control** for a content type and every node of that type
gains its own Access control tab, letting editors override the type defaults for a
single piece of content (and reset it back with one button). Enable the
contributed **ACL** module and that per‑node tab also lets you grant view/edit/
delete to individual users by name.

One important detail: Content Access governs **published** content only.
Unpublished nodes remain controlled by core (their author and anyone with *bypass
node access*). It integrates with Drupal's node grants system and requires a
permissions rebuild for changes to fully take effect. It depends only on core's
Node module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the per‑content‑type and per‑node
   Access control tabs, option by option.

## Where it lives in the admin menu

Content Access has no single settings page. You configure it on **Access control**
tabs: one per content type at **Structure → Content types → (your type) → Access
control** (`/admin/structure/types/manage/{type}/access`), and — when per‑node
control is enabled — one per node at **/node/{id}/access**.

## How to use it

1. Enable the module.
2. Open a content type's **Access control** tab and choose which roles may view,
   edit, and delete that type's content.
3. Optionally turn on **Per content node access control** for the type so
   individual nodes can override the defaults.
4. Rebuild node access permissions when prompted so the changes take effect.

See [Configuration](configuration/index.md) for the full walkthrough.

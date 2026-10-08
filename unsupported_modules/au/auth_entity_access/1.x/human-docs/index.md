# Authenticated Entity Access — manual setup guide

**Authenticated Entity Access** (`auth_entity_access`) lets you mark an individual
node as "logged-in users only" with a single checkbox on the node's edit form. When
the box is ticked, that node is forbidden to anonymous visitors; leave it unticked and
the node behaves normally. It is a lightweight, per-node alternative to setting up
full content-access rules when you only need to hide the occasional page from the
public.

Enforcement is done the authoritative way — through Drupal's `hook_entity_access`, not
a theme tweak. That means a restricted node is denied to anonymous users on its
canonical page **and** through JSON:API and REST, so the protection holds across every
standard way of reaching the content.

There is one nuance worth knowing. The module restricts *access* to a node but does
not register node-access *grants*, which are what filter raw listing queries. So a
restricted node could still surface as a title or teaser in some listing built
directly on the node-access grants table (certain Views), even though clicking through
to it returns a 403. If you need the node hidden from listings as well as from direct
access, pair this module with a grants-based approach.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable
   it.

## How to use it

The module has no central settings page. Its two touch points are a permission and a
per-node checkbox.

### Grant the permission

The module defines a **`configure auth entity access`** permission that controls who
may set the restriction. Grant it to trusted roles (typically editors and
administrators) at **People → Permissions** (`/admin/people/permissions`).

### Restrict a node

1. Edit the node you want to protect.
2. Tick the **authenticated-users-only** checkbox on the edit form.
3. Save.

From then on, anonymous visitors are forbidden that node — its canonical page returns
a 403, and JSON:API/REST deny it too. Untick the box and save to make it public again.

### Keep in mind

Because the module enforces access but not node-access grants, verify listing behavior
on your site: a restricted node may still appear as a title/teaser in a grants-based
Views listing (opening it still 403s). Combine with a grants-based module if you need
full listing-level hiding.

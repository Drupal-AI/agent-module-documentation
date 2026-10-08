# Masquerade as Role — manual setup guide

**Masquerade as Role** (`msqrole`) lets a permitted user temporarily view the
site as if they held a **different set of roles**, without changing which user
account they are logged in as. This is the key difference from the well‑known
Masquerade module: Masquerade switches you into another *user*, whereas this
module keeps you as yourself (same user id) but changes your *effective roles*.

It is a natural fit for QA and permission debugging. Stay logged in as an
administrator and see a page exactly as an "editor" or "member" role would — which
blocks, menu links, local tasks, and content each role can and cannot see —
without creating throwaway test users or logging in and out. Because your real
user id is preserved throughout, audit trails stay clear.

You can also share the experience. Users with the right permission can generate a
**shareable link** that drops a colleague into a specific set of roles for a demo
or review, optionally as a **single‑use** link. A small status widget shows which
roles are currently active and offers a one‑click reset back to your real roles.

Because switching effective roles could otherwise leave stale, permission‑specific
markup in Drupal's render cache, the module handles caching carefully: it varies
the render cache by masquerade state and clears a standard set of cache tags when
you switch. If a particular block still shows or hides incorrectly after
switching, you can add its cache tag to the settings so it is cleared too.

Masquerade as Role requires **PHP 8.1+** and **Drupal 10 or 11**, and has no
dependencies beyond core. It provides its own permissions, including a
per‑role permission so you can control exactly which roles each user may
impersonate.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the permissions that control who can
   masquerade, and the settings form for extra cache tags.

## Where it lives in the admin menu

There are two screens. You **use** the feature at **People → Masquerade as role**
(`/admin/people/masquerade-role`), where you pick the roles to view the site as.
You **configure** it at **Configuration → People → Masquerade as role**
(`/admin/config/people/masquerade-role`), where the settings form lives.

## How to use it

With the **Masquerade role** permission, open **People → Masquerade as role**,
tick the roles you want to view the site as, and submit. The rest of the site now
behaves as if you held those roles, while you remain logged in as yourself. Use
the status widget's **reset** link (or the reset route) to return to your real
roles at any time. With the **Create masquerade role link** permission you can
generate a shareable link that activates a chosen role set for whoever opens it —
optionally single‑use. Which roles each user may choose is controlled by the
per‑role permissions described in [Configuration](configuration/index.md).

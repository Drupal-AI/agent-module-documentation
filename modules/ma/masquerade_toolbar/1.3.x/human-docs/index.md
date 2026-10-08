# Masquerade Toolbar — manual setup guide

**Masquerade Toolbar** (`masquerade_toolbar`) is a modern, floating toolbar for
**quick user switching** through the
[Masquerade](https://www.drupal.org/project/masquerade) module. An authorised
administrator can search for a user by name or email, masquerade as them in one
click from any page, and switch back just as quickly — which is ideal for
developers, site admins, and support teams who constantly need to test permissions
or reproduce a user‑specific problem.

The toolbar is an unobtrusive, collapsible widget you can pin to any of four screen
corners. It offers autocomplete user search (with roles shown in the results), a
recent‑users list for one‑click repeat switches, a clear display of who you
currently are versus your original account, one‑click "switch back", optional
keyboard shortcuts, and mobile‑responsive behaviour. It is a from‑scratch rewrite
for Drupal 10/11 inspired by Masquerade Float Block.

> **What it does and does not do (verified):** access is properly gated. The
> toolbar and its user autocomplete require this module's **`use masquerade
> toolbar`** permission **and** a Masquerade masquerade‑as permission
> (`masquerade as any user` or `masquerade as super user`), enforced by a custom
> access checker. It does **not** weaken or bypass Masquerade's permission model —
> it is a friendlier front end to it. Impersonation remains powerful (while
> masquerading you can do whatever the target user can), so keep the underlying
> Masquerade permissions granted only to trusted staff, and make sure impersonation
> is captured in an audit log.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (alongside Masquerade) and enable it.
2. [Configuration](configuration/index.md) — set permissions and tune the
   toolbar's appearance and behaviour.

## Where it lives in the admin menu

The settings form is at **Configuration → People → Masquerade Toolbar**
(`/admin/config/people/masquerade-toolbar`).

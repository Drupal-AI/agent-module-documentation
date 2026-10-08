# Permissions Enhancer — manual setup guide

**Permissions Enhancer** (`permissions_enhancer`) adds some quality-of-life
improvements to Drupal's role permission pages. Working out which permissions a
role actually has can be a slog on a larger site, where `/admin/people/permissions`
is one enormous table — and this module makes it far easier to scan.

It does three things:

- **A summary of active permissions** at the top of each role's permission page,
  so you can see at a glance what the role currently holds without hunting
  through the whole grid.
- **Show/hide buttons** for the permissions a role does *not* have, letting you
  collapse the noise and focus on what is granted.
- **Extra styling** on the permissions table so rows and sections are quicker to
  read.

It is purely an admin-UX enhancement — it changes how the permissions page looks
and reads, not what any permission does or who has it. There is no change to the
permission model at all.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no settings form** — the enhancements appear automatically on the
permissions pages once the module is enabled.

## Where it lives in the admin menu

Permissions Enhancer adds no page of its own. Its improvements show up on the
existing role permission pages under **People → Permissions**
(`/admin/people/permissions`), including the per-role permission forms. Just open
those pages as usual and you will see the summary, the show/hide controls, and
the improved styling.

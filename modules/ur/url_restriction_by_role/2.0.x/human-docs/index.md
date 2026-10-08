# Url Restriction by Role — manual setup guide

**Url Restriction by Role** (`url_restriction_by_role`) lets an administrator lock
specific URLs down to specific roles. You build a small table of paths — each with
an *Enabled* toggle and a set of *Allowed Roles* — and anyone who doesn't hold one
of the allowed roles is turned away with a 403 (or a custom message you write).

Paths support `*` wildcards and are matched against both the internal path and its
URL alias, so a single rule like `/members/*` can protect a whole section, whether
visitors arrive via the raw path or a friendly alias. It's a lightweight,
path-based complement to Drupal's normal route and permission access — useful for
gating pages that aren't otherwise permission-protected, such as a static alias, a
beta landing page, or a reporting path.

The model is an **allow-list of restricted paths**: only the paths you list and
enable are restricted, and everything else stays fully accessible. There is no
global "deny everything by default." The module is a single request-time event
subscriber plus one admin form; it has no dependencies beyond Drupal core, no
Drush commands, and no config schema.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the restrictions table, how matching
   works, custom error messages, and important lockout/caching caveats.

## Where it lives in the admin menu

The settings form lives under the URL/path administration area at
**Configuration → Search and metadata → URL aliases → URL restriction by role**
(`/admin/config/search/path/url-restriction-by-role`). It is gated by the
**Admin url restriction by role settings** permission, which is marked as a
restricted/administrative permission — grant it only to fully trusted admins.

## How to use it

After enabling, open the settings form, add a row for each path you want to
protect (for example `/node/add` or `/members/*`), tick **Enabled**, and choose
which roles may reach it. Save, then test as a user *without* one of those roles —
you should get a 403. Read the [Configuration](configuration/index.md) page before
you rely on this for anything sensitive: there are real caveats around anonymous
users and Drupal's page cache.

# Feature flags — manual setup guide

**Feature flags** (`featureflags`) gives Drupal a proper feature‑flag system: a
`feature_flag` **configuration entity** you define, plus the three pieces of
plumbing that make flags usable — a **manager service** to check a flag from code,
a **cache context** so flagged output caches correctly, and a **condition plugin**
so a flag can gate block visibility (and anywhere else conditions are collected).

A flag is a named switch you can flip without a deployment. That is how teams ship
unfinished work behind a toggle, run a staged rollout, or quickly kill a misbehaving
feature. Doing it properly in Drupal needs more than a boolean in `settings.php`:
code has to query it, the render cache has to vary on it, and site builders should
be able to use it without writing PHP — this module supplies all three.

Because flags are **configuration entities**, they move through the normal config
workflow: create a flag in one environment, export it, deploy it, and switch it per
environment with a config override if production and staging should differ. That
reviewable, diffable trail is the main reason to prefer this over an ad‑hoc `state`
value. (The definition of a flag lives in config; its active/inactive **state** is
stored in Drupal's state system.)

Two things are worth knowing up front. First, the permission — *administer
featureflag entities* — is not marked "restrict access", but whoever holds it can
enable any feature hidden behind a flag, including one hidden because it is not yet
ready. Treat the flag list as part of the site's control surface, not as content.
Second, the **cache context is the piece most often forgotten**: if flagged output is
rendered without declaring the context, the first request's variant is cached and
served to everyone — the classic "the flag does nothing" bug.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — create feature flags, switch them on or
   off, and use them to gate a block.

## Where it lives in the admin menu

Feature flags are managed at **Configuration → Development → Feature Flags**
(`/admin/config/development/featureflags`), gated by the *administer featureflag
entities* permission. See [Configuration](configuration/index.md).

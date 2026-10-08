# Changelogify — manual setup guide

**Changelogify** (`changelogify`) automatically watches your Drupal site for
changes — content being created, updated, or deleted, modules installed or
uninstalled, user role changes — and helps you turn that raw activity into
polished, categorised release notes. It bridges the gap between silent automatic
logging and the hand‑written changelog you'd normally have to compile yourself,
and it publishes a clean, themeable changelog at `/changelog`.

The workflow is draft‑and‑review. Changelogify quietly accumulates events in the
background. When you're ready to communicate an update, you open its dashboard,
generate a draft release from a date range (or "since the last release"), and the
captured events are grouped into the industry‑standard sections — **Added,
Changed, Fixed, Removed, Security, and Other**. You edit the descriptions for
clarity, then publish. The result appears on the public changelog page. It's
handy for agencies producing "what we did this month" reports, product sites
keeping users informed, and intranets tracking internal system updates.

The module starts capturing events the moment you enable it, but it needs a few
setup steps to be fully useful: choose which event types to track and set
retention limits, then generate and publish your first release. It provides its
own permissions and depends on core's `datetime`, `node`, `options`, and `user`
modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose which events to track, set
   retention, and generate and publish releases.

## Where it lives in the admin menu

- **Settings** — `/admin/config/development/changelogify/settings` (choose which
  events to track and set retention limits).
- **Dashboard** — `/admin/config/development/changelogify` (review accumulated
  events and generate/publish releases).
- **Public changelog** — `/changelog` (where published releases appear to
  visitors).

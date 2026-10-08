# Git Deploy — manual setup guide

**Git Deploy** (`git_deploy`) is a zero‑configuration developer utility for sites
that run directly from **Git checkouts** of core and contrib. When Drupal.org
packages a release, it stamps `version`, `project`, and `datestamp` into each
module's `.info.yml`. A plain `git clone` has none of that metadata, so Drupal's
Update Status system flags the project as an unsupported or unknown version on the
Available Updates page.

Git Deploy fills that gap at runtime. It reads each extension's Git history —
using the `git` command to find the best‑matching upstream branch or release tag —
and reconstructs the missing `version` (for example `2.6.x-dev`, or a real tag
when the checkout sits exactly on one), `project` (derived from the Git remote
URL), and `datestamp` (from the relevant commit). It also keeps dev‑release
datestamps in sync with the Drupal.org release feed so "update available"
comparisons stay accurate. For core checkouts it first verifies the repository is
actually Drupal before touching any version.

The result: developers working in Git clones (say, to contribute patches) get a
clean, accurate update report instead of a wall of unsupported‑version warnings —
without hand‑editing `.info.yml` files.

There is **no UI, no settings, and no permissions**. Enabling the module is the
entire setup. Its one requirement is that PHP's `exec()` be enabled and the `git`
binary be available on the server's PATH; the module reports an error on the
status page if either is missing.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and confirm the `git`/`exec()` requirements.

## Where it lives in the admin menu

Git Deploy has **no admin page**. You see its effect at **Reports → Available
updates** (`/admin/reports/updates`), where Git‑checked‑out projects now show real
versions. Its requirement checks appear at **Reports → Status report**
(`/admin/reports/status`).

## How to use it

There is nothing to configure — just enable it. Once enabled:

1. Visit **Reports → Status report** and confirm there is no Git Deploy error
   (that would mean `git` or `exec()` is unavailable — see
   [Installation](installation/index.md)).
2. Visit **Reports → Available updates** and check that your Git‑checked‑out core
   and contrib projects now report proper versions (such as `x.y.z-dev` or a real
   release tag) instead of being flagged as unsupported.

That's the whole workflow. The module works quietly in the background from then
on.

# PatchInfo — manual setup guide

**PatchInfo** (`patchinfo`) once surfaced the patches applied to your site
directly on Drupal's update status report. Every non-trivial site carries a few:
a fix backported from an unreleased branch, a workaround for an incompatibility,
a local tweak to contrib behaviour. Those patches are applied by Composer but are
otherwise invisible — the update report shows a module's version and says nothing
about the changes layered on top of it. PatchInfo read patch sources (Composer's
patch list, `info.yml` annotations, drupal.org issue references) and displayed
them alongside each project so the person running an update could see what was at
stake.

**This module is now obsolete and cannot be installed.** Its own maintainers have
marked it with the `lifecycle: obsolete` flag, and Drupal refuses to enable any
module in that state — `drush en patchinfo` fails with *"Unable to install
modules: module 'patchinfo' is obsolete."* This is the ecosystem working as
designed: the obsolete lifecycle state stops new adoption rather than leaving a
dead project looking alive. **Do not plan a new site around it.** This guide
exists to explain that status and point you at what to do instead.

The underlying need has not gone away, so the practical answer lives elsewhere:
keep your patch list in `composer.json` (applied by `cweagans/composer-patches`)
with a comment and an issue URL for every entry — that is the record that
survives — and review it as part of every update rather than relying on the site
to remind you.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — why the install fails, and the
   replacement approach to adopt instead.

There is **no configuration page** to document — the module cannot be enabled, so
its former settings (an addition to the core update report at **Reports →
Available Updates → Settings**) are unreachable.

## What to do instead

Because PatchInfo can no longer run, manage your patches the way the modern
Drupal toolchain expects:

- Record every patch in your project's `composer.json` under the
  `extra.patches` section, applied by the
  [`cweagans/composer-patches`](https://github.com/cweagans/composer-patches)
  Composer plugin.
- For each entry, add a human-readable description and the drupal.org issue URL
  as a comment, so the reason for the patch travels with it.
- Treat the patch list as part of your update routine: before and after every
  `composer update`, review which patches still apply and which have been
  superseded by a new release.

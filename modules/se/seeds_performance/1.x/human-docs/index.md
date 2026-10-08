# Seeds Performance — manual setup guide

**Seeds Performance** (`seeds_performance`) is a starter module that enables a
curated set of performance modules for the Seeds distribution. Rather than a
feature of its own, it is a convenience aggregator: enabling it pulls in and turns
on a small, opinionated performance stack so a new site gets a sensible baseline
in one step.

Performance tuning on Drupal usually means enabling and configuring several
modules — caching, aggregation, image optimisation, a better cron runner. Seeds
Performance bundles that starting point. Its dependencies are **WebP** (`webp`,
for modern image formats) and **Ultimate Cron** (`ultimate_cron`, for more
controllable scheduled tasks), which Composer installs alongside it. It adds
functionality rather than posing a risk, but because it is an opinionated bundle,
review which modules it brings and whether their default configuration suits your
site. It is perfectly usable as a curated performance starter on a non-Seeds site
too, subject to that same review.

This module has **no configuration screen of its own** — the tuning happens in the
individual modules it enables. Once it is on, visit those modules' own settings to
adjust behaviour, and check the results against your site before production.

This guide is written for a **human** working through the admin UI. If you want
terse references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   bundle.

## How to use it

There is nothing to configure on Seeds Performance itself. After enabling it, go
to the settings pages of the modules it brought in (WebP, Ultimate Cron, and core
Performance at `/admin/config/development/performance`) to review and tune caching,
aggregation, and image handling for your site.

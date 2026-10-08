# SEO Broken Links — manual setup guide

**SEO Broken Links** (`brokenlinks`) scans the formatted‑text fields on your
content for broken links and repairs them, historically using a URL shortener
service. It runs as a background **queue worker**, so the scanning and rewriting
happen during Drupal's queue processing rather than while an editor waits. The goal
is to keep your content's outbound links healthy for both SEO and reader
experience.

Two things are important to understand before you use it. First, it **rewrites your
content fields** based on an external service, so you should review its
configuration and validate its behavior against a copy of your content before
running it on production. Second, the URL shortener it references — Google's URL
Shortener — is **deprecated and shut down**, so confirm the module's current
behavior for your version before relying on the link‑repair step.

It supports Drupal 10.2+ and 11 and has no additional module dependencies.

This guide is written for a **human** using the module through the admin UI. If you
want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — requirements, installing with Composer,
   and enabling the module.

## Where it lives in the admin menu

The module provides its own permissions (grant them under **People → Permissions**,
`/admin/people/permissions`) and does its work through Drupal's queue system —
processed on cron or via Drush's queue commands — rather than through a page you
watch. There is no standalone dashboard.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Review its configuration and confirm you are comfortable with it rewriting your
   formatted‑text content, given that the referenced shortener service is
   deprecated.
3. Let cron (or a manual queue run) process the worker, which scans formatted‑text
   fields for broken links and repairs them. Validate the results on non‑production
   content first.

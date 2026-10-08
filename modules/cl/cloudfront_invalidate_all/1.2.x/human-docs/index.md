# CloudFront Invalidate All — manual setup guide

**CloudFront Invalidate All** (`cloudfront_invalidate_all`) is a deliberately
simple bridge between Drupal's cache and an **AWS CloudFront** distribution: the
moment Drupal wants to invalidate its cache, this module immediately invalidates
the *entire* CloudFront cache with a wildcard (`/*`) invalidation. Its whole goal
is ease of setup for **small sites** — a few thousand URLs — where you just want
the CDN copy to refresh whenever Drupal clears caches, without building a
tag‑to‑path mapping.

It exists as a lighter alternative to the full Purge + CloudFront‑purger stack,
which the maintainer describes as complicated and not working out of the box with
CloudFront (you'd otherwise have to write your own mappings from cache tags to
CloudFront paths). For a small site you usually don't need that, and this module
skips it entirely by just clearing everything.

> **This module is obsolete.** Since April 2026 AWS CloudFront supports cache‑based
> invalidation, and the maintainer now recommends using the standard **Purge**
> module together with the `cloudfront_purger` (^2.2) module instead. This module,
> in the maintainer's words, "no longer serves a purpose." It is also unsuitable
> for large sites — frequent wildcard invalidations are coarse and carry AWS cost
> implications.

Note what it does *not* do: it does **not** let you enter AWS credentials in
Drupal. It assumes your environment already provides AWS access — via the AWS
metadata service (an IAM role) or environment variables — and that keeps the AWS
access key and secret out of Drupal's config entirely.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the distribution ID, provide AWS
   credentials via your environment, tune the cache-tag whitelist, and switch the
   module on (it ships disabled).

## Where it lives in the admin menu

The module works automatically once configured **and un-disabled** (it ships with
invalidations switched off). Its distribution ID is set in `settings.php` (or on the
settings form), AWS credentials come from your environment/IAM role, and the
cache‑tag **whitelist** — the list of tag prefixes allowed to trigger a clear — can
be edited on the module's settings form.

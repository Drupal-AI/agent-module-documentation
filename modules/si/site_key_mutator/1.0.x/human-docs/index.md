# Site Key Mutator — manual setup guide

**Site Key Mutator** (`site_key_mutator`) is a small privacy module that **anonymizes
the unique site key** Drupal core's Update module sends when it checks for available
updates. Every Drupal deployment sends a per-site identifier along with its update
requests; that identifier lets drupal.org — and anyone else able to observe the
requests — profile and track a specific site or domain over time. This module separates
that telemetry from the useful part of update reporting.

The motivation is concrete: the 2024 WP Engine tracker incident showed how update APIs
can reveal information site owners would rather keep private. Drupal's Update API is less
invasive than some other CMSes', but the unique per-deployment identifier is still there.
Site Key Mutator lets you either **remove** that site id from each request, or **replace
it with a random** one. The maintainer is candid about the limits: this disables or
randomizes the tracking id in the request, but it cannot prevent every form of
correlation — third parties could still attempt to fingerprint a site by other means.
Think of it as restoring what arguably should be a core option: keeping update
functionality while shedding the tracking id.

The module does its job in the background once enabled, and depends only on core
**Update**. It targets Drupal 10.3+ and 11 and has no submodules.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Enabling the module is the main step — it hooks into the core Update module's request
so the unique site key is anonymized on each update check, by either **removing** the id
or **replacing it with a random** value. There is no visible front-end feature; the
benefit is simply that the identifying key stops (or randomizes) in the telemetry Drupal
sends. Keep the module enabled to keep the effect.

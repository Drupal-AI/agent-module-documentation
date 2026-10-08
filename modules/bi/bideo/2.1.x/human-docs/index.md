# Batch Video — manual setup guide

**Batch Video** (`bideo`) shows a video on Drupal's batch-processing progress screen
so that users have something to watch while a long operation runs. When Drupal is
busy importing, migrating or running a bulk action, the usual progress bar can feel
slow — Batch Video fills that wait with a video of your choosing.

It is a small, focused bit of admin polish. It injects the chosen video into the
core Batch API progress page and does nothing else: it does not change how batches
actually run, adds no front-end footprint outside batch pages, changes no content,
and calls no external service. Its only job is to improve the *perceived* wait time
during processing.

The module has a single, simple setting — which video to display — and it works with
any batch-driven operation on the site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The one settings form sits at **Configuration → Batch Video**
(`/admin/config/bideo/settings`) and is gated by the **Administer site
configuration** permission.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Go to `/admin/config/bideo/settings` as a user with **Administer site
   configuration**.
3. Choose the video you want to display, and save. From then on, any long-running
   batch operation shows that video on its progress screen. There is nothing else to
   configure — the module leaves the batch behavior itself untouched.

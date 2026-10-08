# GlobalLink Connect for Drupal — manual setup guide

**GlobalLink Connect for Drupal** (`globallink`) is a translator plugin for the
**Translation Management Tool** (TMGMT). It connects your Drupal site to
**GlobalLink**, the commercial translation-management platform run by
translations.com, so that content you send for translation from Drupal is routed
to GlobalLink and the finished translations flow back automatically.

TMGMT handles the Drupal side of the workflow — creating translation jobs and job
items, checkout, review, and acceptance — and then hands the actual translation
work to a *translator plugin*. This module is that plugin for one specific vendor.
If your organisation already has a translation contract with translations.com,
this is the piece that wires Drupal into it. If you do not have a GlobalLink /
translations.com account, this module has nothing to offer on its own — you would
need one of TMGMT's other translator plugins instead.

When you submit a job, the module maps TMGMT's job settings (due date,
required-by, urgent flag, comment, and submitter) onto the matching GlobalLink
project fields. That mapping is where most setup problems live, so the
vendor-side GlobalLink project must be configured to match what Drupal sends.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and the required
   vendor PHP library with Composer, and enable it alongside TMGMT.
2. [Configuration](configuration/index.md) — add GlobalLink as a TMGMT translator,
   enter your vendor credentials safely, and check the field mapping.

## Where it lives in the admin menu

GlobalLink Connect adds no admin page of its own. You configure it as a
**translator** inside TMGMT, at **Configuration → Regional and language →
Translation Management → Providers** (`/admin/tmgmt/translators`). From there you
create or edit a translator that uses the GlobalLink plugin. Day-to-day
translation work happens on TMGMT's own screens under **Translation** and on each
content item's *Translate* tab.

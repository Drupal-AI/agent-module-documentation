# MemoQ translator — manual setup guide

**MemoQ translator** (`tmgmt_memoq`) is a translation‑provider plugin for the
[TMGMT](https://www.drupal.org/project/tmgmt) (Translation Management Tool)
framework. It connects Drupal's translation jobs to a **memoQ** server's CMS API:
when you submit a TMGMT job, the module creates a memoQ **order**, exports each job
item to gzipped XLIFF, uploads it as a memoQ job, and later pulls the completed
translation back into Drupal. In short, it lets a professional memoQ translation
team handle the content of a multilingual Drupal site through TMGMT's normal
workflow.

Completed translations come back two ways. memoQ can **push** them via a callback
webhook the module exposes, and Drupal can **pull** them on demand with the
plugin's fetch action. Along the way it maps each Drupal language to its memoQ
language code, can prefix order names for easy identification, and offers a couple
of XLIFF processing options (HTML‑tag masking and a CDATA toggle). Every outbound
call goes to the CMS API URL you configure, authenticated with an API key.

The module depends on **TMGMT** and **TMGMT File**, and needs PHP's **zlib**
extension for gzip. It has no standalone settings page — you configure it by adding
a "MemoQ" translator inside TMGMT — and no permissions or Drush commands of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside TMGMT.
2. [Configuration](configuration/index.md) — add and set up the memoQ translator,
   map languages, keep the API key out of exported config, and submit jobs.

## Where it lives in the admin menu

There is no dedicated settings page. You add and configure the provider under
**Translation → Providers** at `admin/tmgmt/translators` (also reachable at
`admin/config/regional/tmgmt/translators`) by creating a translator of type
**MemoQ**.

## How to use it

Once you've configured a MemoQ translator (see
[Configuration](configuration/index.md)), it becomes a selectable provider when
you check out a TMGMT translation job. Submitting the job creates and commits a
memoQ order; the translated content flows back automatically via the callback, or
you can fetch it manually. TMGMT `RemoteMapping` entities keep track of the link
between each Drupal job and its memoQ order/job.

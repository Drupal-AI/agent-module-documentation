# Smartling Translator — manual setup guide

**Smartling Translator** (`tmgmt_smartling`) connects Drupal to the
[Smartling](https://www.smartling.com/) translation platform through the
**Translation Management Tool (TMGMT)**. It registers a TMGMT *provider* plugin
called **Smartling** that exports your translatable content as XML/XLIFF, uploads
it to a Smartling project, optionally captures visual "context" so translators can
see strings in place, and downloads the finished translations back into your
TMGMT jobs.

The problem it solves is the round trip. Sending content out for professional or
machine translation and getting it cleanly back into the right fields is fiddly to
do by hand; this module automates the whole flow on top of TMGMT — uploads and
downloads are queued and processed by cron, and completed translations can also be
pulled back automatically when Smartling calls the module's callback URL. You will
need an **active Smartling subscription** and the API credentials (Project Id, User
Id, and Token Secret) for a Smartling project.

This module does **not** work on enable alone — it is a provider that you must
configure. It depends on **TMGMT** (`tmgmt`), **TMGMT File** (`tmgmt_file`), the
**TMGMT Extension Suite** (`tmgmt_extension_suit`, which schedules and processes
the upload/download queues), and core **Serialization**. It also requires the
`smartling/api-sdk-php` PHP library, which Composer installs for you. A few small
helper submodules ship alongside it: a context-debug form, per-channel log-severity
settings, an Acquia Cohesion helper, and a test-only module.

One thing worth knowing up front: the two Smartling **callback routes**
(`/tmgmt-smartling-callback/…`) are called by Smartling
when a translation is ready, and they simply schedule a download for that job.
They are optional; you only expose them if you turn on *Use Smartling callback*.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, pull in the TMGMT
   dependencies, and enable the module and any submodules you need.
2. [Configuration](configuration/index.md) — create a Smartling provider and walk
   through its settings form field by field, including credentials, callbacks, and
   context.

## Where it lives in the admin menu

There is no single "module settings" page. Everything is configured **per TMGMT
provider** at **Translation → Providers**
(`/admin/tmgmt/translators`). Create a provider, choose **Smartling** as the plugin,
and fill in the form. Two extra admin actions live under **Translation** as well:
*Send context action* (`/admin/tmgmt/send-context-action`, gated by the *Send context
smartling* permission) and *Approve download by job items*
(`/admin/tmgmt/approve-action-download-by-job-items`).

## How to use it

Once a Smartling provider is configured, you translate content the normal TMGMT way:
select content, create a translation **job**, and pick your Smartling provider as the
translator. The module exports the job, uploads it to Smartling, and — via cron, a
callback, or an on-demand action — brings the finished translation back into the job.
Two permissions from this module control the extras: **Send context smartling**
(upload the rendered page as visual context; note this involves automatically
switching user during upload, so grant it only to trusted roles) and **See smartling
messages** (view Smartling health/status messages).

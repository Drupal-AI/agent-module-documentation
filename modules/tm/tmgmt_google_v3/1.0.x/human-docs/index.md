# Google V3 Translator — manual setup guide

**Google V3 Translator** (`tmgmt_google_v3`) is a machine‑translation provider for
the Translation Management Tools (TMGMT) suite. It sends TMGMT translation jobs to
the **Google Cloud Translation v3** API, so you can auto‑translate Drupal content —
nodes, taxonomy terms, and other entities — as a first pass inside your normal
TMGMT review workflow. It also supports Google **glossaries** per target language,
so domain terminology stays consistent.

The module adds a single TMGMT **translator plugin** called **Google V3**. You use
it by creating a TMGMT *Translator* (provider) that selects this plugin and supplies
a few settings: a **Location** (default `global`), your Google Cloud **Project ID**,
and a **Google API Credentials** JSON key file that you upload. Optionally you can
map each Drupal language to a Google glossary id. Once configured, TMGMT routes jobs
through this provider: it translates each text segment via Google (chunking very
long fields automatically), applies a glossary where one is mapped, and writes the
result back onto the job. It implements TMGMT's continuous‑translator interface, so
it also works with continuous jobs that translate content automatically as it
changes, and it gracefully pauses items if Google's quota is exhausted.

The module has no admin settings page of its own, no permissions, and no Drush — all
configuration lives on the TMGMT translator entity you create. To work, it needs a
Google Cloud project with the Translation API enabled and a service‑account key, and
your site must have the **private file system** configured, because the credentials
key is stored there. It depends on **TMGMT** and the `google/cloud-translate` PHP
library.

> **A note on secrets:** the Google service‑account JSON key is a credential.
> Because the upload requires the **private** filesystem, the key is kept out of the
> public web root. See [Configuration](configuration/index.md) for the setup and the
> private‑files requirement.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   Google Cloud Translate library) and enable the module.
2. [Configuration](configuration/index.md) — create and configure the Google V3
   translation provider, including credentials, project id, and glossaries.

## Where it lives in the admin menu

There's no dedicated settings page. You create and configure the provider at
**Configuration → Regional and language → Translation providers**
(`/admin/tmgmt/translators`), part of TMGMT.

## How to use it

The short path: make sure private files are enabled, install the module with
Composer, then at **Configuration → Regional and language → Translation providers**
add a translator, choose the **Google V3** plugin, enter your project id and
location, upload your service‑account JSON key, and click **Connect** to verify.
Once saved, pick this provider when you create TMGMT jobs. Full details, field by
field, are in [Configuration](configuration/index.md).

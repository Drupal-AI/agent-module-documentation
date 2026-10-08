# TMGMT Ignore Fields — manual setup guide

**TMGMT Ignore Fields** (`tmgmt_ignore_fields`) is a small companion to the
[Translation Management Tool](https://www.drupal.org/project/tmgmt) (TMGMT) that
lets administrators globally exclude specific fields from translation jobs. When
TMGMT builds a job it normally gathers *every* translatable field of an entity and
sends them all to the translator — but some fields simply should not go: an
internal reference code, a value that is identical in every language, a
machine‑oriented string, or a field whose "translation" would only ever be a copy
of the original.

This module adds the configuration to leave those fields out. You name the fields
to ignore once, and TMGMT skips them whenever it assembles a job, so the job
contains only what genuinely needs translating. It can exclude both base fields
and custom fields across any content type, and it can even skip referenced
entities such as paragraphs — all with a single click per field. The pay‑off is
practical: fewer words sent to your translator means less translator effort and,
on a paid translation service, real money saved.

It is a focused efficiency tool rather than a change to how translation works. The
workflow is unchanged; each job is simply smaller. The one thing worth checking
after you configure it: an ignored field is **silently absent** from jobs, so an
over‑broad choice shows up later as *missing translations* rather than as an
error. After adjusting the ignore list, confirm you have not accidentally excluded
something that really does need translating. The module depends on TMGMT and its
content source `tmgmt_content` — the pairing that produces the field lists it
filters — is actively maintained, and is covered by Drupal's security advisory
policy.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose which fields to exclude.

## Where it lives in the admin menu

Its settings form sits at **Configuration → Content authoring → TMGMT Ignore
Fields** (`/admin/config/content/tmgmt-ignore-fields`, the
`tmgmt_ignore_fields.settings` route). That is where you pick the fields to leave
out of translation jobs.

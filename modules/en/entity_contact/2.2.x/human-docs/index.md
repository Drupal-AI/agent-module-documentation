# Entity Contact — manual setup guide

**Entity Contact** (`entity_contact`) is a stripped-down, **fully fieldable**
reimplementation of Drupal core's Contact module. Core contact forms are not real
fieldable entities and their submissions are not stored; Entity Contact fixes both.
Each contact form is a configuration entity (`entity_contact_form`) and each
submission is a content entity (`entity_contact_message`) you can add fields to — so
you can attach exactly the fields you want, list and store submissions, expire old
ones, and process each submission through pluggable **submission handlers**.

Unlike core, it does not force name and e-mail fields on you, and it makes storing
submissions optional per form (you can handle a submission and discard it, or keep
it). Each form gets a public submission page generated automatically, gated by a
**dedicated** `access entity contact form` permission — importantly, *not* the broad
`access content`. A configurable flood limit and interval throttle abusive
submitters, and you can optionally store the submitter's IP address (a GDPR-aware
toggle). Cron purges expired submissions. Each new submission also records UTM/GCLID
marketing parameters and the submission URL captured from the request or referer.

The module ships several optional submodules that extend it — most notably
**Entity Contact Email**, which sends admin-configured mails on submission.
Recipients are static addresses you configure, plus optionally the value of a
message field you explicitly choose (validated as an e-mail address); subject and
body are admin templates run through Token and the core mail manager. Other
submodules add embedding on an arbitrary route, submission export (including XLSX),
Search API indexing, and an example handler. It requires **Drupal 10.1 or 11**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and any submodules, and grant the permissions.
2. [Configuration](configuration/index.md) — create a contact form, add fields,
   expose it, set flood limits, and wire up e-mail.

## Where it lives in the admin menu

Contact forms are managed at **Content → Entity contact**
(`/admin/content/entity-contact`), which is the form collection
(`entity.entity_contact_form.collection`). From there you add forms, add fields to
the message entity, and manage submissions.

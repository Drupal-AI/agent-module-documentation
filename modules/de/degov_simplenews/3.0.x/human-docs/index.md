# deGov Simplenews — manual setup guide

**deGov Simplenews** (`degov_simplenews`) extends the
[Simplenews](https://www.drupal.org/project/simplenews) newsletter module with a
set of GDPR‑oriented features for your subscription forms. It adds a required
privacy‑policy consent checkbox, captures the subscriber's forename and surname,
and records — and later displays — the moment consent was given.

Running a newsletter in Europe (or anywhere with similar data‑protection rules)
means you need to show subscribers a privacy policy, get their explicit consent
to process their personal data, and be able to demonstrate later that consent was
given. Plain Simplenews does not do this out of the box. deGov Simplenews fills
that gap: it injects a **required** consent checkbox that links to a
privacy‑policy page, adds **Forename** and **Surname** fields to the signup form,
and stores the consent timestamp so it appears on the subscriber's details page
for your records. It works **per language** — each enabled language needs its own
privacy‑policy page and consent message — and, as a safeguard, it **hides the
signup form entirely** if no privacy policy has been defined for the current
language (administrators see an error explaining why).

It depends on the Simplenews module, which must be installed and set up first.
The module was originally built as part of the deGov distribution and later spun
off as its own project.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and its Simplenews dependency).
2. [Configuration](configuration/index.md) — point it at a privacy‑policy page
   and consent message per language.

## Where it lives in the admin menu

Its settings form is at **Configuration → deGov → Simplenews**
(`/admin/config/degov/simplenews`), gated by the **administer simplenews
settings** permission. That is where you choose the privacy‑policy node and
consent message for each language.

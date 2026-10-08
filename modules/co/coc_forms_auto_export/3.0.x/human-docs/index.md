# Webform Auto Exports — manual setup guide

**Webform Auto Exports** (`coc_forms_auto_export`) automatically exports your
**Webform** submission results on a schedule and delivers them by **email**
and/or to an **SFTP** location — no more logging in to download a CSV by hand.
For each form you can turn automatic export on independently, so you get precise
control over which forms export, where their results go, and how often.

It generates CSV exports of submissions and can email them to a nominated
address (with a configurable subject and body) and/or transfer them to a defined
SFTP location. You can scope each export to the previous day, week, month, or
year; schedule it to start now or at a future date/time; have it stop on a
specific date or run indefinitely; choose which columns to include; and set the
delimiters for single- and multi-value fields.

Because it exports form submissions, the files it produces frequently contain
**personal data** — names, email addresses, messages, uploaded files. Treat the
export destination accordingly: make sure it is access-controlled and **not
web-accessible**, store it securely, and handle it in line with your
data-protection and retention obligations. This is the one caveat worth keeping
front of mind with this module.

It depends on the **Webform** and **Webform UI** modules. The SFTP delivery
option additionally needs the `phpseclib/phpseclib` PHP library. Configuration is
per-form: it lives on each Webform's own Results → Downloads page rather than in
a single site-wide settings form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, add the
   phpseclib library for SFTP, and enable the module.
2. [Configuration](configuration/index.md) — where the per-form export settings
   live and what each option does.

## Where it lives in the admin menu

There is no central settings page. You configure automatic export on each form
at **Structure → Webforms → *(your form)* → Results → Downloads → Automatic CSV
Export**.

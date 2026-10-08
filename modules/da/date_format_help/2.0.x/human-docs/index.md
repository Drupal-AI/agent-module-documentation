# Date/Time Format Help — manual setup guide

**Date/Time Format Help** (`date_format_help`) is a small quality‑of‑life module
for site builders. When you create or edit a custom date format in Drupal, it adds
a friendly, inline copy of PHP's `date()` format‑character reference right on the
settings page — so you can see at a glance whether it's `g` or `H` you want, or
whether `m` means month or minutes, without leaving to look it up in the PHP
manual.

That's the whole module. It works the moment you enable it — there is nothing to
configure. It has no effect on your content, adds no front‑end behaviour, and is
purely an admin‑page documentation helper. It supports Drupal 10 and 11 and has no
module dependencies.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no configuration page** — the help text appears automatically on the
date‑format admin pages once the module is enabled.

## Where it lives in the admin menu

The module doesn't add a menu item of its own. Its help reference appears inline
on the date/time format pages under **Configuration → Regional and language →
Date and time formats** (`/admin/config/regional/date-time`) when you add or edit
a format.

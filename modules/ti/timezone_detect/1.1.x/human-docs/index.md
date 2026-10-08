# Timezone detect — manual setup guide

**Timezone detect** (`timezone_detect`) works out each logged-in user's real
timezone in their browser and saves it to their Drupal account — so dates, times,
and "posted X hours ago" style timestamps show up in every user's own local time
without anyone having to pick their timezone by hand.

It does this entirely client-side, with no geolocation service or API key. On page
load for authenticated users, a small bundled JavaScript library
(jsTimezoneDetect / `jstz`) figures out the browser's timezone. If that differs from
what the account currently has, the browser sends it back to Drupal over a
CSRF-protected AJAX request. Drupal checks the value is a genuine IANA/Olson
timezone identifier and, if so, stores it on the user's account.

You choose *when* it updates via a simple setting: only set it on login when the
user's timezone is still empty (the recommended, least-intrusive mode), overwrite it
on every login, or keep it current on any page as a traveling user's timezone
changes. It's ideal for globally distributed audiences, sites where the default user
timezone was left empty, and anywhere you'd rather not ask users to configure their
timezone during registration.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — choose the detection mode, the logging
   toggle, and the regional setting that makes the recommended mode work.

## Where it lives in the admin menu

The settings form is at **Configuration → Regional and language → Timezone detect**
(`/admin/config/regional/timezone_detect`), gated by the **Administer site
configuration** permission. The module defines no permissions of its own; the AJAX
route that saves the timezone simply requires the user to be logged in.

## How to use it

Enable the module and it starts working immediately in its default mode — setting a
user's timezone on login when they don't already have one. For that mode to actually
fire, your site's default user timezone should be configurable and empty; see
[Configuration](configuration/index.md) for that regional setting and the other
modes.

# BurnAfter — manual setup guide

**BurnAfter** (`burnafter`) gives your site "burn after reading" content: short-
lived items that disappear on their own after they have been viewed a set number
of times, or after a period of time. Each item holds a body of text and is served
at a hard-to-guess URL built from a random UUID — you share that link with one
person, and once the item is over its view limit or past its expiry it is deleted.

It is the safer alternative to emailing a password, an API token, or a sensitive
note in plain text: instead of sending the secret itself, you send a one-time
link that self-destructs. Content can optionally be **encrypted at rest** using
the contrib [Encrypt](https://www.drupal.org/project/encrypt) module and an
encryption profile you configure.

Access is controlled two ways at once: viewing an item needs both the *view
burnafter entity* permission **and** knowledge of the random UUID in the link.
Content is rendered as plain text (so it cannot inject markup), and expired or
over-viewed items are cleaned up on cron.

Note that the cleanup that deletes an over-viewed or expired item runs **on
cron**, not at the exact moment of the final view.

This guide is written for a **human** clicking through the admin UI. If you want
a terse, token-cheap reference for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and Encrypt, if
   you want at-rest encryption) with Composer and enable it.
2. [Configuration](configuration/index.md) — the settings form, including the
   encryption option.

## Where it lives in the admin menu

BurnAfter's settings form is at **Configuration → System → BurnAfter**
(`/admin/config/system/burnafter`), behind the *administer burnafter settings*
permission.

## How to use it

- **Create an item:** go to `/burnafter/add` (requires the *create burnafter
  entity* permission), enter the body, and save. You get a link containing a
  random UUID.
- **Share the link:** send `/burnafter/{uuid}` to the recipient. Viewing requires
  the *view burnafter entity* permission.
- **Automatic cleanup:** each view increments the view count; once an item is over
  its limit or past its time window, cron removes it.

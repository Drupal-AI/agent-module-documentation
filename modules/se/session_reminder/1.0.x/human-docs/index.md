# Session Reminder — manual setup guide

**Session Reminder** (`session_reminder`) shows a friendly modal warning shortly
before a user's Drupal session cookie is due to expire, giving them a button to
extend the session so they don't get silently logged out and lose unsaved work. It
is the "your session is about to expire — stay signed in?" prompt you see on banking
and admin sites, brought to Drupal.

The reminder is both a usability nicety and a security-awareness touch: the user
knows their session is ending and can consciously decide to extend it. When they
click the extend button, the module updates the session cookie's expiration based on
your site's `cookie_lifetime` value. Which roles see the modal, and how long before
expiry it appears, are up to you — and you can restyle the modal to match your site.

The module depends on core **User** and works once enabled and configured. It reads
the session lifetime from your site's `services.yml`; it does not itself change how
sessions actually time out (core still controls that) and it has no access-control
role. One important prerequisite: your `gc_maxlifetime` must not be `0` — if session
storage never expires, the modal can't work, and the module will warn you on its
settings page. Supports Drupal 9, 10 and 11.

This guide is written for a **human** setting the module up through the admin UI. If
you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the warning threshold, choose which
   roles see the modal, and style its appearance.

## Where it lives in the admin menu

After enabling, configure the module at **Configuration → People → Session
Reminder** (`/admin/config/session-reminder`). Once configured, authenticated users
in the selected roles automatically see the reminder modal when their session nears
expiry — there is nothing for them to switch on.

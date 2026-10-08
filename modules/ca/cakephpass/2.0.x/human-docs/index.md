# CakePhPass — manual setup guide

**CakePhPass** (`cakephpass`) is a login-compatibility shim for sites that have
migrated their users out of a CakePHP application and into Drupal. When users
are moved across, their passwords come with them as CakePHP-format password
hashes — which Drupal's own login check does not understand. CakePhPass teaches
Drupal to recognise those legacy hashes so the migrated users can keep logging
in with their existing passwords.

It works by swapping Drupal's core `password` service for its own version. On
each login attempt it first lets Drupal's normal password check run; only if
that fails *and* the stored hash is a CakePHP-format one (marked with a `$C$`
prefix) does it fall back to verifying the password the CakePHP way. So it never
weakens logins for ordinary Drupal accounts — it only kicks in for the migrated
ones, and only when you have explicitly switched it on.

There is no admin screen, no block, and no permission. All of its behaviour is
driven from a small settings block you add to your site's `settings.php` file,
where you tell it the CakePHP salt and hash type to use. If that block is
missing or disabled, the module does nothing and normal Drupal hashing applies.

A note on security: CakePhPass intentionally supports old, weak algorithms such
as SHA1 and MD5, because that is what the legacy accounts were hashed with —
this is unavoidable when accepting migrated hashes. The recommended practice is
to force a password reset for migrated users after go-live, so their accounts
are re-hashed with Drupal's modern algorithm and you can retire the shim.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the `settings.php` block that
   turns verification on, with the salt and hash type.

## Where it lives

CakePhPass has no admin UI. It is configured entirely in `settings.php` (see
[Configuration](configuration/index.md)). Enabling the module registers a
service provider that replaces the core `password` service; uninstalling it
reverts to Drupal core's password handling.

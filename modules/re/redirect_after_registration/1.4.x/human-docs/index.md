# Redirect After Registration — manual setup guide

**Redirect After Registration** (`redirect_after_registration`) sends a user to a page
you choose the moment they finish registering, replacing Drupal's default
post-registration destination. It's the simple fix for "after someone signs up, take
them to our welcome / onboarding / pending-approval page" — no custom code, just one
setting.

Under the hood it's a tiny piece of glue: it adds a submit handler to the core user
registration form that reads one config value and redirects there. By default the
target is `/user/login`, and you change it on a small settings form. The redirect only
fires for genuine self-registration (an anonymous visitor signing up), unless you
explicitly opt in to also redirect accounts an administrator creates.

The redirect target is restricted to **on-site paths** — the module builds the URL
with the `internal:` scheme, so it can't be pointed at an external site, which keeps it
safe from open-redirect abuse. It has no dependencies beyond Drupal core, no
permissions of its own (the settings form uses core's *Administer site configuration*),
and no plugins or Drush commands.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the redirect path and the admin-created
   accounts option.

## Where it lives in the admin menu

The settings form sits under **Configuration → System → Redirect After Registration**
(`/admin/config/redirect_after_registration/config`), gated by the core **Administer
site configuration** permission.

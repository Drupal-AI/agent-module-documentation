# Acquia Purge Varnish — manual setup guide

**Acquia Purge Varnish** (`acquia_purge_varnish`) clears the **Varnish cache in
front of an Acquia Cloud environment** — from an admin form or from Drush — with
controls that keep one environment separate from another. On Acquia Cloud, Varnish
sits between visitors and Drupal, so a content change Drupal already knows about
stays invisible until Varnish is told to drop the old copy.

The usual way to do that is the full **Purge** module stack, which is powerful but
involved. This module is the narrower, more direct option: an API client for
Acquia's purge endpoint, a form to trigger a purge, and **Drush commands** so
purging can be baked into a deployment script.

The **per-environment control is the part that matters**. A purge fired at the
wrong environment is either useless (you cleared dev while prod stays stale) or
disruptive (you cleared prod at a traffic peak, and every request now falls through
to origin). Making the environment explicit — in configuration and in the command —
is what stops a script written for staging from emptying production's cache. The
one permission it adds, *administer acquia purge varnish*, is access-restricted on
purpose: a purge has real production consequences, it is not an ordinary settings
change.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (PHP 8.1), enable
   it, and grant the purge permission.

## Where it lives in the admin menu

Once enabled, the module adds a **purge form** (`acquia_purge_varnish.form`) under
Drupal's configuration, reachable by users who hold the *administer acquia purge
varnish* permission. Assign that permission at **People → Permissions**
(`/admin/people/permissions`).

## How to use it

**From the admin form.** Open the purge form, confirm which **Acquia environment**
it is pointed at, and trigger the purge — for a specific path an editor reports as
stale, or for the environment after a release. Checking the environment before you
click is the habit that avoids clearing the wrong cache.

**From Drush.** The module ships Drush commands so you can script cache
invalidation into a release pipeline — purge after a deployment, purge after a
content import — or reach for it during incident response, where clearing the cache
is usually the first thing anyone tries. Because the environment is explicit in the
command, a staging pipeline will not accidentally purge production.

**Settings.** The per-environment configuration lives on the same form; set the
environment details there so both the form and the Drush commands target the right
Acquia environment.

**Testing.** A bundled submodule, `acquia_purge_varnish_test`, is available for
testing the integration — you do not need it in normal operation.

# LocalGov Content Lock — manual setup guide

**LocalGov Content Lock** (`localgov_content_lock`) sets up the
[Content Lock](https://www.drupal.org/project/content_lock) module for the
**LocalGov Drupal** distribution (the shared Drupal platform used by UK councils).
Content Lock solves the oldest collaborative‑editing failure there is — two people
editing the same page, one silently overwriting the other — with **pessimistic
locking**: whoever opens the edit form holds the lock until they save or release
it.

Configuring that well is really the whole job, which is why a distribution‑specific
module exists. When enabled, this module:

- enables the **Content Lock** and **Content Lock Timeout** modules;
- turns on content locking for **all enabled content types**;
- adds a link to the content‑lock view on the content admin page and in the admin
  menu; and
- leaves the default lock timeout at **30 minutes** (which you can change).

For LocalGov Drupal the context makes locking especially valuable: councils have
large editorial teams, a lot of content several people have a legitimate reason to
touch, and service pages where a silent overwrite has real consequences for a
resident trying to find out something like when their bins are collected.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (Content Lock comes with it).

This module ships ready‑made configuration rather than its own settings form. The
handful of settings you may want to review live on the Content Lock module's own
pages — see "How to use it" below.

## Where it lives in the admin menu

Once enabled, a link to the content‑lock view is added to the content admin page
and the admin menu, so you can see what is currently locked. The lock **timeout**
is configured on Content Lock's own form at
`/admin/config/content/content_lock/timeout` (default 30 minutes).

## How to use it

Enable the module and locking is active for all content types immediately — there
is nothing you *must* configure. Two things are worth reviewing for your team,
though:

- **Who may break a lock — check this first.** Someone has to be able to release a
  stale lock (for example, from a colleague who opened a page and then went to
  lunch). If that ability is administrator‑only on a team of forty editors, people
  will wait or edit around the lock. Make sure whoever can be reached quickly has
  the permission to break a lock, and note that the module records who did.
- **The timeout.** The default is 30 minutes, changeable at
  `/admin/config/content/content_lock/timeout`. Set too long and pages stay locked
  by people who have moved on; set too short and locks never prevent anything.

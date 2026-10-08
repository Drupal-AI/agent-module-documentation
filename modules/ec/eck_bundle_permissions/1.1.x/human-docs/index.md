# ECK Bundle Permissions — manual setup guide

**ECK Bundle Permissions** (`eck_bundle_permissions`) gives
[Entity Construction Kit](https://www.drupal.org/project/eck) (ECK) entities
**per‑bundle** permissions, so a role can be allowed to work with one ECK bundle
without being allowed to work with all of them.

Out of the box, ECK's permissions are per entity *type*: "edit any Event entity"
covers every bundle of that type. On a site that uses a single ECK entity type to
model several unrelated things — say events, sponsors and resources, all bundles
of one type — that's too coarse, and the usual workaround (a separate entity type
per bundle) defeats the purpose of bundles. This module supplies the missing
granularity so you can, for example, let a team edit just the "resources" bundle.

The module requires no configuration — you enable it and then grant the new,
finer permissions to your roles on the permissions page. It depends only on ECK
and supports Drupal 8, 9, 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside ECK.

There is **no configuration page** for this module. It adds permissions you grant
on the standard permissions page; the model is described below.

## The permission model

For each ECK entity type and bundle, the module generates these permissions:

- **create** `{entityType}` entities of bundle `{bundle}`
- **edit all** `{entityType}` entities of bundle `{bundle}`
- **delete all** `{entityType}` entities of bundle `{bundle}`
- **view all** `{entityType}` entities of bundle `{bundle}`

For entity types that have an author field, it also generates the "own" variants:

- **edit own** `{entityType}` entities of bundle `{bundle}`
- **delete own** `{entityType}` entities of bundle `{bundle}`
- **view own** `{entityType}` entities of bundle `{bundle}`

Two things are worth knowing. First, these permissions are **generated at
runtime** (through a permission callback) rather than declared in a static file —
so they only appear once the module is enabled, and you won't find them by
searching a YAML file. Second, **a new bundle is closed by default**: adding an
ECK bundle creates new permissions that no role holds yet, so nobody can act on
the new bundle until you grant them. That's the safe direction, but it means a
freshly added bundle can look "broken" (no one can create or edit it) until you
assign its permissions — that's the first thing to check.

## Where it lives in the admin menu

ECK Bundle Permissions adds no admin page of its own. Its permissions appear on
the standard **People → Permissions** page (`/admin/people/permissions`), grouped
with the ECK permissions. ECK entity types and bundles themselves are managed
under ECK's admin pages.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to **People → Permissions**.
3. Find the per‑bundle permissions for your ECK entity type(s) and grant the
   appropriate create/edit/delete/view (and "own" where available) permissions to
   each role.
4. Whenever you add a new ECK bundle later, return here and grant its new
   permissions — until you do, no role can act on that bundle.

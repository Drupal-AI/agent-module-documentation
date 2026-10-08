# Group Sites — manual setup guide

**Group Sites** (`group_sites`) turns a single Drupal installation into several
microsites, using the [Group](https://www.drupal.org/project/group) module as the
dividing line. It takes a Group supplied by a *context provider*, makes that Group
the site's global context, and then applies an access policy based on whether a
Group was found — the usual policy being "deny access to everything outside this
Group".

The problem it solves is running several sites without running several Drupal
installs. Point a context provider at, say, the current domain so it maps each
domain to a Group; Group Sites then denies access to every *other* Group's content.
Each domain behaves like its own website, while they all share one codebase, one
user table, and one admin.

The design is deliberately open at both ends. Two tagged‑service interfaces let a
developer supply custom behaviour — one for what happens when no Group is detected,
and one for what happens when a Group is found. Out of the box it ships a
"deny all" policy for the no‑Group case (the default and the recommended one) and a
single policy that disables all but the active Group for the found case. The README
points to the [Flexible Permissions](https://www.drupal.org/project/flexible_permissions)
module for anyone writing their own.

**Admin mode is the part to understand before you grant anything.** Toggled from
the toolbar, it makes the site behave "as if Group Sites wasn't even installed" —
which means it *switches off the access scoping that is the entire point of the
module*. That's genuinely needed for site building, and it's correctly gated behind
its own **use group_sites admin mode** permission. But whoever holds that
permission can see and edit *every* microsite's content, so it belongs to a named
administrative role and nothing else.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it
   alongside Group, and add a context provider.
2. [Configuration](configuration/index.md) — the settings page, admin mode, and
   choosing your access policies.

## Where it lives in the admin menu

Group Sites' settings form is at **Administration → Groups → Sites → Settings**
(`/admin/group/sites/settings`), reached with the **configure group_sites**
permission. Admin mode is toggled from the admin toolbar.

## How to use it

The recommended pattern is domain‑based microsites: install a context provider
that derives a Group from the active domain — **`group_context_domain`** is the
recommended one — and let Group Sites deny access to every other Group. The README
explicitly **discourages** the built‑in "Group from URL" context in favour of a
real context provider like that one. You can equally base your Group context on a
path prefix, a language, or anything else a context provider can supply; the module
doesn't care what the source of selection is.

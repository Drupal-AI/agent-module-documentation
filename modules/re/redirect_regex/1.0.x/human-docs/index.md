# Redirect Regex — manual setup guide

**Redirect Regex** (`redirect_regex`) extends the
[Redirect](https://www.drupal.org/project/redirect) module so a single redirect
can match a whole *family* of source paths with a **regular expression**, rather
than only one exact path. It's the tool you reach for when a legacy URL structure
needs to move wholesale — for example, sending every `blog/{number}/…` URL to a
new archive, or migrating `legacy/{id}` paths to `/migrated/{id}` by substituting
the captured id into the destination.

Under the hood it uses ordinary Redirect entities — nothing new to learn about
storage or exports. It works by decorating Redirect's repository service so that
regex redirects are matched in addition to the normal exact‑path ones, which
means all existing redirects keep working unchanged and the feature is compatible
with GraphQL through the Redirect module. A redirect is treated as a regex when
you tick a **Regular expression** checkbox on the standard redirect form.

Two things are worth understanding before you write patterns, because a regular
expression is powerful enough to cause trouble if written carelessly:

- **Catastrophic backtracking (ReDoS).** A poorly written pattern can be slow to
  evaluate against crafted request paths, effectively a self‑inflicted denial of
  service. Write **anchored, efficient** patterns.
- **Open redirects.** Because destinations can include captured groups and are
  emitted as trusted redirect responses (which permit external URLs), avoid any
  destination template where an attacker‑influenced capture could form an
  external address. Keep the host portion of a destination fixed and anchor your
  patterns.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Redirect.
2. [Configuration](configuration/index.md) — how to create a regex redirect,
   substitute captured groups, and write safe patterns.

## Where it lives in the admin menu

Redirect Regex adds no page of its own. You create regex redirects on the normal
Redirect screens under **Configuration → Search and metadata → URL redirects**
(`/admin/config/search/redirect`).

# Sub-pathauto — manual setup guide

**Sub-pathauto** (`subpathauto`) makes your URL aliases work for *sub-paths* —
the child paths that hang off an aliased page. Out of the box Drupal only aliases
whole paths, so if you have aliased `/node/1` to `/about-us`, the alias covers
`/about-us` but does nothing for `/about-us/edit`, `/about-us/delete`, or
`/about-us/revisions`. Those child paths still only answer to the raw system path
(`/node/1/edit`). Sub-pathauto closes that gap: it teaches Drupal to resolve
`/about-us/edit` back to `/node/1/edit`, and to generate the pretty
`/about-us/edit` form when it builds links.

It does this quietly in the background. The module registers a single path
processor that, on every incoming request that isn't already aliased, trims the
last segment (or several segments) off the URL, checks whether the shortened
parent path is an alias, and — if it is — rebuilds the full internal path. The
same thing happens in reverse when Drupal renders links, so contextual "Edit" and
"Delete" links, view tabs, pagers, and exposed-filter links on an aliased page all
point at the pretty URL instead of the numeric node path. It also understands
language-prefixed URLs (`/de/ueber-uns/bearbeiten`) on multilingual sites, and can
optionally lean on the [Redirect](https://www.drupal.org/project/redirect) module
so that sub-paths of an *old* alias keep working.

The module works as soon as you enable it, using a sensible default. A small
settings form lets you cap how deep it looks (a performance lever on large sites)
and turn on redirect support. Its only dependency is core's Path alias module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form (search depth and
   redirect support), field by field.

## Where it lives in the admin menu

There is nothing to place or theme — the behavior is automatic site-wide once the
module is on. Its settings form sits at **Configuration → Search and metadata →
Sub-path settings** (`/admin/config/search/subpathauto`), and is guarded by core's
**Administer URL aliases** permission.

## How to use it

Alias a page as you normally would (by hand under **Configuration → Search and
metadata → URL aliases**, or automatically with
[Pathauto](https://www.drupal.org/project/pathauto)). Once Sub-pathauto is
enabled, every child path of that alias just works — visit `/about-us/edit` and
you land on the node edit form, bookmark `/blog/my-post/page/2` and the pager
follows the pretty URL. You don't create any per-page setting; the module applies
to every alias on the site.

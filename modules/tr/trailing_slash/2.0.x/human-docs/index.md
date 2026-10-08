# Trailing Slash — manual setup guide

**Trailing Slash** (`trailing_slash`) appends a trailing slash to the URLs you
choose — for example turning `/about` into `/about/` — as Drupal generates them,
primarily for SEO and URL consistency. You decide which URLs get a slash: match them
by **path pattern** (with wildcards, e.g. `/blog/*`) and/or by **content-entity
bundle** (e.g. every `article` node), all from one settings form.

It works entirely on **outbound** URL generation: when Drupal builds a link to a
qualifying page, it comes out with the slash. It sensibly leaves things alone that
should not be slashed — the front page, admin and `/devel` paths, and file-like URLs
(any final segment containing a dot, such as `.../logo.png`) — and it is idempotent,
so a URL that already ends in a slash is untouched. It also fixes a multilingual
edge case where the front-page URL loses its slash after a language prefix like
`/en/`.

> **Note — this is outbound only.** Trailing Slash changes how links are *generated*;
> it does **not** add an inbound redirect. A visitor who requests `/about` is not
> redirected to `/about/`. If you also want inbound canonicalization, pair it with a
> web-server rule or the [Redirect](https://www.drupal.org/project/redirect) module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

Configuration is covered in *How to use it* below.

## Where it lives in the admin menu

Its settings form is at `/admin/config/trailing-slash/settings`, gated by the
module's own **Administer trailing slash** permission.

## How to use it

1. Log in as a user with the **Administer trailing slash** permission and go to
   `/admin/config/trailing-slash/settings`.
2. Fill in the fields:

| Field | Default | What it does |
|-------|---------|--------------|
| **Enabled** | Off | The master switch. While off, the module does nothing. Turn it on to activate slashing. |
| **List of paths with trailing slash** | empty | One path pattern per line, each starting with `/`. Wildcards are allowed, e.g. `/about`, `/blog/*`, `/user/*`. Matching URLs get a trailing slash. |
| **Enabled entity types** | none | A nested set of checkboxes: one section per content entity type, with a checkbox per bundle. Tick a bundle to slash the URLs of that bundle (e.g. tick *Article* under *Content* to slash every article node). |

3. Save. Changes apply to newly generated links immediately.

A URL gets a slash when the feature is **enabled** and the path **either** matches
one of your path patterns **or** resolves to a content entity whose bundle you
ticked — and it is not the front page, an admin/`/devel` path, or a file-like URL.

### Permission

- **Administer trailing slash** — controls who can change these rules. It is a
  restricted permission; grant it only to trusted site administrators.

### Tips

- **Roll out gradually** by adding one path pattern at a time and checking the
  generated links.
- **Combine** path patterns and entity-bundle rules freely in one configuration.
- **Match your redirect strategy** — if a web-server rule or the Redirect module
  canonicalizes inbound URLs to trailing slashes, this module keeps Drupal's
  generated links consistent with it.

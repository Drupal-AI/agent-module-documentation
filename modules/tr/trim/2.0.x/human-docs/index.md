# Trim — manual setup guide

**Trim** (`trim`) automatically strips leading and trailing whitespace from every
text value submitted through a content entity form — and it does so **before
validation**, so a stray space after a number, or an accidental space in a required
field, no longer causes an error or gets saved. Editors get a friendlier experience
where accidental spaces simply "just work", and your content stays clean.

It is about as simple as a module gets: **no settings form, no permissions, no
plugins, and no Drush commands**. Enabling it is the entire setup. It works on any
content entity form — nodes, users, taxonomy terms, media, comments, and custom
content entities — trimming each submitted string (descending into multi-value and
nested fields) right before Drupal validates the form. Configuration entity forms
(Views UI, field settings, and the like) are deliberately left untouched, so an
intentional space-keyed option is never altered.

A couple of things to know: Trim only affects input that passes through Drupal's
Form API. It does **not** touch values written by the REST API, migrations, or
direct programmatic `$entity->save()` calls. And native HTML5 browser validation
(on `type="number"`, `type="email"`, etc.) still runs first in the browser. To make
sure Trim runs before every other validator, its install step sets the module's
system weight high (1001) — a detail you normally never need to think about.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it. That is all there is to it.

## How to use it

There is nothing to use or configure — Trim works silently in the background. Once
enabled, every content entity add/edit form trims surrounding whitespace from its
text values as they are submitted. There is no per-field, per-bundle, or site-wide
toggle: it is all-or-nothing and applies to all content entity forms.

To stop trimming, uninstall the module:

```bash
drush pmu trim -y
```

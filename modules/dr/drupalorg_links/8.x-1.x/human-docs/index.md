# Drupal.org Links — manual setup guide

**Drupal.org Links** (`drupalorg_links`) is a small display module that provides
field formatters for turning plain numeric field values into proper links to
drupal.org. If you keep a drupal.org comment id, node id, or user id in a field,
this module renders it as a clickable link to the matching page on drupal.org
instead of showing a bare number.

It is handy for directories, community sites, and documentation sites that
catalogue drupal.org projects, contributors, or discussions. The module has **no
configuration page of its own** — like most formatter modules, you set it up
entirely on a field's *Manage display* tab.

It ships three formatters, all of which accept integer, decimal, or string values
and use the integer value of the number:

- **Comment link** — renders the value as `https://www.drupal.org/comment/[VALUE]`.
- **Node link** — renders the value as `https://www.drupal.org/node/[VALUE]`.
- **User link** — renders the value as `https://www.drupal.org/user/[VALUE]`.

Drupal.org Links supports Drupal 8, 9, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — it has no settings form. The
setup happens on your field's display, described in "How to use it" below.

## Where it lives in the admin menu

Drupal.org Links adds no admin page of its own. You use it from **Structure →
Content types → *(your content type)* → Manage display** (or the *Manage display*
tab of any other fieldable entity, such as a taxonomy vocabulary or user).

## How to use it

1. Add a field that stores the drupal.org id you want to link to — for example an
   integer field holding a node id, comment id, or user id.
2. Go to the entity's **Manage display** tab.
3. In the **Format** column for that field, choose **Comment link**, **Node
   link**, or **User link** depending on which kind of drupal.org page the number
   refers to.
4. Click **Save**. When the entity is viewed, the number now renders as a link to
   the corresponding page on drupal.org.

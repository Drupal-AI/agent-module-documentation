# Media standalone URL permission — manual setup guide

**Media standalone URL permission** (`media_standalone_url_permission`) adds a
dedicated access check to the core "standalone media URL" — the canonical
`/media/{id}` page for a media entity. With this module enabled, only roles you
explicitly grant the new **access standalone media url** permission can open that
page.

Here is the problem it solves. Drupal core has an optional *standalone media URL*
setting. Turning it on fixes a common [Linkit](https://www.drupal.org/project/linkit)
workflow — links to media keep their entity/UUID metadata, so they resolve
correctly when content is re-edited. The catch is that enabling standalone URLs also
makes every `/media/123` page **publicly viewable**, which can leak media metadata
to anonymous visitors. This module lets you keep the Linkit benefit while closing
that public window.

It works by re-adding a permission requirement onto the media canonical route via a
route subscriber — it defines no routes, forms, or settings of its own. This is a
route-level gate layered **on top of** normal media entity access; it tightens the
standalone URL, it does not loosen anything. It depends only on core **Media** and
supports Drupal 10 and 11. This module exists as a contrib workaround for core issue
[#3308515](https://www.drupal.org/node/3308515).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Media dependency.
2. [Configuration](configuration/index.md) — enable core's standalone media URL and
   grant the new permission to the right roles.

## Where it lives in the admin menu

The module has no settings page. Its one control is the **access standalone media
url** permission, which you grant at **People → Permissions**
(`/admin/people/permissions`). The related core toggle lives in your Media settings.
See [Configuration](configuration/index.md).

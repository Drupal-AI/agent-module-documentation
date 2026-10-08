# Star Rating — manual setup guide

**Star Rating** (`star_rating`) adds an Amazon-style 1–5 star rating widget to
your content. A visitor clicks a star — and can optionally leave a short comment —
and the vote is saved via AJAX without a page reload. Alongside the input widget,
the module provides blocks and an extra field that display a node's average score
and a 5-to-1 star distribution summary, so you can show aggregated ratings back to
your audience.

Ratings are stored two ways. Every vote is written to the module's own custom
`star_rating` database table. In addition, if you point the module at a
[Webform](https://www.drupal.org/project/webform), each rating is also mirrored
into a Webform submission — which is what gives you reporting, filtering, and
export through Webform's results tools. In fact the average and summary blocks read
their aggregates from the configured Webform's submissions, so configuring a
Webform is what makes the summary displays meaningful. Webform is not a hard
dependency, but the reporting/summary side of the module assumes it is installed.

The module has a settings form where you tell it which Webform and which Webform
elements hold the rating, comment, and entity id. See
[Configuration](configuration/index.md) for a field-by-field walkthrough.

The save endpoint (`/star-rating/save`) is gated by the core **View published
content** (`access content`) permission. The stored comment is not rendered by the
shipped blocks or templates.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form, field by field,
   for wiring the widget to a Webform.

## Where it lives in the admin menu

The settings form sits at **Configuration → Content authoring → Star Rating**
(`/admin/config/content/star-rating`) and requires the **Administer site
configuration** permission.

## How to use it

The rating widget, the average block, and the distribution summary block are all
**blocks**. Place them from **Structure → Block layout**
(`/admin/structure/block`) — typically the **Star Rating** input block on your
node display, with the average and summary blocks nearby. A per-node average is
also available as an extra field you can position on your content type's **Manage
display** page.

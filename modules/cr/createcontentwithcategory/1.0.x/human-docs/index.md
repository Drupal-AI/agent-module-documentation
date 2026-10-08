# Create Content with Category — manual setup guide

**Create Content with Category** (`createcontentwithcategory`) provides a block that
renders a menu-like list of links — one per **taxonomy term** — where each link opens
the node-add form with that term already selected in a chosen reference field. Clicking
"Events" starts a new node pre-tagged *Events*; clicking "News" starts one pre-tagged
*News*.

It exists to make a common editorial simplification feel natural. Often a site does not
need five different content types for five kinds of page when the structure is
identical and only the category differs — but editors find "I am creating a News page"
much clearer than "I am creating a generic page, and I'll pick a category afterwards."
This module gives you the former: category-named creation links that pre-fill the tag,
so authoring feels category-first even though there's just one content type underneath.

You configure which **content type + reference field** combinations get a block on the
module's settings page. For each combination the module reads the terms from the
referenced vocabulary and builds a themed menu of "create in category X" links. A block
is exposed for each configured combination, which you place like any other block. Under
the hood it relies on the **Prepopulate** module to seed the reference field's value
from the link's URL, so Prepopulate is a required dependency. Created nodes still go
through Drupal's normal node-add access checks.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (which brings
   Prepopulate) and enable the module.
2. [Configuration](configuration/index.md) — choose the content-type/field combinations
   and place the resulting blocks.

## Where it lives in the admin menu

The settings page is at **Configuration → Content authoring → Create Content with
Category** (`/admin/config/content/createcontentwithcategory`), reachable by users with
the **Administer taxonomy** permission. See [Configuration](configuration/index.md) for
the walkthrough.

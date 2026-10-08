# Better field descriptions — manual setup guide

**Better field descriptions** (`better_field_descriptions`) fixes two annoyances
with the little help‑text sentences that sit under form fields. First, it lets you
edit all of a bundle's field descriptions from **one screen** instead of opening
each field's settings form one at a time. Second, it renders each description
through a **theme template** in a **position you choose** — above the label, below
the label, or below the widget — so the guidance can be styled properly instead of
being unstyled fine print nobody reads.

Field descriptions are the cheapest editorial improvement most sites never make,
precisely because editing them the normal way is tedious. This module makes it
quick to review and standardise your help text before a launch, and to place that
guidance where editors will actually notice it.

The descriptions accept a limited set of HTML, so an editor can add emphasis and
links but not scripts — both the defaults and the rendered output are run through
Drupal core's restricted allowed‑tags filter. That said, the editing permission is
broad: it lets its holder change help text across **every bundle on the site**, so
treat it as an editorial‑lead permission rather than something you hand to every
editor (see [Configuration](configuration/index.md)).

It has no dependencies and supports Drupal 9.3, 10, and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, the bulk editing
   screens, and the two permissions.

## Where it lives in the admin menu

The settings form sits at **Configuration → Content authoring → Better field
descriptions** (`/admin/config/content/better_field_descriptions`), reachable by a
user with the **Administer better field descriptions settings** permission.

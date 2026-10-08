# Entity Usage Plus — manual setup guide

**Entity Usage Plus** (`entity_usage_plus`) adds a few practical enhancements on top
of the **Entity Usage** module. It gives you three things: a **Views filter for
unreferenced entities** (so you can build a list of, say, media items that nothing
links to and are safe to remove), an **operation link** on the usage tab, and an
extra list on the entity usage tab showing the **child entities referenced by** a
given entity. A common use is producing a view of media that was never used and can
be cleaned up.

The module depends on the **Entity Usage** module and reuses its permissions rather
than adding its own. It works on Drupal 10.2 and 11.

It needs a little configuration depending on which feature you want. The
child‑entities list on the usage tab is switched on from a settings page (and then
requires a cache clear). The unreferenced‑entities view is something you build
yourself: create an administrative View of, for example, media items and apply the
**"Limit to unreferenced entities"** filter. Bear in mind two things: this view is
only as accurate as Entity Usage's data, so make sure Entity Usage is configured to
capture all the relationships you care about and that you've run its batch update on
all content; and if you use revisions, Entity Usage still counts usage in previous
revisions.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside Entity Usage.
2. [Configuration](configuration/index.md) — enable the child‑entities list and
   build the unreferenced‑entities view.

## Where it lives in the admin menu

Its settings page is at
`/admin/config/entity-usage/settings/entity-usage-plus`, where you enable the
child‑entities list on the usage tab. The unreferenced‑entities feature is a Views
filter you add to a View you create yourself. Access follows Entity Usage's own
permissions.

# Views moderation state weights — manual setup guide

**Views moderation state weights** (`views_moderation_state_weights`) lets you sort
content in Views by its **editorial workflow order** instead of alphabetically.
Drupal's Content Moderation gives every workflow state a *weight* (so you can order
them draft → needs review → published), but core Views only exposes the state's
id/label — which sorts alphabetically, putting "Draft" before "Published" only by
luck of the alphabet. This module exposes each state's real configured weight to
Views, so a view can order rows by genuine workflow progression.

It adds two Views handlers to every moderated entity's data: a **field** handler and
a **sort** handler, both labelled "Moderation state weight". Add the sort to a view
and you can list a moderation queue least-progressed first (or most-progressed
first); add the field to show the numeric weight as a column. Because it uses the
weight rather than the state name, your ordering keeps working even after states are
renamed, and it automatically reflects a re-ordered workflow.

There is **no configuration UI, no permissions, and no Drush** — you just add the
field or sort in the Views UI. Under the hood the module keeps a small internal
table of state weights in sync with your workflow configuration; that table is an
implementation detail you never edit by hand. Note that the handlers only appear for
entity types that actually have a Content Moderation workflow assigned.

This guide is written for a **human** building views in the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is **no settings page**. The module's only footprint is inside the **Views
UI** (*Structure → Views*, `/admin/structure/views`): when you edit a view of a
moderated entity, a "Moderation state weight" field and sort become available to add.

## How to use it

1. Make sure the entity type your view is built on (Content, Media, etc.) has a
   **Content Moderation workflow** assigned — the handlers only show up for moderated
   entity types.
2. Edit a view at *Structure → Views* and open the display you want.
3. To **sort by workflow order**, in the **Sort criteria** section click **Add**,
   pick **Moderation state weight**, and choose the order:
   - **Ascending** — least-progressed states first (e.g. drafts at the top).
   - **Descending** — most-progressed states first (e.g. published/archived last).
4. To **show the weight as a column**, in the **Fields** section click **Add** and
   pick **Moderation state weight**.
5. Save the view.

Typical uses: an editorial dashboard sorted by workflow order so reviewers see the
least-finished content first; a moderation queue that follows the workflow rather
than the alphabet; or a status board grouped by weight. You can combine the weight
sort with other sorts (for example a "changed date" sort after it) for a stable,
predictable order. It works for **any** moderated entity type — nodes, media, and
custom entities alike.

> The internal weights table rebuilds itself from your workflow configuration and
> re-syncs whenever a workflow is saved, so a reordered workflow is reflected in your
> views automatically — there is nothing to rebuild by hand.

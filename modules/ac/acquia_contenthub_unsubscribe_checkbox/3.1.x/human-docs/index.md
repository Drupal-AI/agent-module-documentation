# Acquia Content Hub Unsubscribe Checkbox — manual setup guide

**Acquia Content Hub Unsubscribe Checkbox** (`acquia_contenthub_unsubscribe_checkbox`)
adds a small but useful control to the content edit form on a **Content Hub
subscriber** site: a checkbox that lets an editor stop a syndicated entity from
being automatically overwritten by the publisher.

On a subscriber site, incoming content is normally kept in sync with wherever it
came from — which is exactly what you want, until an editor makes a local change
they need to keep. This module surfaces the underlying "unsubscribe" flag (provided
by the `acquia_contenthub_unsubscribe` submodule) right on the edit form, relabels
it **"Check to desynchronise content"**, and wires up the save behaviour. Tick the
box and the entity is flagged so Content Hub stops auto-updating it and the change
is pushed back as an interest-list update; untick it and the entity is re-queued to
resume syncing.

It is **pure UI glue** on top of the Acquia Content Hub stack — it has no settings,
no permissions and no routes of its own. It works entirely through the existing
entity edit form, so whoever can already edit an entity can use the checkbox.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   the Content Hub modules it requires.

## Where it lives in the admin menu

There is no configuration page. The feature appears as a **checkbox on entity edit
forms** (for example the node edit form) — labelled *Check to desynchronise
content* — on a site that is set up as a Content Hub subscriber.

## How to use it

Open the edit form for a syndicated entity you want to protect from the next
syndication run. Tick **Check to desynchronise content** and save — the entity is
flagged so Content Hub no longer auto-updates it, preserving your local edits and
translations. When you want that entity to resume tracking the publisher again,
edit it, untick the box and save, and it is re-queued for updates. You can review
which entities have opted out through the Content Hub subscriber tracker.

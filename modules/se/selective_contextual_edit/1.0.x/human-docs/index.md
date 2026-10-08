# Selective Contextual Edit — manual setup guide

**Selective Contextual Edit** (`selective_contextual_edit`) sharpens Drupal's
built‑in contextual ("quick edit") links so that in‑place editing targets only
the fields you choose, rather than dropping you into a form for the whole entity.
When an editor hovers a piece of content on the front end and clicks the little
pencil, they get a focused pop‑up modal for just the field that matters — a
cleaner, less overwhelming editing experience.

You decide which fields are editable this way on a per‑field, per‑display‑mode
basis, and you can even pick which *form mode* supplies the widget shown in the
modal. The module carries no content or access role of its own: who may edit what
still follows Drupal core's normal edit permissions. It depends only on core's
**Contextual Links** module and runs on Drupal 10 and 11.

There is nothing global to fill in — once enabled, you turn selective contextual
editing on for individual fields through the entity's display settings (see
*How to use it* below). Note that this project is not covered by Drupal's security
advisory policy, so weigh that as you would for any contrib module.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Selective Contextual Edit has no central settings page. Instead, you enable it
where your content's fields are configured — under **Structure → Content types →
[your type] → Manage display** (and the equivalent Manage display screens for
other entity types), choosing the display mode you want to affect. There you can
mark individual fields as selectively editable in place and, where offered, pick
the form mode whose widget appears in the edit modal.

Once a field is enabled, editors see it come alive on the rendered page: hovering
the content surfaces the contextual pencil, and clicking it opens a small modal
containing just that field's widget. Saving the modal writes the change back
without ever loading the full node/entity edit form.

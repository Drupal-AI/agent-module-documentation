# Cached moderation state — manual setup guide

**Cached moderation state** (`cached_moderation_state`) stores each moderated
entity's current Content Moderation state in a real, indexable field on the entity
— a hidden field named `cached_moderation_state`. Core's built‑in
`moderation_state` field is *computed*, which makes it awkward and slow to query,
sort, or filter on. This module keeps a plain stored copy of that state so you can
use it like any ordinary field: filter a View by "Draft" / "Published" /
"Archived", sort an admin listing by workflow state, or add
`->condition('cached_moderation_state', 'draft')` to an entity query — all without
the joins and computation the core field requires.

The best part is that the field manages itself. You never create or delete it by
hand. Whenever Content Moderation starts moderating a bundle, the module
automatically adds the field to that bundle; when a bundle stops being moderated,
it removes the field again. The stored value stays in sync with the real
moderation state — it recomputes on every save — so newly saved content always
caches the correct state. The field is hidden from the Field UI and its direct
display is intentionally blocked; it exists to be read in code
(`$entity->cached_moderation_state->value`) or used in Views, not shown to editors.

There is one thing you do need to do by hand: because the field is added *after*
your content already exists, existing entities start with an empty cached value
until you **back‑fill** them once. The module provides a batch update form for
this (and matching Drush commands). It requires **PHP 8.1+**, plus core's
**Content Moderation** and **Field** modules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — how the field is enabled per bundle
   (via your workflow), and the one‑time back‑fill of existing content.

## Where it lives in the admin menu

There is no traditional settings page. The one interactive screen is the
**batch update** form at `/admin/cached-moderation-state/update`, used to
back‑fill the cached state on existing content. Reaching it requires the **Access
cached moderation state update form** permission
(`access cached_moderation_state update_form`). Which content types get the field
is decided entirely by your Content Moderation workflows, at **Configuration →
Workflow → Workflows**.

# Preview — manual setup guide

**Preview** (project `all_entity_preview`, module machine name `preview`) brings core
Node's familiar "Preview before saving" experience to **every** content entity type — not
just nodes. Once you enable preview for a bundle, editors get a **Preview** button next to
Save on the edit form, and clicking it shows the unsaved entity rendered in a real view
mode before anything is committed.

The preview page also lets the editor switch view modes on the fly — check the "full"
display, then the "teaser", then jump back to editing — so you can confirm layout and field
rendering up front instead of the usual publish-then-fix cycle. It works for taxonomy terms,
media items, custom/commerce entities and anything else with an edit form, giving non-node
content the same preview UX people already expect from articles and pages.

Preview is careful about privacy and access. The in-progress entity is stashed in a
**per-user private tempstore** keyed by the entity's UUID, so one editor can never load
another editor's staged preview. Viewing a preview requires the same **create** access (for
new entities) or **update** access (for existing ones) the user would already need to edit
the content, so the module grants no extra visibility — it simply renders content the editor
can already work on. Previews are never cached, so you always see the current draft.

This guide is written for a **human** clicking through the admin UI. If you want terse,
token-cheap references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.
2. [Configuration](configuration/index.md) — turn preview on per entity type and bundle and
   pick the default view mode for each.

## Where it lives in the admin menu

The settings form sits at **Configuration → Content → Entity preview**
(`/admin/config/content/preview`), gated by the **Administer site configuration** permission.
There is no separate "Preview" permission — access to the preview page is governed by the
editor's existing create/update access on the entity being previewed.

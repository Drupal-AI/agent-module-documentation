# Merge Translations — manual setup guide

**Merge Translations** (`merge_translations`) lets content editors combine several separate
single‑language nodes into one properly translated node. It is aimed squarely at sites
migrated from Drupal 7, where the old translation relationships are lost and you end up with,
say, an English article and a German article that Drupal treats as two unrelated nodes. This
module rebuilds those translation sets through the UI, so you don't have to write a custom
script.

It adds a **Merge translations** tab to every node (`/node/{node}/merge_translations`). On
that form the node you are viewing is the *target*. For each language the site supports, a row
lets you pick a *source* node of the same content type; when you submit, that source's field
values are copied into the target as the translation for that language. Existing translations
are never overwritten — the form warns you instead. An optional per‑row action can also delete
the source node after import, but only when you have the right to delete it.

Access to the whole feature is controlled by a single permission,
**Administer merge translations** (`merge_permissions admin`), which is marked
security‑sensitive — treat it as edit‑equivalent for translations and grant it only to trusted
content‑admin roles. There is **no settings form** and no site‑wide configuration; the module
depends on core's **Content Translation** module and works only on nodes.

This guide is written for a **human** clicking through the admin UI. If you want the permission
model, node‑delete gating and the `hook_merge_translations_prepare_alter` hook for an AI coding
agent, read the sibling [`agent/`](../agent/start.md) docs.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.

## Where it lives in the admin menu

There is no central configuration page. The feature appears as a **Merge translations** tab on
each node — visit a node and, if you hold the *Administer merge translations* permission, the
tab is at `/node/{node}/merge_translations`. Grant the permission at **People → Permissions**
(`/admin/people/permissions`).

## How to use it

1. Make sure the content type is **translatable** (core content translation must be enabled for
   it) and grant the **Administer merge translations** permission to the appropriate role at
   *People → Permissions*.
2. Open the node that should become the combined, multilingual node — this is the **target**.
   Click its **Merge translations** tab.
3. For each language row, use the autocomplete to pick a **source** node of the same content
   type whose content should become that language's translation.
4. (Optional) Set the **"Action with source node after import"** option to remove the source
   node afterwards. This option only appears — and the deletion only runs — if you have delete
   access to that node.
5. Submit. The source nodes' field values are added to the target as new translations. Any
   language that already exists on the target is left untouched (you'll see a warning rather
   than an overwrite).

The form is disabled when the content type is not translatable or the target already has every
translation.

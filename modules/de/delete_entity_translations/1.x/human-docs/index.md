# Delete Entity Translations — manual setup guide

**Delete Entity Translations** (`delete_entity_translations`) lets administrators
delete content entities together with all their translations, for selected
entity types, in one bulk operation. It is aimed at the specific job of cleaning
up multilingual content — most often *before* you remove a language from the
site.

The problem it solves is a Drupal quirk: when you delete a language, Drupal
removes the interface translations for it, but content in that language is not
deleted — it is quietly set to "language neutral" instead, which is rarely what
you want. Removing an entity and every one of its translations cleanly through
the standard UI is fiddly and slow. This module gives you a single screen where
you pick a language and the entity types you care about, and it deletes the
matching entities and translations in bulk, so you can then remove the language
knowing the content has genuinely gone.

> ## ⚠️ This is destructive and irreversible
>
> Bulk deletion **cannot be undone**. Before you run it:
>
> - **Back up your database first.**
> - **Confirm your selection** — the language and entity types — carefully, so
>   you do not remove more than you intend.
> - **Test on a non‑production copy** before running it against a live site.
>
> The operation is admin‑gated, but the responsibility for what gets deleted is
> yours.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is no ongoing settings page — the module provides a deletion action, whose
workflow is described below.

## Where it lives in the admin menu

The deletion screen is at **Configuration → Regional and language → Delete Entity
Translations** (`/admin/config/regional/delete-entity-translations`).

## How to use it

1. **Take a database backup.** Deletion cannot be reversed.
2. Go to **Configuration → Regional and language → Delete Entity Translations**
   (`/admin/config/regional/delete-entity-translations`).
3. Select the **language** whose content you want to remove, and the **entity
   types** to include.
4. **Review your selection** carefully.
5. Run the process to delete the matching entities and their translations.
6. Once the content is removed, you can safely delete the language itself if that
   was your goal.

# Entity Confirmation — manual setup guide

**Entity Confirmation** (`entity_confirmation`) lets you **customize the
confirmation (status) message** shown after an entity is saved. The default
Drupal "X has been created / updated" message is often too generic or too dull; this
module replaces it with wording you choose (or suppresses it) — per entity type,
bundle, and operation.

It covers the **create**, **edit**, and **delete** operations, and the settings for
each operation live on that operation's individual **form mode**, which gives you
fine-grained flexibility — you can tailor the post-save feedback differently for
creating, editing, and deleting the same entity.

This is a UX/administration feature only: it affects the post-save status message and
has no content or access-control role. There is no central settings page — you configure
it where the form modes are configured. It requires **Drupal 9, 10, or 11**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no dedicated settings page** for this module. Its options are configured
per operation on the entity's form modes, described in "How to use it" below.

## Where it lives

Entity Confirmation adds no standalone admin menu item. Instead, it adds
per-operation confirmation-message settings to the entity **form mode**
configuration for the create, edit, and delete operations.

## How to use it

1. Decide which entity type/bundle you want to customize (for example the Article
   content type).
2. Configure the confirmation message on the relevant **form mode** for
   each operation — create, edit, and delete — that you want to change. Each
   operation is configured independently, so you can give different feedback for
   creating versus editing versus deleting.
3. Save. From then on, when a user performs that operation on that entity, they see
   your custom confirmation message instead of the default.

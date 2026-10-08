# Paragraphs Blokkli — manual setup guide

**Paragraphs Blokkli** (`paragraphs_blokkli`) is the Paragraphs backend for the
[blökkli](https://blokk.li) visual editor. It lets editors build and edit
paragraph‑based content **visually** — drag‑and‑drop, in‑place, without wading
through the traditional nested Paragraphs forms — for a page‑builder‑like
experience on top of the standard Paragraphs data model.

Rather than being a single feature, it is a base module plus a family of optional
submodules that extend the visual editor with comments, revision conversion,
fragments, a GraphQL layer, reusable libraries, scheduling, search integration,
and content transforms. You enable the base module and then only the submodules
that match what you need.

Because it changes how content is edited, access matters: what an editor can do in
the visual editor is governed by **this module's own permissions plus the
underlying paragraph/entity edit access**. The visual editor should never let
someone edit content they could not otherwise edit, so after you set it up, verify
that visual editing is only available to users who already have permission to edit
that content and its fields.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the base module with Composer,
   enable it, and choose the submodules you need.

Configuration of Paragraphs Blokkli happens through **permissions** and through the
blökkli editor itself on your content, rather than on a single central settings
form, so there is no dedicated configuration page to walk through here — see
"How to use it" below.

## Where it lives in the admin menu

Paragraphs Blokkli does not add a single settings page. Its access is managed at
**People → Permissions** (`/admin/people/permissions`), where you grant its
editing permissions to the appropriate roles. Editing itself takes place directly
on your content, in the blökkli visual editor, rather than on an admin form.

## How to use it

1. Enable the base module and any submodules you need (see
   [Installation](installation/index.md)).
2. At **People → Permissions**, grant the Paragraphs Blokkli editing permissions
   only to roles that should build content visually. Confirm those same users
   already have the ordinary edit access for the content and paragraph fields
   involved — the visual editor respects, and should not bypass, entity and field
   edit access.
3. Open a piece of content that uses a Paragraphs field. Editors can now build and
   rearrange paragraphs visually, in place, instead of using the nested add/edit
   forms.

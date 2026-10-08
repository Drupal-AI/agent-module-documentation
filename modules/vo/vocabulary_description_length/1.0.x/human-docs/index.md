# Vocabulary Description Length — manual setup guide

**Vocabulary Description Length** (`vocabulary_description_length`) makes one small
but welcome change to the taxonomy vocabulary edit form: it swaps the **Description**
field from core's cramped single-line text box for a roomy multi-line `textarea`.
That's it — but if you have ever tried to write a proper paragraph explaining what a
vocabulary is for, into a field the width of a search box, you'll appreciate it.

This is a "one-hook convenience" module. It has **no settings, no permissions, no
schema and no services** — you enable it and the vocabulary Description field is
immediately comfortable to type into. It changes only the *editing widget*: it does
**not** change how the description is stored (core already stores it as an unlimited
string either way), it does not add any length validation, and it does not change how
the description renders on the front end. It only affects the vocabulary form itself,
so term descriptions, node fields and everything else are untouched.

Because it depends on nothing but core taxonomy, there is nothing to wire up — the
improvement is live the moment the module is on.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is nothing to configure. After enabling the module:

1. Go to **Structure → Taxonomy** (`/admin/structure/taxonomy`).
2. Add a new vocabulary or edit an existing one.
3. The **Description** field is now a multi-line box — write as many paragraphs,
   line breaks and notes as you like (editorial guidelines, the vocabulary's
   purpose, naming conventions, onboarding notes for new editors), then save as
   usual.

## Where it lives in the admin menu

The module adds no menu item or settings page. Its only visible effect is the
enlarged **Description** field on the vocabulary add/edit forms under
**Structure → Taxonomy**.

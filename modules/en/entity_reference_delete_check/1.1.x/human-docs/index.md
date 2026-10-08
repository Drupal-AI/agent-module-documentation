# Entity Reference Delete Check — manual setup guide

**Entity Reference Delete Check** (`entity_reference_delete_check`) guards
against a quiet, common way of breaking a site: deleting an entity that other
content still points at. Before an entity is deleted, it scans your
entity-reference fields for anything that references it and adds that
information to the standard "Are you sure you want to delete this?" form — so
you can see the dangling references you are about to create instead of finding
them later.

The problem it solves is referential integrity. Drupal core happily lets you
delete a taxonomy term, a media item, or a node that dozens of other pieces of
content reference, leaving those references pointing at nothing. This module
alters core's content-entity delete form to surface those usages at the exact
moment you decide to delete, so the decision is an informed one.

It works the moment you enable it — there is nothing you *must* configure. It
is a data-integrity and administration aid; it surfaces where an entity is used
(which can reveal that referencing content exists) and has no access-control
role of its own. One optional submodule, **Delete Check Paragraph URL**
(`entity_reference_delete_check_paragraph_url`), depends on the Paragraphs
module and adds the URL of the page where a referencing paragraph is used,
which is helpful when an entity is referenced from inside a paragraph rather
than directly.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and (optionally) the Paragraphs URL submodule.

There is **no configuration page** for this module. Once enabled, the reference
check runs automatically on every content-entity delete form.

## Where it lives in the admin menu

Entity Reference Delete Check adds no admin page of its own. You see it in
action on any entity's **delete confirmation form** — go to delete a node,
term, media item, or other referenced entity and the form now lists the
references that still point at it before you confirm.

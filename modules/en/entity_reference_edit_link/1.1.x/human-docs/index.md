# Entity Reference Edit Link — manual setup guide

**Entity Reference Edit Link** (`entity_reference_edit_link`) puts an edit link
next to the item an editor has selected in a reference field's widget, so the
referenced entity can be opened for editing straight from the form that
references it — and, opened in a dialog, without leaving that form at all. It
also works with the Select2 field widget.

The friction it removes is small, constant, and cumulative. An editor working on
an article picks a related term, an author profile, or a linked page, notices
something wrong with it, and has to leave the form — losing unsaved work unless
they save first — open the admin listing, search for the item, edit it, and
navigate back. On a content model with several reference fields per node that
happens many times a day. A link beside the reference removes the navigation;
opening it in a dialog removes the loss of context too.

Two things are worth telling your editors up front. First, **the edit link
should respect the referenced entity's own access** — a reference to something
an editor may view but not edit should not offer an edit link, and if it does,
the resulting access-denied page is a usability annoyance rather than a security
hole, because the entity form enforces its own access regardless. Second,
**editing the referenced entity changes it everywhere** — that is exactly what
reference fields are for, but it is not what an editor expects from a link
inside "their" form: a term edited here is edited for every node that uses it.
Put that in editorial guidance, because a link that looks local and acts
globally is how shared content gets damaged.

From version 1.1.0 on, a settings page lets you additionally add a reference
link to the content type's **Manage fields** page from the node edit form; that
option is off until you enable it.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the optional settings page for the
   "Manage fields" link.

## Where it lives in the admin menu

The edit links themselves appear inside reference-field widgets on entity edit
forms — there is nothing to switch on per field once the module is enabled. The
module's own settings page sits at
`/admin/config/entity-reference-edit-link`, behind the **Administer site
configuration** permission.

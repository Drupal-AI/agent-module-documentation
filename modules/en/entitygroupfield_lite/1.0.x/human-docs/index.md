# Entity Group Field lite — manual setup guide

**Entity Group Field lite** (`entitygroupfield_lite`) links content entities to
**Group** entities through a plain field, without the full Group-content plugin
machinery. It is heavily inspired by
[Entity Group Field](https://www.drupal.org/project/entitygroupfield) but takes a
slightly different, lighter approach: for each defined "group ↔ content"
relationship it provides a computed field you can expose on the entity's edit
form, so associating content with a group becomes a simple field choice.

The module ships a **Group select list** widget — an ordinary select list with no
AJAX. If a user can be a member of two group types, say A and B, you can expose
two separate fields (one per group type) on the user edit form and enable each
independently. When only one group is selectable, the widget automatically
collapses to a single on/off checkbox — handy for a "put this in the private
section" toggle. The widget supports multiple relationships and lets you
customize each field's displayed label for clarity.

Reach for this module when you want a simple, no‑AJAX select to attach content to
a group, when you have many group types and prefer a distinct field per type, or
when a single checkbox is enough to attach content to one unique group. It is
**not** the right fit when your group relationship has its own fields that must be
set at the moment content joins a group — that needs the full Entity Group Field
or Group-content forms.

Because Group governs membership‑based access, remember that how content is linked
to a group can affect what group members can see. Entity Group Field lite has no
access-control role of its own — it only creates the link — so verify the linkage
composes with your Group access setup as you intend.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module together with its Group and Form Options Attributes dependencies.

There is **no dedicated settings page** for this module. Setup happens on your
entity's form display, described in "How to use it" below.

## Where it lives in the admin menu

Entity Group Field lite adds no admin configuration page. You use it from your
entity's **Manage form display** — for example **Configuration → People →
Account settings → Manage form display** for users, or a content type's **Manage
form display** — where the computed group field(s) can be enabled and given the
**Group select list** widget.

## How to use it

1. Make sure the **Group** module is set up with the group type(s) and
   group‑content relationships you need.
2. Open the **Manage form display** of the entity you want to associate with
   groups (for example the user account form).
3. Enable the computed **group field** for the relationship you want to expose
   (drag it out of the *Disabled* region).
4. Choose the included **Group select list** widget for that field, and customize
   its label if you want clearer wording for editors.
5. Save. Editors now see a select list (or a single checkbox, when only one group
   is selectable) on the form to attach the content to a group.

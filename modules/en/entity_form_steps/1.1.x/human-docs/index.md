# Entity Form Steps — manual setup guide

**Entity Form Steps** (`entity_form_steps`) turns a long entity form into a
multi-step wizard, using **Field Group** to decide which fields belong to which
step. Instead of confronting people with one enormous screen, you break the form
into achievable steps with progress and navigation — while it stays a real entity
form (a node, a user profile, a term), not a separate survey tool.

The problem it solves is form abandonment. A thirty-question registration, a grant
application, a detailed product submission — a wall of fields discourages people
before they start. The usual alternatives each have a cost: the Form API's
multi-step pattern is code that rebuilds state by hand, and moving the whole thing
to Webform gives you an excellent survey but *not* an entity form. This module keeps
the entity form and adds the steps, leaning on `field_group` — already the standard
way site builders organize fields into tabs and fieldsets — so the grouping happens
in the form display, not in code. Buttons and labels for each step are
customizable, and hooks are available for further tweaks.

It works as soon as it and Field Group are enabled — there's no global settings
page. You build the steps on a bundle's **Manage form display**, described under
"How to use it" below. It requires the **Field Group** module and supports Drupal
9, 10, and 11.

**A couple of caveats.** Multi-step forms are only supported on the *default
translation* entity form, and user-account forms depend on an open core issue. And
three things determine whether the wizard is genuinely better than the single page
it replaces: **validation should surface errors on the step that caused them** (not
all at the end), you should **decide what abandoning mid-wizard leaves behind**
(nothing saved, or an incomplete entity the rest of the site must tolerate), and
users need to **navigate backward** to change an earlier answer without losing later
steps.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, pull in Field
   Group, and enable the module.

There is **no settings form** of its own — steps are built with Field Group on the
Manage form display screen. See "How to use it" below.

## How to use it

1. Go to the **Manage form display** tab of the entity type you want to turn into a
   wizard (e.g. **Structure → Content types → (type) → Manage form display**),
   choosing the form mode you want.
2. Click **Add field group** and select **Form step** as the group type.
3. Review the group's options (its label, buttons, and so on) and create it.
4. Use the drag-and-drop rows to place the fields that belong to that step inside
   the Form step group.
5. Repeat to add as many steps as you need, then save. The form now renders as a
   multi-step wizard.

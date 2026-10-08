# Entity Reference Actions — manual setup guide

**Entity Reference Actions** (`entity_reference_actions`) adds a bulk‑actions
control to entity‑reference field widgets. Right on the edit form of a host
entity, an editor can run a registered **action** — publish, unpublish, delete,
or any custom action — against *all* the entities currently referenced by that
field, without opening each one individually.

For example, a "Related articles" field could get a control that unpublishes
every referenced article at once, or a Media Library field could get a button
that deletes all attached media in a single step. The actions offered are Drupal's
ordinary action plugins (the same ones Views Bulk Operations uses), so you can
reuse core actions like "Delete content" or "Make content sticky", or your own
custom ones — no special plugin type to implement.

The module is deliberately small: it has **no permissions, no routes, and no
global settings page**. You switch the feature on per field widget, on that
entity's *Manage form display* tab. When an editor triggers an action, the module
loads the referenced entities, **skips any the editor doesn't have access to**,
and runs the rest — either through Drupal's Batch API with a progress modal, or,
for actions that need confirmation, by opening the action's confirm form in a
modal dialog. Because each entity's access is checked at run time, the feature
only ever exposes operations the editor could already perform.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no dedicated settings page. You enable and tune the feature on a field's
widget under **Structure → *(entity type)* → *(bundle)* → Manage form display**
(a URL like `/admin/structure/types/manage/article/form-display`). The
bulk‑actions control itself then appears next to that field on the entity's
add/edit form.

## How to use it

The feature is turned on **per field widget**:

1. Go to the **Manage form display** tab for the bundle that has your
   entity‑reference field (for a content type, **Structure → Content types →
   *(type)* → Manage form display**).
2. Find the entity‑reference field's row and click its **gear/cog** to open the
   widget settings.
3. Tick **Enable Entity Reference Actions**. A few options appear:
   - **Action title** — the label shown above the actions control (defaults to
     "Action"). Rename it to something like "Bulk actions" if you prefer.
   - **Include / exclude** — choose whether the list you pick next is the set of
     actions to **offer** (include) or the set to **hide** (exclude, the
     default — meaning "offer everything except these").
   - **Actions** — the checkboxes of available actions. Only actions whose type
     matches the field's target entity type appear here (for a node reference,
     node actions; for a media reference, media actions; and so on). Use this with
     the include/exclude choice to curate exactly which actions editors see —
     for instance, hide destructive ones, or offer only "Delete".
4. **Update** the widget and **Save** the form display.

Now open an entity that has this field. Beside the field you'll see the actions
control (a dropbutton when more than one action is offered). Pick an action and it
runs against every referenced entity you have permission to act on — large sets
are processed in a batch with a progress modal, and actions that require
confirmation open their confirm form in a dialog first.

To offer an action the module doesn't already list, define an ordinary Drupal
**Action plugin** whose type matches the reference's target entity type; it then
shows up in the widget's list automatically. See the sibling
[`agent/api/handler.md`](../agent/api/handler.md) for the internals.

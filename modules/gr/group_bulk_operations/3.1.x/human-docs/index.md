# Group Bulk Operations — manual setup guide

**Group Bulk Operations** (`group_bulk_operations`) adds Views bulk actions for the
[Group](https://www.drupal.org/project/group) module, so you can assign or remove
group roles and change group ownership across many groups at once instead of
editing each group one at a time.

When a site has more than a handful of groups, routine membership work becomes
repetitive: adding a new moderator to forty groups, removing a departing member
from every group they belong to, or granting a role across a whole cohort is the
same three‑click operation performed over and over. This module supplies the
group‑specific action plugin — *"Assign group role and Remove Group User"* — that
you attach to a group listing view, letting you tick the groups you want and apply
the change in a single step.

Because it builds on Group and on Views' bulk‑operations mechanism, you use it by
adding a bulk‑operations field to a view that lists groups, then choosing the
action. There is no separate dashboard to learn.

> **Two things worth keeping in mind — they follow from what the module does, not
> from how it is built.** First, **bulk role changes are hard to review and harder
> to undo**: there is no per‑group log saying why forty memberships changed at
> once, so a mistaken selection is discovered later and repaired by hand — run the
> view, check the count, then act. Second, **membership changes reach beyond the
> group**: group roles typically drive content access, so a bulk removal can
> silently revoke access people rely on, and a bulk grant can expose material they
> should not see.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Group.

There is **no standalone settings form** for this module (`configure` is null).
You configure the behaviour on a group listing view and through the action's own
form, described under "How to use it" below. The action forms live at
`/admin/group/assign_group_role` and `/admin/group/remove_group_role`, both gated
by the **Administer group** permission — the correct gate, since bulk membership
and role changes across a site's groups are exactly what that permission is for.

## Where it lives in the admin menu

There is no dedicated configuration page in the admin menu. The setup happens on a
**group listing view** (for example the default group admin view under
**Administration → Groups**), where you add a bulk‑operations field and select the
Group Bulk Operations action.

## How to use it

1. Edit (or create) a **view that lists groups** in the Views UI.
2. Add a **Bulk update / bulk operations** field to that view.
3. In the field's settings, make sure the **"Assign group role and Remove Group
   User"** action is among the selected actions.
4. Save the view, then open the group list. Tick the groups whose memberships you
   want to change, choose the action, and apply it.
5. **Check the count of selected groups before you apply** — the change affects
   every group you ticked, and there is no per‑group audit trail to undo it.

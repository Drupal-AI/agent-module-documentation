# Configuration

This module has no global settings page. You configure it by **adding the field to
a bundle**, setting its **per‑instance options**, and then choosing roles on each
entity you want to protect.

## Step 1 — Add the field to a bundle

1. Go to the bundle's **Manage fields** screen — for example
   **Structure → Content types → Article → Manage fields**.
2. Click **Add field** and choose **Entity Access by Role** (in the *Access*
   category).
3. Give it a label such as "Role access" and save.

You can add more than one such field to the same entity, each governing different
operations.

## Step 2 — Configure the per‑instance settings

On the field's settings form you control two things:

- **Operations** — which of **View**, **Edit**, and **Delete** this field governs.
  Tick only the operations you want it to control. For example, enable just *View*
  to restrict who can see the entity without affecting who can edit it. (For an
  unpublished entity, a view request is evaluated as a "view unpublished"
  operation.)
- **Empty roles access fallback** — what happens when an entity's field has no role
  selected:
  - **Neutral** — the module stays out of the decision, letting core and other
    modules decide as usual. This is the safe default.
  - **Allowed** — an empty field grants access to everyone.
  - **Forbidden** — an empty field locks the entity down unless roles are explicitly
    allowed. Use this to make new content private by default.

You can also set **default values** on the instance so new entities start with a
sensible policy.

## Step 3 — Set roles on each entity

When editing an entity, the field's widget lets the editor:

- pick one or more **roles**, and
- choose whether those roles are **allowed** or **restricted (forbidden)**.

In **allowed** mode, only the selected roles can perform the governed operations and
everyone else is blocked. In **forbidden** mode, the selected roles are blocked and
everyone else is allowed. If several role‑access fields are present, each is
evaluated for the operations it governs.

There is also a **debug formatter** you can place on the display to show which roles
and access value an entity currently carries — handy while testing your policy.

## The bypass permission

Grant **Bypass 'Entity Access by Role Field' permissions**
(`bypass entity_access_by_role_field permissions`) under **People → Permissions** to
trusted roles (typically administrators). A user with it skips all role‑access‑field
logic and is always allowed. This is a security‑sensitive permission — give it only
to roles that should see everything.

## Remember the listings limitation

The field only controls access to the entity's own view/edit/delete operations. It
does **not** filter Views, search results, or other listing queries, so a restricted
entity's title or label can still appear in a list. If you need listings filtered
too, handle that separately (for example with Views access or query alterations).

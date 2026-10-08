# Configuration

There is no module settings page. Everything is configured through the **Field Group**
UI on an entity's **Manage form display** tab (`/admin/structure/…/form-display`) —
for example the form display of a content type.

## Add a Settings field group

1. On the **Manage form display** tab, click **Add field group**.
2. Choose the format **Settings** (this module's formatter), give it a label, and
   save.
3. In the group's settings (the gear on the group's row), set **Roles that can view**
   — a set of checkboxes. **Important:** leaving it empty means the group is visible to
   **no one**. Tick the roles that should see the panel.
4. Drag the fields you want to hide under the group, position the group in the visible
   region, and click **Save**.

On the actual edit form, those grouped fields render inside a hidden panel that a gear
button (floated to the right) opens and closes — entirely client‑side, with no page
reload.

## How visibility is decided

For each user, the group is shown if:

1. the user has the **Bypass field_group_settings field visibility** permission
   (always shown), **or**
2. **Roles that can view** is non‑empty **and** the user has at least one of those
   roles.

Otherwise it's hidden. This is applied as the group's render `#access`, so a
disallowed user genuinely doesn't get those fields in the form — not merely hidden with
CSS.

## The bypass permission

| Permission | Effect |
|---|---|
| **Bypass field_group_settings field visibility** | The holder always sees every Settings group on any form, ignoring each group's *Roles that can view* list. Roles that hold this permission appear **pre‑ticked and disabled** in the group's settings form (labeled as managed by permissions). |

Set it on **People → Permissions**.

> **Remember the caveat.** This is a form‑display convenience, not a security boundary.
> Hiding fields on the form does not protect the field *data* — a role that can edit
> those fields through another form mode, the API, or REST is unaffected. For real
> field‑level access control, use core field access or a dedicated access module.

## Where settings are stored (for reference)

The only setting, `visible_for_roles`, is stored inside the form‑display config, e.g.
`core.entity_form_display.node.article.default` under the field_group entry, with
`format_type: settings`. There's also a render element (`#type => 'field_group_settings'`)
and a theme hook (`field-group-settings.html.twig`) you can reuse or override in custom
code and themes — see the sibling
[`agent/configure/field-group.md`](../agent/configure/field-group.md).

# Configuration

Field Read-Only by Role is configured **per field**, directly in that field's
configuration — there is no central settings page.

## Make a field read-only for chosen roles

1. Go to **Structure → Content types → *(your type)* → Manage fields**.
2. Click the field you want to control to open its **field configuration**.
3. In the **Field Read-Only by Role** settings, select which **roles may edit** the
   field.
4. Save the field configuration.

Every role you did **not** select will see the field as **read-only** on the entity
edit form — the field stays visible (it is not hidden), but its widget is disabled,
and the format/editor-switch controls are hidden, so those users can't change the
value through the form.

This keeps the same form working for everyone: admins and editors who should edit
the field can, while reviewers and moderators see the value without being able to
alter it — no duplicate form displays or content types required.

## Critical: understand what this does and does not protect

The restriction is applied **only in the entity edit form**, by marking the widget
"disabled." Drupal's Form API honors that (disabled elements ignore submitted
input), so a read-only-role user genuinely **cannot change the field through the edit
form**.

However, the module implements **no server-side field access**
(`hook_entity_field_access`). That means the read-only rule provides **no protection
on any non-form write path**. A user in a "read-only" role who otherwise has
edit access to the entity can still change the field through:

- **JSON:API** (`PATCH`) — part of Drupal core and commonly enabled,
- **REST**,
- **Quick Edit** (inline editing),
- **Views Bulk Operations (VBO)**, and
- any **programmatic** write.

So treat this module as a **UI convenience** that guides editors, **not** as a
security boundary. Do not use it to protect a sensitive field from a role that
should never write it. For enforcement that holds on every path, use a module that
implements `hook_entity_field_access` (for example Field Permissions), which restricts
the field access itself rather than just disabling the form widget.

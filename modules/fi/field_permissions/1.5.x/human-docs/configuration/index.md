# Configuration — setting field permissions

Field Permissions has no global settings screen. Instead, permissions are set
**per field**, on that field's own settings form. This page walks through choosing
a field's permission type, granting the custom per-role permissions when you need
them, and reviewing every field's setting on the report page.

Before you start, make sure your role has the **"Administer field permissions"**
permission (granted on **People → Permissions**). You will also need the usual
field-administration rights for the entity you are editing (for example
*"Administer content types"* for node fields).

## Step 1 — Open a field's settings form

1. Go to **Structure → Content types** (`/admin/structure/types`).
2. Click **Manage fields** next to the content type that has the field you want to
   protect.
3. Find the field in the list and click **Edit** (or its **⚙ → Edit** menu) to
   open the field's settings form.

The same applies to fields on other entity types (users, taxonomy terms, media,
and so on) — open that entity's field list and edit the field.

## Step 2 — Choose the field's permission type

On the field settings form, look for the **"Field visibility and permissions"**
section. It offers three modes:

- **Public** *(default)* — the field behaves like any normal Drupal field. Access
  is inherited from the entity: anyone who can view or edit the entity can view or
  edit this field. On the report page this shows as *"Not set (Field inherits
  content permissions.)"*.
- **Private** — only the entity's **author** and users who hold the
  *"Access private fields"* permission can view or edit the value. To everyone
  else the field is hidden — it never appears in the rendered entity. This is ideal
  for personal data such as a profile phone number or date of birth.
- **Custom permissions** — reveals a **per-role permission grid** (see the next
  step) so you can grant view and edit access field-by-field and role-by-role.

Select the mode you want. If you choose **Public** or **Private**, skip to
[Step 4](#step-4-save-the-field) — there is nothing more to configure.

## Step 3 — Grant the custom per-role permissions

When you select **Custom permissions**, a grid appears with one row per role and a
column for each of the following permissions, specific to this field:

- **Create field value** — set the field's value when *creating* a new entity.
- **Edit own field value** — change the value on entities the user authored.
- **Edit anyone's field value** — change the value on any entity.
- **View own field value** — see the value on entities the user authored.
- **View anyone's field value** — see the value on any entity.

Tick the boxes to grant each capability to each role. Splitting *own* from *anyone*
is what lets you, for example, allow authors to edit a field on their own content
while a reviewer role can edit it everywhere, or let users read only their own
submissions.

> These per-field permissions are also listed on **People → Permissions**
> (`/admin/people/permissions`), grouped under the field's name, so you can review
> or adjust them there later alongside all your other permissions.

## Step 4 — Save the field

Click **Save settings** at the bottom of the field settings form. The new access
rules take effect immediately for that field, everywhere the field is used.

## Step 5 — Review everything on the report page

To see how field access is configured across the whole site, go to **Reports →
Field list → Permissions** (`/admin/reports/fields/permissions`) and open the
**Permissions** tab.

![The Field permissions report matrix](../images/report.png)

The report lists every field with its **Field name**, **Field type**, **Entity
type**, and where it is **Used in**, followed by columns for each custom
permission (*Create field*, *Edit own field*, *Edit field*, *View own field*,
*View field*). Public fields read *"Not set (Field inherits content
permissions.)"*; Private and Custom fields show their configured grants instead.
This gives you a single place to audit field-level security and confirm each field
is protected the way you intended.

# Configuration

Configuring Edit UUID is two decisions: **where** the editable UUID field appears
(which entity types and bundles), and **who** can see and change it (the three
permissions). Optionally, you can also surface the UUID on an entity's display.

## Step 1 — create a settings entity

1. Log in as a user with the **"Administer edit_uuid_config configuration"**
   permission.
2. Go to **Configuration → Development → Edit UUID config**
   (`/admin/config/development/edit-uuid-config`). You can also reach it from the
   Extend page by searching for *Edit UUID* and clicking **Configure**.
3. Add a new setting and fill in the fields:
   - **Settings Name** — a simple name of your own, just to help you identify this
     configuration.
   - **Entity type** — the entity type whose UUID you want to make editable, for
     example *node*.
   - **Bundles** — the specific bundles (a multi‑select) that should expose the
     UUID field, for example *Article*.
4. **Save.**

Now, adding or editing an entity of a configured bundle shows a **UUID text field**
on its form, where a permitted user can enter or change the UUID.

> **Note:** Create a **separate** settings entity for each distinct configuration.
> Updating an existing config overrides the old one rather than adding to it.

## Step 2 — assign the permissions

Go to **People → Permissions** (`/admin/people/permissions`). Edit UUID adds three
permissions, which deliberately separate seeing from changing:

| Permission | What it grants |
|------------|----------------|
| **Administer edit_uuid_config configuration** | Manage which entity types and bundles expose the UUID field (the settings above). |
| **Show edit_uuid** | See the UUID on the entity form. Some roles can be given *only* this, so they can view but not change it. |
| **Edit edit_uuid** | Actually *change* the UUID on the form. |

> **Treat "Edit edit_uuid" as a restricted, temporary grant.** A UUID is the
> identity that JSON:API, content‑deployment tools, default content, and
> configuration dependencies all match on. Changing one silently breaks every
> reference held elsewhere against the old value, and nothing in Drupal reports it.
> Grant it for a migration or reconciliation window, then revoke it. The
> per‑bundle control is the useful part — expose the field only where reconciliation
> is actually needed rather than site‑wide.

## Step 3 (optional) — show the UUID on display

If you want the UUID visible on an entity's view page, go to that entity's **Manage
display** and enable the **UUID formatter**. The UUID is shown to a user only if
they have permission to see it.

## Positioning the field

The UUID text field's position on the form follows normal field weighting. If you
need to move it, the
[Generic Field Weight](https://www.drupal.org/project/generic_field_weight) module
can adjust its weight.

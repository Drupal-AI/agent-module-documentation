# Configuration

Anonymous author is a field, so you configure it the same way you configure any
Drupal field: add it to an entity type, set its widget, and set its formatter.

## Add the field

1. Go to the entity type you want to attach it to — for example **Structure →
   Content types → [your type] → Manage fields**, or a comment type's Manage
   fields.
2. Click **Add field** and choose the **Anonymous author** field type.
3. Give it a label and save.

## Configure the widget (the input form)

On **Manage form display**, the **Anonymous Author** widget exposes the **email**
and **name** inputs plus a **notify** checkbox. In the widget settings you can
optionally set placeholder text for the email and name inputs.

Who sees these inputs is decided automatically:

- On a **new** entity, the fields are shown only to **anonymous** users.
- On an **existing** entity, the fields are shown only to users who hold the
  **Edit anonymous author fields** permission.

## Configure the formatter (the display)

On **Manage display**, use the **Anonymous author** formatter to render the stored
name and email when the entity is viewed.

## Notifications

If a visitor ticks **notify**, the module emails the stored address when the entity
is updated, and when a comment is added to it (it skips notifying an author about
their own comment). The recipient is the visitor‑supplied email address, which the
module does not validate — if abuse or spam is a concern, validate or rate‑limit
upstream.

## Permission

Grant **Edit anonymous author fields** (under **People → Permissions**) to
moderators who should be able to see and edit the author fields on existing
content.

## What it does *not* do

The field stores plain name/email text. It does **not** set the entity's real owner
(`uid`), and it does not grant permission to create content — anonymous content
creation still requires the relevant core create permission.

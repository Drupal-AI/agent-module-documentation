# Configuration

Image Field Permissions has no central settings form. You configure it
**per image field**, in two steps: first switch the field to custom permissions,
then assign the per‑role permissions that step unlocks.

## Step 1 — turn on custom permissions for the image field

1. Log in as an administrator (or a user who can administer fields).
2. Go to **Structure → *(your content type)* → Manage fields** and edit the image
   field you want to control (for example *Manage fields → Image → Edit*).
3. Find the **Field visibility and permissions** setting and choose
   **Custom permissions**. (This setting is provided by the Field Permissions
   module; Image Field Permissions adds the image‑specific options.)
4. Save the field settings.

You can apply different rules to different image fields — each field carries its own
custom‑permission choice.

## Step 2 — assign the per‑role permissions

Once a field uses custom permissions, its permissions appear on
**People → Permissions** (`/admin/people/permissions`). For an image field you'll
find, per role:

- **Create** access to the image file value — who may add/upload an image when
  creating content.
- **Edit own / Edit any** the image file — whether a role can replace or remove the
  uploaded file on their own content only, or on anyone's content.
- **View own / View any** the image file — whether a role can see the image value.
- **Edit own / Edit any** the image **alt** attribute — whether a role can change
  the alternative text, independently of the file.
- **Edit own / Edit any** the image **title** attribute — whether a role can change
  the title text, independently of the file.

The alt and title permissions are the distinctive part: because they are separate
from the file permissions, you can grant a role the right to edit alt/title text
while withholding the right to touch the image file itself.

Tick the boxes for each role and click **Save permissions**.

## A worked example — translators edit metadata, not the image

To let a "Translator" role fix accessibility text without changing imagery:

1. Set the image field to **Custom permissions** (Step 1).
2. On **People → Permissions**, for the Translator role grant **Edit any** for the
   image **alt** and **title** attributes, and leave **Edit any / Edit own** for the
   image **file** unchecked.
3. Save.

Now when a translator edits a node, the image's upload and remove buttons are
hidden (they cannot swap the file), but the alt and title inputs remain editable —
so accessibility text stays maintainable while the original image is protected.

## Important limitation

The widget‑hiding enforcement runs on the **node** form only. Image fields on other
entity forms — media, taxonomy terms, users — are **not** covered, so do not rely on
this module to restrict image editing outside of nodes.

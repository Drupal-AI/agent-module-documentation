# Configuration

Getting Image Pointer working is a short sequence: configure the module, place your
markers on content, and put the display block on the page.

## Configure the module settings

1. Log in as an administrator.
2. Go to **Administration → Configuration → Image Pointer**.
3. Configure the Image Pointer settings — including selecting the **content
   type(s)** where the image‑pointer field should be available.
4. Submit the configuration form. Once submitted, the image‑pointer field is added
   to the content type(s) you selected.

## Control who can edit the settings

By default only the administrator role can reach the Image Pointer settings URL. To
let another role manage it, go to **People → Permissions**
(`/admin/people/permissions`), find **Edit Image pointer Settings**, and grant it to
the appropriate role(s). Save.

## Place markers on content

With the field enabled on a content type:

1. Create or edit a piece of that content.
2. In the create/edit form, place the **markers** on the image where you want them,
   according to what each marker should point to.
3. Save the content.

## Show the markers with the block

The markers are displayed through a block, not directly in the content:

1. Go to **Structure → Block layout**.
2. Place the **Image Pointer View Block** into the region where you want the marker
   list to appear.
3. Save the block layout.

Now visitors see the image with its clickable markers in that region.

# Configuration

Pinterest Widget has three moving parts: a **global settings** page, **blocks** you
place in regions, and **fields** you add to entities. This page walks through each.

## Global settings

1. Log in as a user who can administer the site.
2. Go to **Configuration → Services → Pinterest Widget**
   (`/admin/config/services/pinterest-widget`).

Here you set the defaults that apply site-wide:

- **Global styles** — the default button style (for example Regular, Round, or
  Large) and localisation/language, so embedded widgets and buttons match your
  branding without configuring each one individually.
- **Scope** — which **content types** activate the image-hover "Save" button. Tick
  the content types where you want visitors to be able to pin images on hover; leave
  the rest unticked to keep those pages clean.

Save the form when you are done.

## Using blocks

To place a Pinterest widget in a region:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** in the region you want, and pick one of the four Pinterest
   block types — **Pin**, **Board**, **Profile**, or **Follow**.
3. In the block's configuration, enter the relevant Pinterest URL (a pin URL, board
   URL, or profile) and choose a layout. Several blocks support fixed presets such
   as **Square**, **Sidebar**, or **Header**, and you can also use custom
   dimensions for a fully responsive embed.
4. Save the block. You can place multiple Pinterest blocks in different regions.

The URL you enter is passed through the module's validator, which sanitises it to
prevent malformed or malicious values from reaching the page.

## Using fields

To let editors embed a specific Pin or Board per piece of content:

1. Go to the content type (or other entity bundle) you want, and open **Manage
   fields**.
2. Add a field of the **Pinterest** field type. The module provides field types,
   widgets, and formatters for Pin, Follow, Board, and Profile content.
3. On **Manage form display** and **Manage display**, choose the Pinterest widget
   and formatter as needed.
4. When editing content, editors paste the Pin or Board URL into the field, and it
   renders as an embedded Pinterest widget on the entity.

## Privacy note

Pinterest widgets load Pinterest's third-party scripts in the visitor's browser.
If your site is subject to GDPR or a similar policy, disclose this integration in
your privacy policy and, where required, gate it behind consent.

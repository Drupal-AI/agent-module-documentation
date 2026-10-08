# Configuration

Configuring ISPIM means two things: **curating the list of preview images** you want
to test styles against, and (optionally) **controlling who** is allowed to manage
that list.

## Manage your preview images

1. Go to **Configuration → Media → Image Style Preview Images**
   (`/admin/config/media/ispim-preview-image`). This is the collection screen listing
   all the `ispim_preview_image` entities you have created.
2. Click **Add** to create a new preview image and upload the picture you want to
   test styles against — for example a brand image, a photo with faces, or one with
   text, so you can judge how a style crops and scales real content.
3. Use the list to **edit** or **delete** existing preview images. Because the
   entities are revisionable, you can keep and revert revisions, and because they are
   translatable you can translate their labels via config translation.

There is also a per-entity **settings form** at
`/admin/config/media/ispim-preview-image/settings` where the default preview
behaviour is configured.

## Preview a style against your image

1. Go to **Configuration → Media → Image styles**
   (`/admin/config/media/image-styles`) and click **Edit** on a style.
2. The page's preview now uses your curated image (a small JavaScript behaviour swaps
   the image in place), so you see the real effect of the style rather than the core
   default sample.

## Control who can manage preview images

ISPIM provides its own permissions, and they are marked as **restricted access** —
grant them only to trusted roles:

- The dedicated settings permission — **"Access to manage ispim
  ispim_preview_image.settings"** (`ispim.ispim_preview_image.settings.admin`) —
  controls access to the settings form.
- Per-operation permissions (**create / edit / delete / view** preview images) are
  provided for the entity itself.

Assign these under **People → Permissions** (`/admin/people/permissions`). Granting
them lets an editor manage preview images without needing broader media or
site-configuration rights.

## Bulk-creating preview images from files (optional, for developers)

The module ships a **Drush command** that creates `ispim_preview_image` entities from
files already on disk. It reads a local, operator-supplied file path — a privileged,
command-line-only operation (it can read any file the PHP user can read), so it is
not exposed to the web. Run `drush list` after enabling the module to see the exact
command name and options.

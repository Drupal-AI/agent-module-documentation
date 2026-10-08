# Configuration

Photos works as soon as it is enabled, but it has a rich global settings page for
tuning how albums and photos behave, a structure page for managing the photo entity's
fields and displays, and a set of permissions to grant.

## Open the settings form

1. Log in as a user with the core **Administer nodes** permission (an administrator by
   default) — most of the module's admin pages use that permission.
2. Go to **Configuration → Media → Photos**, or navigate directly to
   `/admin/config/media/photos`.

## Global settings

The settings page controls site-wide album and photo behaviour. The main groups of
options are:

- **Upload behaviour** — which field images upload into (default `field_image`), how
  many upload rows the form offers at once, whether to allow **ZIP-archive upload** (on
  by default), and whether to use the **Plupload** multi-uploader (off by default; needs
  the Plupload module). Per-role upload limits let you cap how many images authenticated
  users and administrators can upload.
- **Image sizes and styles** — the module can offer each photo in several named
  downloadable sizes (each an image style plus a label), and you choose the maximum
  image style applied on upload. Separately, you pick which image style is used in each
  display context: the album **cover**, the **list** view, the **full** view, the
  **teaser**, and the **pager** thumbnails.
- **Display and ordering** — the default sort order for photos in an album (for example
  by weight, ascending), the number of images shown per full page, and the pager size.
  You can also toggle whether **photo counts** are shown on albums and users.
- **Titles** — **clean titles** (on by default) tidies uploaded filenames into readable
  photo titles.
- **Housekeeping** — whether per-user photo counts are recalculated on cron.

Adjust what you need and save. Everything is stored in the `photos.settings`
configuration object, so it exports and deploys with your site config. If you prefer the
command line:

```bash
drush cget photos.settings photos_display_list_imagesize
drush cset photos.settings photos_num 8 -y
```

## Managing photo fields and displays

The **Structure → Photos** page (`/admin/structure/photos`) is the field-management
base for the `photos_image` entity. From there you can add fields to photos and
configure the photo entity's **form display** and its various **view displays** (cover,
full, list, teaser, pager, sort, and search result). The default image field on a photo
is `field_image`.

## Permissions

Photos defines seven permissions, granted at **People → Permissions**
(`/admin/people/permissions`):

| Permission | What it allows |
|---|---|
| **View photo** | Viewing photos. |
| **Create photo** | Uploading/creating photos. |
| **Edit own photo** | Editing photos the user owns. |
| **Delete own photo** | Deleting photos the user owns. |
| **Edit any photo** | Editing any photo in any album (restricted — trusted roles). |
| **Delete any photo** | Deleting any photo in any album (restricted). |
| **View original** | Viewing/downloading the original full-size image. |

Two things to keep in mind:

- **Edit any photo** and **Delete any photo** are restricted permissions; grant them
  only to trusted roles.
- The module's **admin** pages (settings, structure, import, the photos listing) use
  the core **Administer nodes** permission, and that is also the photo entity's admin
  permission — so site builders need `administer nodes`, not a photos-specific
  permission, to manage configuration.
- Creating and editing **albums** (which are nodes of the `photos` content type) follows
  the normal node permissions for that content type (such as "Create Photo album
  content"), which are separate from the per-photo permissions above.

With Drush, for example:

```bash
drush role:perm:add editor 'create photo,edit own photo'
```

## Album privacy (Photos access submodule)

If you enabled the **Photos access** submodule, each album gains an access mode — open,
locked, restricted to a list of users, or password-protected. This turns on
album-level privacy for the `photos` content type; see that submodule's own
documentation for the details.

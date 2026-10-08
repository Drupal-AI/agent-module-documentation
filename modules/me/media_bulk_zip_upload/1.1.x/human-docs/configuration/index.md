# Configuration

Media Bulk Zip Upload has two things to set up: **which media types** offer the
bulk ZIP form, and **who** is allowed to use it. There is also an optional form
mode for customising how the bulk upload form looks.

## Open the settings form

1. Log in as a user with the **Administer media** permission (an administrator by
   default).
2. Go to **Configuration → Media → Media Bulk Zip Upload config**, or navigate
   directly to `/admin/config/media/media-bulk-zip-upload-config`.

## Choose the enabled media types

The settings form lists your site's media types. Tick the ones that should offer
bulk ZIP upload. For each media type you enable, a bulk upload form becomes
available at `/media/add/{media_type}/bulk` — for example, enabling the **Image**
media type gives you `/media/add/image/bulk`. Save the form to apply your choice.

Only enable the types where bulk loading actually makes sense, and remember that
the files an archive may contain are limited by that media type's **allowed file
extensions** (set on the media type's source field). Keep that list tight — an
archive is an efficient way to deliver many files at once, so a permissive media
type is more exposed here than on the ordinary single-file add form.

## Grant the permissions

The upload permissions are **generated per media type**, so they only appear once
the module is enabled. Go to **People → Permissions**
(`/admin/people/permissions`) and look for the bulk-upload permission for each
media type you enabled, then grant it to the roles that should be allowed to bulk
upload. Because access is checked per media type, you can allow bulk upload for
some types and not others.

## Customise the bulk upload form (optional)

The module registers a dedicated **`bulk_upload` form mode**. If you want the
bulk form to show or hide particular fields, go to the media type's **Manage form
display** and configure its *Bulk upload* form mode. This is entirely optional —
the form works without any changes.

## Reacting to uploads (for developers)

During expansion the module fires events (see `src/Event/`) so a custom module
can rename, tag, or otherwise post-process each extracted file before the media
entity is saved. This is a code-level extension point rather than a UI setting,
but it is worth knowing it exists if you need to alter what gets created.

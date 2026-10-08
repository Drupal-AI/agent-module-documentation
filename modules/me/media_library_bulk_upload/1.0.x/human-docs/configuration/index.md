# Configuration

Media Library Bulk Upload works as soon as it's enabled and permissions are
granted — by default every media type is offered on the bulk‑upload page. The
configuration here is about two things: optionally *limiting* which media types
can be bulk‑uploaded, and controlling *who* can bulk‑upload each type.

## Limit which media types are offered

1. Log in as a user with the core **Administer media** permission.
2. Go to **Configuration → Media → Media Library Bulk Upload**
   (`/admin/config/media/media-library-bulk-upload-config`).

The form shows a checkbox for every media type on the site. The behavior is:

- **Leave all boxes unchecked** — every media type is offered on the bulk‑upload
  landing page (this is the install default). Access to each type is then decided
  purely by permissions.
- **Check some boxes** — only the checked types are offered. A type you leave
  unchecked is forbidden on the bulk‑upload screen even for a user who has its
  permission ("Media type X is not enabled for bulk upload.").

So the setting is a site‑wide cap on which types can ever be bulk‑uploaded, sitting
on top of the per‑type permissions.

Behind the scenes this is stored in the config object
`media_library_bulk_upload.settings` under a single key, `media_types`. You can
manage it from Drush:

```bash
# See the current restriction
drush config:get media_library_bulk_upload.settings media_types

# Restrict to only Image + Document
drush config:set media_library_bulk_upload.settings media_types.image image -y
drush config:set media_library_bulk_upload.settings media_types.document document -y

# Restore "all types" (clear the restriction)
drush php:eval '\Drupal::configFactory()->getEditable("media_library_bulk_upload.settings")->set("media_types", [])->save();'
```

## Permissions — who can bulk‑upload

The module defines **dynamic, per‑media‑type** permissions. One is generated for
each media type, in the form:

```
use media {media_type_id} bulk upload form
```

On a stock install that gives you `use media image bulk upload form`,
`use media document bulk upload form`, `use media video bulk upload form`, and so
on. Create a new media type and a matching permission appears automatically.

How access works:

- **Administer media** (core) is a super‑permission — anyone with it can reach the
  bulk‑upload landing page and the settings form.
- The **landing page** is available to a user who has *any* one of the
  `use media {type} bulk upload form` permissions (or *administer media*).
- A **specific type's upload form** requires that type's own
  `use media {type} bulk upload form` permission — and the type must not be
  excluded by the `media_types` restriction above.

Grant permissions per role at **People → Permissions**, or from Drush:

```bash
# Let the content_editor role bulk-upload Image media
drush role:perm:add content_editor 'use media image bulk upload form'
```

Give a role several of these permissions to let it bulk‑upload multiple types, and
combine them with the `media_types` setting to cap what's available site‑wide. For
example, you might restrict the site to Image and Document, then grant one role
only the Image permission and another both.

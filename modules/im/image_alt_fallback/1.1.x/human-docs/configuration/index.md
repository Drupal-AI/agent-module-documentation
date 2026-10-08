# Configuration

Image Alt Fallback does nothing until you tell it which image fields to handle. The
settings form is organised in three levels: a global default behavior at the top,
then your entity types and bundles, and finally each image field within a bundle.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Media → Image Alt Fallback**, or navigate directly to
   `/admin/config/media/image-alt-fallback`.

## Default behavior

At the very top of the form is a **Default behavior** select list that applies to
every field you set to "Default". Choose one of:

- **Entity label** — fill an empty `alt` with the parent entity's label (for
  example, the node title).
- **Role presentation** — add `role="presentation"` to images that have an empty
  `alt` and no existing `role`, signalling to assistive technology that the image is
  decorative.

## Entity type / bundle / field

Below the default, the supported entity types (**Node** and **Taxonomy term**)
expand into their bundles, and each bundle lists its image fields. Every field is
shown as `Label (machine_name)` — for example `Image (field_image)` — with a select
list offering four options:

- **None** — take no action on this field. This is the default selection, and fields
  left as *None* are not saved to configuration.
- **Default** — use whatever the global **Default behavior** (above) is set to.
- **Entity label** — fill the empty `alt` with the parent entity's label.
- **Role presentation** — add `role="presentation"` to images with an empty `alt`
  and no existing role.

Because processing is scoped to the specific field wrappers you configure, other
image fields on the same entity are unaffected.

### Example

For the **Article** content type you might set `field_image` to **Default** so it
inherits the global setting, and set `field_images` (an image gallery) to **Role
presentation** to mark those decorative images accordingly.

## Save

Click **Save configuration**. No template changes, extra hooks, or configuration
exports are needed beyond saving the form — the fallback is applied automatically at
render time. Clear the cache (`drush cr`) if changes do not appear immediately.

## Reviewing coverage with the Media Alts view

To see which media items still lack real alt text, open **Content → Media Alts**
(`/admin/content/media-alts`). You can filter by alt status (empty / not empty),
media type, language, and published status, and jump directly to editing any item —
useful for backfilling genuine, image-specific alt text over time, which remains the
recommended long-term fix.

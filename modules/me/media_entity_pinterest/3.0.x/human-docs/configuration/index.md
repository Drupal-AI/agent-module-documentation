# Configuration

This module has no settings form. You set it up by creating a **media type** that
uses the Pinterest source, through Drupal core's Media UI. You'll need the core Media
administration permissions to do this.

## Create a Pinterest media type

1. Go to **Structure → Media types → Add media type**
   (`/admin/structure/media/add`).
2. Give it a **Name** — for example, "Pinterest".
3. Set **Media source** to **Pinterest**.
4. Save. Core Media will create (or prompt you to add) a **source field** to hold the
   Pinterest URL. This field must be a **Link**, **Text (plain)**, or **Text (plain,
   long)** field.
5. Back on the media type's edit form, make sure **Field with source information**
   points at that source field.

## Set the embed formatter

So that a saved URL renders as a real Pinterest embed instead of plain text:

1. Open the media type's **Manage display** tab.
2. For the source field, choose the **Pinterest embed** formatter.
3. Save.

## Optional: map the metadata to fields

The Pinterest source can expose metadata pulled from the URL — the pin **id**, the
**board** slug, the **section**, and the **user**. If you want any of these stored in
their own fields, add the fields to the media type and use the media type's **Field
mapping** section to map each metadata attribute to a field.

## The one internal setting (thumbnail storage)

There is one configuration value, and it has no form: `local_images` controls the
base folder where locally stored thumbnails go. It defaults to
`public://pinterest-thumbnails`. Change it only if you need to, via Drush:

```bash
drush cset media_entity_pinterest.settings local_images 'public://pinterest-thumbnails' -y
```

## Using it

Once the media type exists, editors create a Pinterest media entity and paste a
Pinterest URL into the source field. Recognized URL shapes are:

- **Pin** — `https://www.pinterest.com/pin/{id}`
- **Board** — `https://www.pinterest.com/{user}/{board}`
- **Board section** — `https://www.pinterest.com/{user}/{board}/{section}`
- **User profile** — `https://www.pinterest.com/{user}`

International Pinterest domains (`.co.uk`, `.jp`, `jp.pinterest.com`, and so on) are
recognized automatically. If a value isn't a valid Pinterest URL, the built-in
validation rejects it on save. On display, the **Pinterest embed** formatter emits
the right embed markup and loads Pinterest's `pinit.js` widget to turn it into a live
embed.

To reuse Pinterest media elsewhere — in content, a Views listing, or a block — add a
media reference field pointing at this Pinterest media type, just as you would with
any other media type.

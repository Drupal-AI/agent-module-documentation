# Configuration

Streamlike oEmbed needs to know, for each kind of page, which field holds the
Streamlike media ID. You tell it that with a list of route-to-field mappings on the
settings form.

## Open the settings form

1. Log in as a user with the **Administer streamlike_oembed configuration**
   permission (grant this to your media administrators).
2. Go to **Configuration → Media → Streamlike oEmbed**, or navigate directly to
   `/admin/config/media/streamlike-oembed`.

## The media-ID source mappings

The form's main setting is a list of **source mappings**, one per line, each in the
form `route_name|field_name`:

```
entity.node.canonical|field_streamlike_video
entity.taxonomy_term.canonical|field_video_id
```

Each line says: "on *this* route, read the Streamlike media ID from *this* field."
So the examples above tell the module to look in `field_streamlike_video` on node
pages and in `field_video_id` on taxonomy term pages.

A few things worth knowing about how the mapping is used at render time:

- The module only acts on **entity canonical routes** (the `entity.*.canonical`
  routes, i.e. the main page for a node, term, user, and so on). If the current
  route is not one you mapped, nothing happens on that page.
- It loads the page's main entity and reads the mapped field. For a field of type
  `vpx_media_field` it uses the field's `emid` value; for other fields it uses the
  field's plain value.
- The media ID is validated as a **16-character string**, so make sure the field
  you point at actually contains a Streamlike media ID in that form.

## Save

Click **Save configuration**. Then load a canonical page for one of your mapped
routes and confirm the oEmbed discovery tags for the Streamlike player appear.
Update the mappings whenever a field's machine name changes or you want to cover
additional routes.

# Configuration

Setting up Mapy.com has two parts: entering your **API key and map settings**, and
then **adding the Mapy.com field** to the content that should carry a location.

## 1. Enter your API key and map settings

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Web services → Mapy.com**, or navigate directly to
   `/admin/config/services/mapycom`.
3. Enter your **Mapy.com API key**. Maps are drawn through the Mapy.com REST API,
   so a valid key is required before any map will display.
4. Set the map appearance and behaviour options the form offers — for example the
   **map layers** and **controls** — to suit your site.
5. **Save** the form.

### Handling the API key safely

The API key is a credential. Rather than typing it straight into the database in
plain text, prefer storing it in an environment variable so it never lands in a
config export or version control.

With DDEV you can store it as an environment variable and load it into the
container:

```bash
ddev dotenv set .ddev/.env --mapycom-api-key=YOUR_KEY_HERE
ddev restart
```

That makes the value available inside the container as `MAPYCOM_API_KEY` (keep
`.ddev/.env` out of version control). Confirm it is present *without* printing it:

```bash
ddev exec 'test -n "$MAPYCOM_API_KEY" && echo set'
```

Then reference that variable wherever the module reads the key. If your setup keeps
the key directly in the settings form, treat the value as sensitive and avoid
committing it in configuration exports.

### A privacy note

Displaying a Mapy.com map causes each visitor's browser to load map tiles and
scripts from Mapy.com, a third‑party service. Depending on where your visitors are,
you may need to mention this in your privacy notice and/or gate the maps behind a
cookie‑consent mechanism.

## 2. Add the Mapy.com field to your content

1. Go to **Structure → Content types → *(your type)* → Manage fields** and **add a
   field** of the **Mapy.com** type.
2. On **Manage form display**, choose the **Mapy.com field widget** so editors can
   pick the location on a map when creating content.
3. On **Manage display**, choose the **Mapy.com field formatter** so the map
   renders where the field appears in the entity.

## 3. Show many locations on one map (optional)

To plot several pieces of content on a single map, build a **View** and set its
**Format** to the **Mapy.com** Views style. AJAX support means filters update the
map dynamically. This is ideal for directories, branch finders, or any listing that
benefits from a map overview.

## Troubleshooting

- **No map appears** — check that your API key is valid and saved on the settings
  form.
- **The map does not refresh after an AJAX filter** — clear Drupal's cache
  (`drush cr`) and check the browser's JavaScript console for errors.

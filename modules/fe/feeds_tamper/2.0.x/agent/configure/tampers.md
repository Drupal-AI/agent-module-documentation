# Configure tampers on a feed type

There is no site-wide settings page. Tampers are attached per **feed type**.

## Via UI
1. Go to **Admin → Structure → Feeds** and edit a feed type.
2. Click the **Tamper** operation (or visit `.../manage/{feeds_feed_type}/tamper`).
3. For a source field, **Add** a Tamper plugin (trim, convert case, explode, find & replace,
   regex, default value, required, unique, …) and configure it.
4. Reorder plugins per source by **weight** — they run top to bottom.
5. Edit/delete existing tampers from the same list.

Routes: `entity.feeds_feed_type.tamper` (list), `.tamper_add/{source_field}`,
`.tamper_edit/{tamper_uuid}`, `.tamper_delete/{tamper_uuid}`.

## As config (exportable/deployable)
Tampers are stored as **third-party settings** on the Feeds feed type config entity, so they
export with `drush config:export` and deploy like any config. Shape
(`feeds.feed_type.{id}.yml`):
```yaml
third_party_settings:
  feeds_tamper:
    tampers:
      <uuid>:
        uuid: <uuid>
        plugin: 'trim'          # a Tamper plugin id
        source: 'title'         # the Feeds source key it applies to
        weight: 0
        label: 'Trim title'
        description: ''
        # ...plus that Tamper plugin's own settings keys
```
Each entry validates against `tamper.[plugin]` schema plus the common keys above
(`config/schema/feeds_tamper.schema.yml`). On feed-type save, tampers whose `source` no
longer exists in the mapping are auto-removed (`rectifyInstances()`).

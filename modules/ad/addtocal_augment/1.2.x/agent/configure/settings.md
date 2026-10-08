# Configure the addtocal augmenter on a field formatter

No admin settings page (`configure` is null). The `addtocal` plugin is enabled and configured
**per field formatter**, on a date field whose formatter supports the Date Augmenter API (e.g.
Smart Date). On *Manage display* for the entity/bundle, open the date field's formatter settings;
the Date Augmenter section lists available augmenters — enable **Add to Calendar Links** and set
its options.

## Where it is stored

Date Augmenter stores its state as **third-party settings on the field-formatter component** of
the `entity_view_display`, under the key `date_augmenter`. The `addtocal` plugin's own settings
sit inside it (schema `field.formatter.third_party.date_augmenter` → `instances` →
`settings.addtocal`, validated against `date_augmenter.plugin.addtocal`):

```
core.entity_view_display.<entity>.<bundle>.<view_mode>
  content.<date_field>.third_party_settings.date_augmenter.instances:
    status:   { addtocal: true }          # enabled augmenters
    weights:  { order: { addtocal: { weight: 0 } } }
    settings: { addtocal: { …options below… } }
```

Read it with:

```
drush config:get core.entity_view_display.node.event.default \
  content.field_when.third_party_settings.date_augmenter
```

## Option keys (schema `date_augmenter.plugin.addtocal`)

Defaults come from `AddToCal::defaultConfiguration()`.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `label` | label | `Add to calendar` | Text prefix before the links. |
| `event_title` | label | `''` | Calendar event title; supports tokens. Empty → uses the entity label. |
| `location` | string | `''` | Event location; supports tokens. |
| `description` | string | `''` | Event description; supports tokens. |
| `retain_spacing` | boolean | `false` | Preserve line breaks / non-breaking spaces in the description. |
| `icons` | boolean | `true` | Show icons instead of text for the links. |
| `max_desc` | integer | `60` | Trim the description to this length (`0`/empty = no trim). |
| `ellipsis` | boolean | `true` | Append `...` to a trimmed description. |
| `past_events` | boolean | `false` | Show the widget for events already in the past. |
| `target` | string | `''` | `''` = list of links; `modal` = single link opening a modal dialog (attaches the `modal` library). |
| `ignore_timezone_if_UTC` | boolean | `true` | Drop the timezone from the calendar entry when it is UTC. |

## Notes

- The plugin only augments **display** output; stored date values are untouched.
- It needs a formatter that actually calls `augmentOutput()` (the Date Augmenter integration).
  With a formatter that does not, the settings still save (valid config) but nothing renders.
- `event_title` may be left empty **only** when an entity is available at render time (the label
  is then used); with neither a title nor an entity, `buildLinks()` returns nothing.

# Configuration

Linked Field is configured in two places: the **per-field "Link this field"
settings** (where you actually turn linking on, one field at a time), and a small
**admin page** that controls which link attributes are offered.

## Per-field: turn on "Link this field"

This is where the real work happens.

1. Go to **Structure → Content types → _(your type)_ → Manage display** (or the
   Manage display of any entity — media, taxonomy, users, and so on). Pick the
   view mode you want (Default, Teaser, etc.).
2. Click the **gear icon** on the field you want to link to open its formatter
   settings.
3. Linked Field adds these controls:

| Control | What it does |
|---------|--------------|
| **Link this field** | The on/off checkbox. Off by default; tick it to enable linking for this field in this view mode. |
| **Type** | Where the link's address comes from — **Field** or **Custom** (see below). |
| **Field** *(when Type = Field)* | A dropdown of other fields on the same entity whose value becomes the link address. |
| **Destination** *(when Type = Custom)* | A URL or path you type in. Tokens are supported. |
| **Advanced → attributes** | Optional link attributes — by default *title*, *target*, *class*, and *rel*. Tokens are supported; *class* and *rel* merge with any existing values. |
| **Advanced → Text** | Optional link text (tokens supported) that **replaces** the field's own output as the clickable text. Leave empty to link the field's normal output. |

4. Click **Update**, then **Save** the display.

### Choosing the destination Type

- **Field** — use another field on the same entity as the link target. Only
  certain field types are offered as a destination: **link**, **string**,
  **list (float)**, and **list (string)** fields (the entity's main label field is
  excluded). If the bundle has none of these, the form falls back to *Custom*.
- **Custom** — type a URL or path yourself. Internal paths can be written as
  `/node/1`, `node/1`, or `internal:/node/1`; external URLs need a full scheme
  (for example `https://example.com`). Tokens such as `[node:url]` are supported,
  and when the Token module is enabled a **token browser** appears so you can pick
  them. (Values containing tokens skip path validation, since the real value isn't
  known until render.)

> **Note:** you can't add linking to `link`-type fields — those already render
> their own links, so the option is disabled for them.

### It exports with your display

These choices are stored as **third-party settings** on the display component, so
they're part of your configuration and deploy with `drush config:export`. An
exported component looks like:

```yaml
third_party_settings:
  linked_field:
    linked: 1
    type: custom
    destination: '[node:url]'
    advanced:
      target: _blank
      rel: nofollow
```

Empty settings are stripped on save, so nothing is stored unless *Link this field*
is actually checked.

## Admin page: available link attributes

The Advanced section above offers *title*, *target*, *class*, and *rel* by
default. If you need more (say a `download` attribute), you can add to that list
site-wide.

1. Go to **Configuration → Content authoring → Linked Field**, or navigate
   directly to `/admin/config/linked_field/config`. This requires the **Administer
   linked field** permission.
2. The form edits a small **YAML** list of attributes. Each attribute can have an
   optional **label** and **description** that show next to it in every formatter's
   Advanced section. The default is:

   ```yaml
   attributes:
     title:
       label: ''
       description: ''
     target:
       label: ''
       description: ''
     class:
       label: ''
       description: ''
     rel:
       label: Relationship
       description: ''
   ```

3. Add keys to expose more attributes across the site. (The form suggests the
   optional *YAML Editor* module for a nicer editing experience, but doesn't
   require it.)

You can also set values with Drush, e.g.:

```bash
drush cset linked_field.config attributes.download.label 'Download'
```

## Permission

| Permission | Grants |
|------------|--------|
| **Administer linked field** (`administer linked_field`) | Access to the *available link attributes* config page above. |

Turning linking on for an individual field is not gated by this permission — it's
part of managing a field's display, so anyone who can administer that entity's
display (for example *Administer content types* display) can do it.

## For developers

Linked Field applies the link at render time through a
`hook_entity_display_build_alter()` implementation and the `linked_field.manager`
service; there are no Twig templates to override (style the generated `<a>` via its
*class* attribute or the module's CSS). See the sibling
[`agent/api/linked_field.md`](../agent/api/linked_field.md) reference for details.

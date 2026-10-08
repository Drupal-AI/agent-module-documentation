<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add and configure the "Global: Base url" field

There is **no admin settings page**. You use the module by adding its Views field to a display.
Everything is stored in the view config under the `base_url` field handler.

## Add the field

In the Views UI, **Add** a field and search for **"Global: Base url"** (`base_url`). By itself it
prints the site's complete base URL (scheme + host + base path), e.g. `https://example.com`.

Config shape (minimal):

```yaml
# views.view.<id> -> display.<display>.display_options.fields
base_url:
  id: base_url
  table: views
  field: base_url
  plugin_id: base_url
```

## Use 1 — as the `[base_url]` token in Custom text

1. Add the **Global: Base url** field and tick **Exclude from display**.
2. Add a **Global: Custom text** field *below* it (field order matters — a field can only use
   tokens of fields above it).
3. In the Custom text, reference `[base_url]`, e.g.:
   ```html
   <a href="[base_url]/home">Home</a>
   ```

## Use 2 — render it as a link (the field's own options)

Tick **"Display as link"** (`show_link`) on the Base url field and fill the sub-options
(`show_link_options`):

| Option | Meaning |
|---|---|
| `link_path` | Drupal path appended to the base URL (run through the alias manager). Empty → link is the base URL itself. |
| `link_text` | Visible link text. Empty → the URL is shown. |
| `link_class` | CSS class(es) on the `<a>` (space-separated). |
| `link_title` | `title` attribute. |
| `link_rel` | `rel` attribute. |
| `link_fragment` | Fragment/anchor appended as `#value`. |
| `link_query` | Query string; space/`&`-separated `key=value` pairs, e.g. `destination=node/add/page`. |
| `link_target` | `target` attribute (e.g. `_blank`). |

`link_path`, `link_text`, `link_class`, `link_title`, `link_fragment`, and `link_query` accept
**`{{ token }}`** replacement patterns (other fields/arguments above this one), resolved by
`TokenTrait::simpleTokenReplace()`. The link is built with `Url::fromUri()` + `Link::fromTextAndUrl()`.

Config shape (link mode):

```yaml
base_url:
  id: base_url
  table: views
  field: base_url
  plugin_id: base_url
  show_link: true
  show_link_options:
    link_path: node/1
    link_text: 'View on site'
    link_class: 'btn'
    link_query: 'ref=views'
    link_target: '_blank'
```

## Set with drush

```bash
drush cset views.view.my_view \
  display.default.display_options.fields.base_url.show_link true -y
drush cset views.view.my_view \
  display.default.display_options.fields.base_url.show_link_options.link_path node/1 -y
```

(Or load the `View` entity in `drush php:eval`, edit `display_options.fields.base_url`, `->save()`.)

## Config schema

Shipped as `views.field.base_url` (in `config/schema/views_base_url.views.schema.yml`): a
`views_field` with `show_link` (boolean) and the `show_link_options` mapping listed above.

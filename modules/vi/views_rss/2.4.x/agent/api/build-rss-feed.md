<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Build an RSS feed with a View

No configure route — everything is configured per-View. There are two plugin ids to know
(from `src/Plugin/views/style/RssFields.php` and `src/Plugin/views/row/RssFields.php`):

| Plugin type | id | title | required `display_types` |
|---|---|---|---|
| style | `rss_fields` | Advanced RSS feed | `feed` |
| row | `views_rss_fields` | Advanced RSS feed | `feed` |

Both validate that the other is in use (`RssFields::validate()` on each side), and the row
plugin additionally requires `views_rss_core` to be enabled.

## Via the UI

1. Add a **Feed** display to a View (or edit an existing Feed display).
2. Display "Format": change **Show** to *Advanced RSS feed* (this is the row plugin) and
   **Format** to *Advanced RSS feed* (the style plugin) — in that order, since the style
   plugin's `validate()` checks the row plugin id.
3. Set the Feed display's **Path**.
4. Add Fields to the display as normal — every field becomes selectable as a source for item
   elements.
5. Open the **Format** ("Advanced RSS feed") settings: fill in *Channel elements* fieldsets
   (grouped by namespace — "Channel elements : core", "... : dc", etc., one per enabled
   submodule) and *Other feed settings* (absolute paths, feed icon in links) and
   *Namespaces* (RDF merge, any undeclared namespace URIs).
6. Open the **Show** ("Advanced RSS feed") settings: for each *Item elements : \<namespace\>*
   fieldset, pick which View field feeds that RSS element (a `- None -` select per element).
   An item **must** have `title` or `description` mapped (RSS 2.0 requirement, enforced by
   the row plugin's `validate()`).
7. Save.

## Config shape (what to inspect/write with `drush config:get` / `php:eval`)

Everything lives on the View's display config, `views.view.<name>`:

```yaml
display:
  <feed_display_id>:
    display_options:
      style:
        type: rss_fields
        options:
          channel:
            core:                       # namespace ("core" for unprefixed elements)
              views_rss_core:           # implementing module machine name
                description: 'Custom feed description'
                image: 'sites/default/files/logo.png'
                ttl: '60'
            dc:                         # a non-core namespace, if a channel element uses one
              views_rss_dc: {}
          feed_settings:
            absolute_paths: 1           # default on
            feed_in_links: 0            # default off
          namespaces:
            add_rdf_namespaces: false
            <module>:
              <namespace>: 'https://example.org/ns'   # only for namespaces with no URI yet
      row:
        type: views_rss_fields
        options:
          item:
            core:
              views_rss_core:
                title: field_title      # View field machine name/id supplying this element
                link: field_link
                description: field_body
            dc:
              views_rss_dc:
                creator: field_author
```

So the pattern for **any** element from **any** submodule is:
`style.options.channel.<namespace>.<module>.<element>` (channel) and
`row.options.item.<namespace>.<module>.<element>` (item), where `<module>` is the machine name
of whichever submodule (or custom module) implemented the `hook_views_rss_*_elements()` that
defined `<element>`, and `<namespace>` is `core` unless the element key was
`<namespace>:<name>` (e.g. `dc:creator` → namespace `dc`, element `creator`).

## Date format

The module installs `core.date_format.rfc822` (pattern `D, d M y H:i:s O`) and
`views_rss_format_date($timestamp)` formats a UNIX timestamp with PHP's
`\DateTimeInterface::RFC822` constant — used for `pubDate`/`lastBuildDate` and any other
date-like element a submodule preprocesses.

## Twig / theming gotcha

`views_rss_theme_registry_alter()` repoints the `views_view_rss` and `views_view_row_rss`
theme hooks at this module's own `templates/` (not core's), because the channel `<image>`
element needs to output a `<link>` tag using a custom `imagelink` tag name (`link` is normally
filtered as a void/security-sensitive tag) which `views-view-rss.html.twig` then
`replace()`s back to `link`. A theme overriding `views-view-rss.html.twig` must reproduce that
`|replace({"imagelink": "link"})` step or channel images will render a literal `imagelink` tag.

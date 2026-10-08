# Configuration

Iconset's own settings page lives at the `iconset.settings` route, under
**Configuration** in the Media group. Open it as a user with the *Administer site
configuration* permission. This page is where the site's icon sets come together;
the real work of Iconset, though, is *declaring* the sets and then *using* them,
described below.

## Declaring icon sets

The base module discovers icon sets from a `*.iconset.yml` file shipped by a
module or theme. Each entry names the set, the handler plugin that renders it
(`svg` for SVG files, `svg_font` for SVG font files), and the assets that belong
to it — either a directory of icons or individual files. A minimal example that a
module or theme would provide:

```yaml
fontawesome_brands:
  label: 'Fontawesome-Brands'
  plugin: 'svg'
  assets:
    - '/libraries/fontawesome/sprites'   # a directory of icons
    - 'assets/icons/brands.svg'          # a single SVG file
```

If you would rather not edit a YAML file, enable the **Iconset Custom**
(`iconset_custom`) submodule, which lets you declare icon sets through the admin
UI instead.

Advanced setups can point an entry at a custom *builder* class (implementing
`\Drupal\iconset\IconBuilderInterface`) to take full control of an icon's render
output, or add new handler plugins for other asset types.

## Using icons once a set is declared

Once Iconset knows about a set, its icons are available in three ways:

- **On menu links** — with the `iconset_menu` submodule enabled, an icon
  selector appears when you add or edit a menu link.
- **In embedded content** — with the `iconset_embed` submodule enabled.
- **On fields and in templates** — developers can render icons with the
  `iconset_icon` render element or the matching Twig function, and can add an
  `iconset_selector` form element so editors pick an icon from chosen sets.

## Save

After making changes on the settings page, click **Save configuration**. Changes
to the YAML‑declared sets take effect once the site rebuilds its caches.

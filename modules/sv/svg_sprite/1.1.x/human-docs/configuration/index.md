# Configuration

SVG Sprite needs one thing configured before it is useful: the location of your
sprite file. Once that is set, the field, Twig function, and token all draw from
it.

## Point the module at a sprite file

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Content → SVG Sprite settings**, or navigate directly
   to `/admin/config/content/svg_sprite`.
3. Fill in the settings:
   - **Source of the SVG sprites file** *(required)* — where the sprite lives.
     You can give one of:
     - a full URL, e.g. `https://example.com/sprite.svg` (fetched with the HTTP
       client);
     - a path relative to the web root, e.g. `themes/mytheme/dist/sprite.svg`;
     - a theme‑relative path in the form `theme://mytheme/path/to/sprite.svg`,
       which is resolved against the named theme.
   - **Sort sprites alphabetically** — when ticked, the list of icons is sorted by
     symbol `id` (or `aria-label`), which makes the editor dropdown easier to
     scan.
4. Click **Save**.

On save, the module reads the file's `<symbol id="…">` entries, builds an id → label
list (the label is a symbol's `aria-label` if present, otherwise its id), and
stores that list along with the resolved file URL. The form then shows a **Sprite
preview** of every symbol so you can confirm the file was read correctly. Tip: add
`aria-label` attributes to your symbols to get friendly, readable option labels
in the editor.

## Add the SVG Sprite field

1. On a content type (or any entity bundle) go to **Manage fields → Add field**
   and choose the **SVG Sprite** field type.
2. The field's **SVG Sprite** widget is a `<select>` populated from the symbol
   list you configured above; option labels are tag‑stripped and decoded for
   safety.
3. On the bundle's **Manage display**, set the field's formatter to **SVG Sprite**
   to render the chosen symbol.

Because the module falls back to the configured default sprite file whenever a
render call passes no explicit href, field and Twig output always reference the
current sprite file.

## Render sprites in a Twig template

The module registers a `svg_sprite()` Twig function:

```twig
{{ svg_sprite('lightbulb') }}
{{ svg_sprite('lightbulb', {'class': 'my_css_class'}) }}
```

This produces an `<svg>` element referencing the sprite, for example:

```html
<svg class="sprite sprite-lightbulb my_css_class" aria-hidden="true" focusable="false"><use href="file.svg#lightbulb"/></svg>
```

Every rendered sprite automatically gets `sprite` and `sprite-<id>` classes for
styling, plus `aria-hidden="true"` and `focusable="false"` so decorative icons are
ignored by assistive technology. Pass an attributes map (as in the second example)
to add your own classes or attributes.

## Render sprites with the token (experimental)

An experimental token is also available:

```
[svg_sprite:sprite:lightbulb]
```

It renders the same markup as the Twig function. Note that in some restricted
contexts — for example when a token's output is filtered, as it can be in Views —
you may need to allow the `svg` and `use` HTML tags for the token to survive the
site's XSS filtering. The module ships a small helper
(`SvgSpriteHelper::addSvgSpriteTagsToAdminTags()`) that shows how to add those
tags to the admin allow‑list. Only do this deliberately, since widening the
allowed‑tags list has security implications.

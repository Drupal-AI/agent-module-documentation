# Configuration

The Font Awesome settings page controls **how the icon library is delivered to
the browser** — which method it uses, whether the module loads the assets for
you, and a few validation and compatibility options. These settings apply
site-wide. You can usually accept the defaults, but it is worth understanding
each option before you start placing icons.

## Open the settings page

1. Go to **Configuration → Content authoring → Font Awesome settings**
   (`/admin/config/content/fontawesome`).

![The Font Awesome settings page](../images/settings.png)

## Choose the load method and options

Work down the form field by field:

### Font Awesome Tag

Font Awesome works with any consistent HTML element. By default it uses the
`<i>` tag to render icons, but you can pick a different tag here — for example
`<span>` — if that suits your markup better. Changing this value changes the way
icon tags are inserted into your site. Note that after changing it you will need
to clear the site cache for it to take effect.

### Font Awesome Method

This is the core choice: **how** Font Awesome renders icons.

- **SVG with JS** (the default and recommended option) — the modern, powerful
  version with the widest backwards compatibility. Icons are rendered as inline
  SVG by a JavaScript loader.
- **Web Fonts with CSS** — the classic icon method used in earlier versions of
  Font Awesome. Note that the webfont version does **not** offer backwards
  compatibility with Font Awesome 4, so you would need to confirm your icons are
  all updated to the newer version. The on-screen help links to the Font Awesome
  guide for more detail.

### Allow CSS pseudo-elements?

If you would rather not add icons directly in markup, Font Awesome can inject
them through the CSS `::before` pseudo-element. This feature is always available
with the Web Fonts method. If you turn it on for **SVG with JS**, the on-screen
help warns that it will slow your site down noticeably, so enable it only when
you actually rely on pseudo-element icons.

### Load Font Awesome library?

When enabled, the module loads the Font Awesome library for you on every page.
Leave it **disabled** if you are already including the assets some other way —
manually, or through another module or theme — to avoid loading the library
twice.

### Bypass Font Awesome icon validation?

When enabled, the module skips its check that an entered icon name is a real
Font Awesome icon. This is useful when you are pulling in custom icons from Font
Awesome's hosted kits, whose names the module does not know about. Leave it off
otherwise so typos in icon names get caught.

### CDN versus a local copy

Beyond the fields on this form, the module also decides whether to serve the
library from the Font Awesome **CDN** (the default) or from a **local** copy you
installed with `drush fa:download`. If you hosted the library locally during
[installation](../installation/index.md), switch the module over to the local
(non-CDN) source so it serves your downloaded files instead of the CDN. The CDN
delivery loads from a versioned Font Awesome URL and can optionally carry an
integrity (SRI) hash for the external asset, and a v4 compatibility shim is
available so older `fa-` classes keep working.

### Save

Click **Save configuration** to apply your choices.

## Use the icon field on your entities

With the library loading, you can let editors attach icons to content:

1. Go to **Structure → Content types**, choose a content type, and open its
   **Manage fields** tab (you can do the same for taxonomy terms or users).
2. Add a new field of type **Font Awesome Icon**.
3. On the field's form-display settings, the **autocomplete widget** lets
   editors search for and pick an icon by name. Advanced per-icon options —
   size, rotation, flip, animation, power transforms, masking, and duotone
   colors — are gated behind the *access fontawesome additional settings*
   permission, so grant that permission to roles who should see them.
4. The field's display formatter then renders the chosen icon as SVG or webfont
   markup wherever the entity appears.

If you enabled the **`fontawesome_iconpicker_widget`** submodule, you can choose
its visual iconpicker instead of the text autocomplete.

## Add icons in CKEditor

Font Awesome ships a CKEditor 5 plugin and icon dialog so editors can insert
icons directly into rich-text:

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. Edit the text format whose editor is CKEditor 5 (for example *Full HTML*).
3. In the editor toolbar configuration, drag the **Font Awesome icon** button
   into the active toolbar.
4. Save the format. Editors using that format will now see the icon button,
   which opens a dialog for choosing and inserting an icon into their text.

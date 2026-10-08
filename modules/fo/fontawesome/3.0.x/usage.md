Font Awesome integrates the popular Font Awesome icon set and toolkit into Drupal, adding an icon field type, a CKEditor icon dialog, and site-wide loading of the icon assets.

---

The module lets site builders attach Font Awesome icons to any fieldable entity through a dedicated `fontawesome_icon` field type, with an autocomplete widget for picking icons by name and a formatter that renders them as SVG or webfont markup. A global settings form (Admin → Configuration → Content authoring → Font Awesome settings) controls how the library is delivered: via the Font Awesome CDN or a locally installed copy, using the SVG-with-JS or webfont method, choosing which icon-style files (solid, regular, light, brands, duotone, thin, sharp variants, custom) to load, an optional v4-compatibility shim, and integrity/validation options. A `FontAwesomeManager` service reads the bundled icon metadata so widgets and validation know which icons and styles exist. It ships a CKEditor 5 plugin and an icon dialog so editors can insert icons into rich-text, and a Drush command (`fa:download`) to fetch the library locally. Per-icon options such as size, rotation, flip, animation, transforms, masking and duotone colors are available (gated by a permission). Two optional submodules add a JavaScript iconpicker widget and a Font Awesome media source. Icon and category metadata can be altered via hooks. It is a foundational presentation-layer building block used wherever a site needs scalable vector icons.

---

- Add a Font Awesome icon field to a content type, taxonomy term, or user.
- Let editors search and pick icons by name with an autocomplete widget.
- Render icons as inline SVG using the SVG-with-JS delivery method.
- Serve icons as webfonts instead of SVG when preferred.
- Load Font Awesome from the official CDN with zero local install.
- Serve a locally hosted copy of the library for offline/privacy needs.
- Download the library locally with `drush fa:download`.
- Insert icons into CKEditor 5 rich-text via the Font Awesome icon dialog.
- Choose which icon style files to load (solid, regular, light, brands…).
- Enable duotone icons with primary/secondary color control.
- Use sharp regular/light/solid icon variants.
- Add a v4 compatibility shim so old `fa-` classes keep working.
- Set an integrity (SRI) hash for the external CDN asset.
- Size icons (xs–10x) directly from the field widget.
- Rotate or flip icons horizontally/vertically.
- Animate icons with spin or pulse.
- Apply Font Awesome power transforms (grow, shrink, rotate, move).
- Mask one icon with another for cut-out effects.
- Stack/layer multiple icons in a single field value.
- Bound advanced per-icon settings behind a dedicated permission.
- Pick a custom HTML wrapper tag for rendered icons.
- Provide reusable icons as media entities (via the media submodule).
- Offer a visual iconpicker instead of text autocomplete (via the iconpicker submodule).
- Alter the bundled icon metadata programmatically with `hook_fontawesome_metadata_alter()`.
- Alter icon category metadata with `hook_fontawesome_metadata_categories_alter()`.
- Bypass icon-name validation when using custom icon kits.
- Theme icon output by overriding the `fontawesomeicon` Twig template.

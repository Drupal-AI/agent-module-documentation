# Configuration

Font Awesome UI has two configuration areas: the **global settings form** (how
the library is loaded) and the **icon manager** (the reusable icon definitions).
Both require the **`administer fontawesome ui`** permission.

## Global settings — Configuration → User interface → Font Awesome

Go to **Configuration → User interface → Font Awesome**
(`/admin/config/user-interface/fontawesome`, route `fontawesome.settings`). The
form controls how and where Font Awesome loads:

- **Method** — choose between loading Font Awesome from a **CDN** or from a
  **local library** (the `libraries/fontawesome` copy you installed). This is the
  first decision, and it changes which of the options below are relevant.
- **CDN provider and Integrity (SRI)** — shown when the method is CDN. You pick
  the provider and can supply a **Subresource Integrity** value, which lets the
  browser verify the fetched file matches an expected hash before running it.
- **Version** — the major Font Awesome version to target (the 1.0 release adds
  full support for Font Awesome 7).
- **Delivery format** — choose **SVG + JS** or **webfonts + CSS**, and toggle
  **minified vs source** files. Use the source (unminified) files while
  debugging; use minified in production.
- **RTL support** — enable right‑to‑left support for Arabic/Persian layouts.
- **Load restrictions** — limit where the library is loaded: to specific
  **themes**, or by **URL / page path**. These fields appear and hide based on
  your other choices. Restricting the load keeps the icon library off pages that
  don't need it.
- **Icon form settings** — a related page at
  `/admin/config/user-interface/fontawesome/form` configures the icon insertion
  form.

Save the form to apply your choices. If you selected the local method but have
not yet downloaded the library, run `drush fa:download` first (see Installation).

## Icon manager — Structure → Icon

Go to **Structure → Icon** (`/admin/structure/icon`). This is a list of reusable
icon definitions with the usual actions:

- **Add** (`/admin/structure/icon/add`) — create a new icon definition. This is
  where you pick the Font Awesome icon and set its options (size, color,
  rotation, flip, animation, border/pull, and so on) so the icon can be reused
  consistently across the site.
- **Edit** (`/admin/structure/icon/edit/{icon}`) — change an existing definition.
- **Duplicate** (`/admin/structure/icon/duplicate/{icon}`) — copy an icon as a
  starting point for a variant.
- **Delete** (`/admin/structure/icon/delete/{icon}`) — remove a definition.
- **Filter** — a filter form narrows the list when you have many icons.

Once you have icons defined here, editors and themes can reuse them across the
site rather than re‑specifying icon options each time.

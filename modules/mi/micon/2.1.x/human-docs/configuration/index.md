# Configuration

Micon's main configuration is managing **icon packages** and, if you want editors
to choose icons on content, adding an **Icon field**. Both live under the core
admin, gated by the **Administer micon** permission (`administer micon`), which you
grant at **People → Permissions**.

## Icon packages

Packages are managed at **Structure → Micon** (`/admin/structure/micon`). Each
package is a config entity with an ID (which becomes the icon prefix), a label, and
a status. Only **active** packages contribute their icons and CSS.

### The shipped Font Awesome package

Micon ships one package, **Font Awesome**, with ID `fa`. It is active on install,
so icons such as `fa-user`, `fa-star`, and `fa-trash` (the `fa-` prefix plus the
icon name) work immediately with no extra setup.

### Adding your own package

1. Download an icon package from [icomoon.io](https://icomoon.io) — a font set or
   an SVG image set — as a `.zip`.
2. Go to **Structure → Micon** and click **Add Micon Package**.
3. Give it a **Name**, upload the `.zip`, and **Save**.

On save, Micon extracts the archive, rewrites the package's CSS so its class prefix
matches the package ID, detects whether it's a font or SVG (image) package, and
flushes caches. Once the package is active, its stylesheet is attached site-wide
automatically — you don't wire up any CSS yourself. Icons in the new package are
then addressed as `<package-id>-<icon-name>`.

You can swap your whole site's icon set later by uploading a new package and
disabling the old one, and because the package (including its archive) is stored in
a config entity, it travels with a config export.

## The Icon field

To let editors pick an icon per content item, add a field of type **"Icon"**
(machine type `string_micon`) to any content type, vocabulary, or other bundle:

1. On the bundle's **Manage fields** page, **Add field** and choose **Icon**.
2. On **Manage form display**, the field uses the icon widget. Its one setting,
   **Packages**, lets you restrict which packages editors may choose from — leave
   it empty to offer all active packages, or select specific ones to present a
   curated set.
3. On **Manage display**, the field's formatter renders the chosen icon.

If a stored icon later stops matching any active icon (for example after you remove
its package), the field simply renders empty.

## Advanced (developers)

Beyond packages and the field, Micon can auto-decorate text strings with icons via
a YAML mapping (`*.micon.icons.yml` plus `hook_micon_icons_alter()`), and it
provides a Drush command, `drush micon <path>`, that exports the active icons as an
SCSS mixin/variable file for theming. See the [`agent/`](../agent/start.md) docs
for the rendering API, the `micon_icons` plugin type, and the Drush command.

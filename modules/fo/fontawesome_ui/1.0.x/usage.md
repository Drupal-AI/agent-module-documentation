<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Font Awesome UI integrates the Font Awesome icon library into Drupal, with a settings form, an icon manager, and a Drush command to fetch the library.

---

It lets a site load Font Awesome via CDN or from a local `/libraries/fontawesome` copy, choosing SVG+JS
or webfonts+CSS, minified or not, with optional Subresource Integrity for the CDN and theme/URL load
restrictions. An admin UI manages reusable icon definitions: an icon list at `/admin/structure/icon` plus
add / edit / delete / duplicate forms, a filter form, and an icon form-settings page; global settings live
at `/admin/config/user-interface/fontawesome` (route `fontawesome.settings`). Every route is gated by the
single `administer fontawesome ui` permission.

For provisioning it ships a Drush command **`fa:download`** (aliases `fadl`, `fa-download`) that resolves
the library's `remote` URL from the module's own library definition, downloads it to a temp file, moves it
into the target `libraries/fontawesome` directory, and extracts the zip with the core Archiver
(`$zipFile->extract($path)`). Security review of that command: the **download source is not user- or
config-controlled** — it comes from the module's fixed `*.libraries.yml` `remote` (the FontAwesome release)
— and the **extraction path is fixed** to `libraries/fontawesome` (guarded by a `substr($path,-11)=='fontawesome'`
check), and the command is CLI-only (no web route). The `extract()` call has no explicit zip-slip guard, but
because the archive is a trusted fixed URL fetched by an operator on the command line, it is not a
web-exploitable path-traversal vector. The module's `unserialize()` calls (e.g. reading stored icon
`options` in `FontAwesomeForm`) use `['allowed_classes' => FALSE]`, so no object injection. Net: admin-only
config surface, no anonymous/mutating web endpoints.

---

- Load Font Awesome from a CDN with one setting.
- Load Font Awesome from a local /libraries/fontawesome copy.
- Choose SVG+JS or webfonts+CSS delivery.
- Toggle minified vs source files for debugging.
- Add a Subresource Integrity value to the CDN load.
- Restrict icon loading to specific themes.
- Restrict icon loading by URL/page path.
- Enable RTL support for Arabic/Persian layouts.
- Download the library via `drush fa:download` (fadl).
- Manage a list of reusable icons at /admin/structure/icon.
- Add a new icon definition through the admin form.
- Edit or delete an existing icon definition.
- Duplicate an icon as a starting point for a variant.
- Filter the icon list with the filter form.
- Configure the icon insertion form via icon form settings.
- Gate all administration behind 'administer fontawesome ui'.
- Configure global behaviour at /admin/config/user-interface/fontawesome.
- Pick a specific Font Awesome major version.
- Provide icons to editors/themes across the site.
- Install the library separately from the module via Composer.

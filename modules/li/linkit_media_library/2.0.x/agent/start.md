<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Linkit Media Library — agent index

Adds a **Media Library** button inside CKEditor 5's Link dialog (Linkit 7 + core Media Library).
No settings form, no configure route (`configure: null`), no permissions, no Drush, no config of
its own. Everything is configured through **Linkit profiles** and **text formats**.

- **Text format / Linkit profile setup, allowed HTML, drush recipes** →
  [configure/enable-in-format.md](configure/enable-in-format.md)
- **How the plugin and the media-library opener work, inserted markup** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- CKEditor 5 plugin id: `linkit_media_library_link`; it is **conditional on** the
  `linkit_extension` CKEditor 5 plugin being enabled on the format.
- Requires the format's `linkit` **filter** ("Linkit URL converter") to be enabled — both the
  dynamic plugin config and the opener's `checkAccess()` check it.
- Requires the format's Linkit profile to contain an **`entity:media` matcher**; the module's
  `hook_install()` adds one to the `default` profile if missing.
- Media library opener service id: `linkit_media_library.opener.editor`
  (`Drupal\linkit_media_library\LinkitMediaLibraryEditorOpener`).
- Inserted markup always includes `target="_blank"` plus `data-entity-type="media"`,
  `data-entity-bundle`, `data-entity-uuid`, `data-entity-substitution`, `href="/media/<id>"`.

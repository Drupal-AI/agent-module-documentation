<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Atoms Media Library (atoms_media_library) — agent index

**Atoms submodule that adds a `media` atom value-type backed by the Media Library widget.**

- **Version:** 1.1.x · **Core:** ^10 || ^11
- **Depends on:** `atoms`, core `media_library`, contrib `media_library_form_element`.
- **Provides:** one plugin `Plugin/Atoms/Media` (a `Media` atom type); no routes, no permissions of its own — inherits Atoms' admin routes (`/admin/content/atoms*`) and permissions.
- **Use:** define a media-typed atom (`*.atoms.yml` / `hook_atoms_alter()`), editors pick media at `/admin/content/atoms`, render via `{{ atom('name') }}`.
- **Security:** no own routes or endpoints; access governed entirely by the parent Atoms module's permission-gated admin UI.

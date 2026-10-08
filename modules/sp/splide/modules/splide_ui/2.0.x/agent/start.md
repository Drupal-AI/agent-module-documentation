<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Splide UI — agent index

Admin UI for the parent **Splide** module: create/edit/duplicate/delete `splide` optionsets and edit
the module's global settings. All gated by the `administer splide` permission.

- **The `administer splide` permission** → [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Depends on `splide`. `configure` route: `entity.splide.collection` → `/admin/config/media/splide`.
- Routes (all require `administer splide`): `entity.splide.collection` (list),
  `splide.optionset_page_add` (`/add`), `entity.splide.edit_form` (`/{splide}`),
  `entity.splide.duplicate_form` (`/{splide}/duplicate`), `entity.splide.delete_form`
  (`/{splide}/delete`), and `splide.settings` (`/ui`, the `splide.settings` config form).
- Forms: `SplideForm` (add/edit/duplicate), `SplideDeleteForm`, `SplideSettingsForm`;
  `SplideListBuilder` for the collection.
- Has **no** config schema, plugins, or Drush of its own — it manages the parent's `splide`
  optionset entity and `splide.settings` config.
- The optionset entity/fields and `splide.settings` are documented with the parent:
  [../../../../2.0.x/agent/configure/optionsets.md](../../../../2.0.x/agent/configure/optionsets.md).

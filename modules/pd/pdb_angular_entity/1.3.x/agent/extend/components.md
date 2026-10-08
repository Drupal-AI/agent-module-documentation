<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Angular components as blocks / view displays

- Any PDB component declared with `presentation: angular` is auto-discovered; `PdbAngularBlockDeriver` derives a block (`PdbAngularBlock`, id `pdb_angular_entity_component:<component>`) per component.
- The block renders the component's Angular custom-element tag and passes configuration via `drupalSettings`, so the `@angular/elements` component self-bootstraps client-side.
- `PdbAngularViewDisplay` (service `pdb_angular_entity.view_display`) provides an Angular-based entity view display.
- Example components live under `ng_component/` (`site_info_component`, `article_component`).
- Settings: `/admin/config/pdb_angular_entity/settings` (`administer site configuration`).

Place the derived blocks in regions, or select the Angular display for an entity view mode, to progressively decouple parts of a page.

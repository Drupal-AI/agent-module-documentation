<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PDB Angular Entity (pdb_angular_entity) — agent index

**Angular view mode for entities + PDB Angular components exposed as blocks via @angular/elements.**

- **Version:** 1.3.x (1.3.0)
- **Core:** ^10.2 || ^11 || ^12
- **Dependency:** pdb:pdb
- **Configure:** `/admin/config/pdb_angular_entity/settings` (`administer site configuration`)
- **Services:** `pdb_angular_entity.view_display` (`PdbAngularViewDisplay`), OOP hooks `PdbAngularEntityHooks`.
- **Plugins:** `PdbAngularBlock` (+ `PdbAngularBlockDeriver`) derive a block per discovered Angular component.

**Security:** Single admin settings route (`administer site configuration`); no anonymous or mutating endpoints. Block placement/rendering follows core block access. See [extend/components.md](extend/components.md)

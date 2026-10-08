<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PDB File Viewer (pdb_file_viewer) — agent index

**File-field formatter that renders molecular structure files (PDB/CIF/MOL2/…) with the NGL Viewer JS library.**

- **Version:** 1.1.x (1.1.0-beta1)
- **Core:** ^10 || ^11
- **Configure:** `/admin/config/user-interface/pdb_file_viewer` (`administer site configuration`) — supported extensions, allow-all, CDN vs local.
- **Formatter:** `PDBFileViewer` (id `pdb_file_viewer`, file fields); per-display settings show_file_link/show_file_size/max_file_size/return_empty.

**Security:** No path traversal / arbitrary file read — the file comes from a managed file entity via `getEntitiesToView()` (core file access enforced); the file URL is public and the computed `realpath()` is not used to read files server-side. Notes: default NGL library is loaded from a third-party CDN (`unpkg.com`) — supply-chain/privacy; use the local option to harden. Config route is permission-gated. See [configure/formatter.md](configure/formatter.md)

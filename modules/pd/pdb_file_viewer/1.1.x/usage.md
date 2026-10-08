<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
PDB File Viewer is a file-field formatter that displays molecular structure files using the NGL Viewer library.

---

The formatter (`src/Plugin/Field/FieldFormatter/PDBFileViewer.php`) renders a `<div id="viewport">` and attaches the NGL library plus `drupalSettings` (filename, file URL, extension) so NGL can load and draw the structure client-side. It supports formats such as pdb, ent, cif/mmcif, gro, pqr, mol2, sdf and mmtf. Per-display settings let you also show the file name as a link and/or the file size, cap rendering by a maximum byte size, and (with the fallback_formatter module) return nothing when the format is unrecognized. A global settings form (`/admin/config/user-interface/pdb_file_viewer`, `administer site configuration`) chooses the supported extension list, an "allow all extensions" switch, and whether to load NGL from a CDN (`https://unpkg.com/ngl@0.10.4/...` by default) or a local copy.

Security-relevant notes for operators: the file rendered is a managed file entity obtained via `getEntitiesToView()`, so file access is enforced by core and the file path is not request-controlled — there is no path-traversal or arbitrary-file-read vector (the computed `realpath()` is not used to read files server-side; NGL fetches the public file URL client-side). One thing to be aware of: by default the JS library is loaded from a third-party CDN (supply-chain/privacy consideration — switch to the local copy for hardened sites). Typical setup: choose the formatter on a file field, set the extension list and CDN/local option.

---
- Render a protein structure from a PDB file
- Display CIF/mmCIF crystallography files
- Show MOL2 or SDF chemical structures
- Add an interactive 3D molecular viewer to a file field
- Show the file name as a download link alongside the viewer
- Display the file size
- Cap rendering to a maximum file size
- Return nothing for unrecognized formats (with fallback formatter)
- Restrict which extensions are treated as viewable
- Allow all extensions when needed
- Load the NGL library from a local copy instead of the CDN
- Present research datasets on a repository site
- Embed structure viewers in a science publication
- Let users preview uploaded structure files in-page
- Combine the viewer with a plain download link
- Configure supported extensions globally

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FilePond — agent index

Integrates the **FilePond** JS upload library (drag-and-drop uploads + previews; crop/entity-browser/Views/
benchmark submodules). Depends on core `file`; provides permissions. Version **1.0.0-alpha5**. Core
`^10.2||^11`.

Content-editing/upload — uploaded files are managed files (normal file access); security rests on Drupal's
**server-side** upload validation (allowed extensions/size), not the client widget. Keep extensions
restricted. No access role.

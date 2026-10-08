<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Tamper Bin to File provides a Feeds Tamper plugin to convert binary field data into Drupal file references.

---

Tamper Bin to File **converts binary field data into Drupal file references** — a Feeds Tamper plugin that
takes binary content from a feed and saves it as a managed file, referencing it, during import. It depends on the
Tamper module.

Use it to turn imported binary data into files. It is an import/data-transformation feature. Data-handling note:
saving imported binary as files means **externally-sourced content becomes managed files** — ensure the source is
trusted, validate resulting file types/extensions, and store under an appropriate scheme so untrusted binaries
aren't served unsafely. It has no access-control role. Configure the Tamper plugin.

---

- Convert binary fields to file references.
- Save imported binary as managed files.
- Reference the files.
- Depend on the Tamper module.
- Serve import/transformation.
- Handle binary feed data.
- Turn external content into managed files.
- Validate resulting file types/extensions + trust the source.
- Store under an appropriate scheme (untrusted binaries).
- Have no access-control role.
- Configure the Tamper plugin.
- Handle bin-to-file.
- Convert binary.
- Configure the plugin.
- Save files.
- Handle the import.
- Create files.
- Reference files.
- Validate types.
- Provide bin-to-file conversion.

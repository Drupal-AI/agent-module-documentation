<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
File Metadata PDF provides a file metadata plugin for PDFs.

---

File Metadata PDF provides a **File Metadata Manager (file_mdm) plugin that reads metadata from PDF files** —
extracting PDF properties (page count, dimensions, title/author, etc.) so other modules can use them. It depends
on the File Metadata Manager module, in the File metadata package (core 11.2+).

Use it to read PDF metadata. It is a media/developer feature. Data-handling note: it **parses PDF files**
(uploaded/managed files are untrusted input — rely on the parser handling malformed files; parse in a
trusted/updated environment), and PDF files follow core file access. It has no access-control role. Enable it so
file_mdm can read PDF metadata.

---

- Read PDF file metadata.
- Extract page count/dimensions/title.
- Provide a file_mdm plugin.
- Depend on File Metadata Manager.
- Serve media/developers.
- Expose PDF properties.
- Parse PDF files (untrusted input).
- Parse in a trusted/updated environment.
- Follow core file access.
- Have no access-control role.
- Enable it for PDF metadata.
- Handle PDF metadata.
- Read metadata.
- Configure nothing (plugin).
- Extract metadata.
- Handle the files.
- Parse PDFs.
- Get PDF data.
- Handle untrusted files.
- Provide PDF metadata.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
PB Import imports content and creates nodes/paragraphs from a source.

---

PB Import **imports content to create nodes and paragraphs** — reading from a source (file) and building
structured node/paragraph content, useful for bulk content creation or migrating page-builder content. It
depends on Paragraphs, Entity Reference Revisions and many core content modules, ships `pb_import_node` and
`pb_import_para` submodules, in the Paragraphs package.

Use it to bulk-create node/paragraph content from a source. It is an import/content feature run by privileged
users. Security/data handling: it **processes an external source file** and creates content, so validate the
input and apply **safe text formats** to imported markup (imported HTML should not be trusted into a permissive
format), and run it as a trusted operator. It has no access-control role. Configure the import source and
mapping.

---

- Import content as nodes/paragraphs.
- Read from a source file.
- Bulk-create structured content.
- Depend on Paragraphs and Entity Reference Revisions.
- Ship node/para submodules.
- Serve bulk content creation.
- Process an external source file.
- Validate input and apply safe text formats.
- Run it as a trusted operator.
- Have no access-control role.
- Configure the import source/mapping.
- Handle content import.
- Create nodes/paragraphs.
- Configure the import.
- Import content.
- Handle the source.
- Build content.
- Import structured content.
- Set the mapping.
- Provide content import.

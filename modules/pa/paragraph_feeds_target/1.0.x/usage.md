<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Paragraph Feeds Target provides a Feeds target plugin that maps feed values into paragraphs.

---

Paragraph Feeds Target provides a **Feeds target plugin that maps imported feed values into paragraphs** —
so a Feeds import can populate a paragraph-reference field (building structured paragraph content from feed
data). It depends on Feeds, Paragraphs and Entity Reference Revisions, in the Custom package.

Use it to import feed data into paragraphs. It is an import/content feature run during Feeds imports. Security
note: it processes **external feed data** into paragraph content — validate the source and apply **safe text
formats** to imported markup (imported HTML shouldn't land in a permissive format). It has no access-control
role. Configure the paragraph target on a feed type.

---

- Map feed values into paragraphs.
- Provide a Feeds target plugin.
- Build paragraph content from feeds.
- Depend on Feeds/Paragraphs/ERR.
- Populate paragraph-reference fields.
- Serve content import.
- Process external feed data.
- Apply safe text formats to imports.
- Validate the source.
- Have no access-control role.
- Configure the paragraph target.
- Handle paragraph import.
- Import to paragraphs.
- Configure the target.
- Map to paragraphs.
- Handle the import.
- Build paragraphs.
- Import feed data.
- Set the target.
- Provide a paragraph Feeds target.

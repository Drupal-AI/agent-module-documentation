<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WissKI XML Adapter reads entity information from an XML file.

---

Cultural heritage runs on XML. TEI for texts, EAD for archival finding aids, LIDO and CIDOC-CRM XML for object records, METS/MODS for digitised material — a great deal of the sector's data exists as XML files rather than in a database.

This adapter reads such a file as a data source, so its content is available through SALZ alongside everything else rather than needing conversion first.

The practical value is for material that is authoritative as XML and should stay that way: a TEI edition maintained by a scholarly project, an EAD finding aid that is the archive's record of itself. Converting those into another system creates a second copy that will diverge; reading them keeps one authoritative version.

**Ships under the project's `legacy/` directory**, so check what a current project should use. Whatever the mechanism, the underlying question is the same: whether the XML is the record of truth (read it) or a delivery format (import and move on).

---

- Read entity data from an XML file.
- Use a TEI edition as a data source.
- Read an EAD finding aid.
- Work with LIDO object records.
- Avoid converting authoritative XML.
- Keep one authoritative version.
- Combine XML data with a triple store.
- Decide whether XML is truth or delivery.
- Read METS/MODS metadata.
- Check its legacy directory status.
- Find the current recommended path.
- Plan a mixed-source data architecture.
- Audit which sources a project reads.
- Reference scholarly XML from records.
- Document the XML source's role.
- Check the file's maintenance owner.

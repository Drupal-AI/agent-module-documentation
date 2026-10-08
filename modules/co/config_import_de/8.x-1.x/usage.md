<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config Import Delete Entities deletes content entities that a configuration import detects as orphaned by the config change (e.g. content of a deleted content type).

---

When a config import removes something that content depends on — a deleted content type, a removed field — the dependent content can be left orphaned or block the import. Config Import Delete Entities handles that by deleting the affected content entities during import. The security-relevant fact is that this DELETES CONTENT as a side effect of a config import: a config change (removing a content type) triggers deletion of all content of that type. That is powerful and potentially destructive, so config imports that touch content-bearing config must be reviewed with this in mind — an import that removes a field or type will now also delete the associated content, irreversibly. Run config imports deliberately, review what a given import will delete, and keep backups, especially on production. It solves a real import-blocking problem but does so by deleting content, which must be an understood consequence.

---

- Delete orphaned content on config import.
- Handle content of a deleted type.
- Unblock a config import.
- Clean up dependent content.
- Understand imports now delete content.
- Review config imports for deletions.
- Keep backups before importing.
- Run imports deliberately.
- Handle removed-field content.
- Confirm what will be deleted.
- Avoid unexpected content loss.
- Treat config import as content-affecting.
- Enable when needed.
- Keep disabled otherwise.
- Restrict administration.
- Confirm on your site.
- Test before production.
- Review configuration.
- Pair with related modules.
- Verify theme fit.
- Match your use case.
- Confirm compatibility.
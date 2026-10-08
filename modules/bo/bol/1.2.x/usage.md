Bill of Lading (bol) adds a single Drush command that prints a consolidated inventory ("bill of lading") of a Drupal site's entity types, bundles, and configurable fields.

---

Bill of Lading is a developer/site-audit tool, not a shipping or logistics module — "bill of lading" is used as a metaphor for a site manifest. Enabling the module registers one Drush command, `bol:report` (alias `bol`), implemented by `Drupal\bol\Drush\Commands\BolCommands::report()`. The command walks every entity type definition via the `entity_type.manager` service; for each type it lists the bundles (content types, vocabularies, media types, block types, paragraph types, etc.) and, for content entity bundles, enumerates every non-base configurable field with its required/optional status via `entity_field.manager`. Results are returned as a Drush `RowsOfFields` structure with columns Entity, Name, ID, Status, and Description, so the output can be rendered in any Drush output format (`--format=table|json|yaml|csv|…`). The module has no UI, no routes, no permissions, no configuration, and no runtime dependencies beyond Drush; it reads only the site's own entity/field definitions and produces read-only output.

---

- Produce a one-command inventory of everything on a Drupal site for an architecture review.
- List all content types (node bundles) and their fields in a single table.
- Enumerate every entity type registered on the site, including bundleable and non-bundleable types.
- Audit which fields on a bundle are required versus optional.
- Export the site structure as JSON for tooling: `drush bol --format=json`.
- Export the site structure as YAML: `drush bol --format=yaml`.
- Export the site structure as CSV for a spreadsheet: `drush bol --format=csv`.
- Generate a quick manifest of vocabularies and their machine names.
- Generate a list of media types configured on the site.
- List block types (custom block bundles) and their descriptions.
- List paragraph types when the Paragraphs module is installed.
- List Group module bundles (group types, roles, relationship types) when Group is installed.
- Document image styles, filter formats, views, webforms, and workflows in one report.
- Hand a new developer a single command to understand an unfamiliar site's data model.
- Capture a before/after snapshot of site structure around a deployment or migration.
- Feed the JSON output into a diff to detect unexpected structural drift between environments.
- Build a checklist of fields to migrate when planning a content migration.
- Confirm that expected bundles and fields exist after a config import (`drush cim`).
- Attach a site-structure manifest to project documentation or a handover package.
- Quickly see which entity types on the site are content entities (they show fields) versus config entities.
- Verify custom entity types added by other modules appear with the expected bundles.
- Run `drush help bol` to see the command syntax and available output-format options.

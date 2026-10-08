# acquia_contenthub_publisher — agent start

Makes the site a **publisher (source)** for Acquia Content Hub. Entity changes are enqueued to
the export queue, serialized to CDF (with `depcalc` dependency resolution), and pushed to the
service. Requires `acquia_contenthub` + `views`. No standalone permission (uses the base
`administer acquia content hub` / Content Hub UI access checks).

- Export queue, exclude entity types/bundles, single-entity push, Drush → [configure/export.md](configure/export.md)

Key Drush: `acquia:contenthub-export-queue-run`, `acquia:contenthub-audit-publisher`,
`acquia:contenthub-audit-entity`, `acquia:contenthub:reoriginate`,
`acquia:contenthub-publisher-upgrade`.

# acquia_contenthub_subscriber — agent start

Makes the site a **subscriber (destination)** for Acquia Content Hub. Webhooks enqueue
incoming CDF to the import queue; processing unserializes entities with `depcalc`-resolved
dependencies and records them in the subscriber tracker. Requires `acquia_contenthub`. Uses
the base Content Hub UI access checks (no standalone permission).

- Import queue, webhook interests/filters, syndication toggle, Drush → [configure/import.md](configure/import.md)

Key Drush: `acquia:contenthub-import-queue-run`, `acquia:contenthub-enqueue-by-filters`,
`acquia:contenthub:enable-syndication` / `:disable-syndication`,
`acquia:contenthub-audit-subscriber`, `acquia:contenthub-subscriber-upgrade`,
`acquia:contenthub-import-local-cdf`, `acquia:contenthub-webhook-interests-purge`.

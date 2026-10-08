<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DRD Migrate imports a legacy DRD 7 site inventory (JSON) into this DRD dashboard via a single Drush command.

---

This submodule of Drupal Remote Dashboard provides a one-shot importer to move a fleet from an old DRD 7 dashboard onto a current (Drupal 10/11) one. You export your DRD 7 inventory to a JSON file (a map of cores, each with its domains: URL, SSL flag and a one-time token), then run the `drd:migratefromd7` Drush command against that file. The `Import` service reads the JSON, and for each core creates a `drd_core` and, for each of its domains, finds-or-creates a `drd_domain` (seeding auth/crypt defaults for new ones), pushes the domain's one-time token to its remote DRD Agent (`Domain::pushOTT()`), and — on success — resolves or creates the host, pulls core info from the remote, marks the domain installed and links it to its core. It runs as user 1. The module ships only this Drush command and its import service (no UI, routes or permissions). Requires the DRD base module.

---

- Migrate an entire DRD 7 managed-site inventory into a fresh DRD 10/11 dashboard in one command.
- Recreate `drd_core` entities from an exported JSON inventory.
- Recreate `drd_domain` entities (URL, SSL, port) for every site under each core.
- Re-establish each site's dashboard connection by pushing its one-time token to the remote DRD Agent.
- Auto-seed authentication (`shared_secret`) and `OpenSsl` encryption defaults for newly created domains.
- Find or create the correct `drd_host` for each migrated core.
- Pull remote core info (Drupal root and version) during import via the base RPC.
- Mark successfully connected domains as installed and link them to their core.
- Run the import non-interactively from CI or a deploy script (`drush drd:migratefromd7 <file>`).
- Use the `drd-migrate-from-d7` alias for the same command.
- Bootstrap a new dashboard without manually re-registering each remote site.

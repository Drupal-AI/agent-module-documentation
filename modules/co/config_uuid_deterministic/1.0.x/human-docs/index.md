# Config UUID Deterministic — manual setup guide

**Config UUID Deterministic** (`config_uuid_deterministic`) makes the UUIDs in your
exported configuration **predictable and stable across environments**, instead of the
random UUIDs Drupal normally assigns. When configuration is created on different
sites — through a clean install, a migration, or generated config — each site
normally stamps a fresh random UUID onto every config object. That is exactly what
causes the familiar UUID-mismatch conflicts when you try to reuse or import that
configuration elsewhere.

This module replaces that randomness with **deterministic UUID v5 hashes** derived
from the configuration's name and a fixed namespace UUID. Because the UUID is a hash
of the config name, exporting the same config object always produces the same UUID —
so `admin_toolbar.settings.yml`, for example, exports with an identical UUID on every
site. That eliminates "UUID churn" in version control and makes clean installs and
generated configuration consistent across environments. It handles nested plugin
instances (like image effects and filters) with hierarchical UUID generation, and it
is careful to *skip* UUID remapping for field-storage configs with long names that
would otherwise break Drupal's hashed table-name resolution — preserving database
integrity.

There is nothing to configure: once the module is enabled, `drush config:export` and
core's export functionality automatically use deterministic UUIDs. Under the hood it
extends Drupal's file and database storage to intercept read and write operations,
and it uses the Ramsey UUID library (managed automatically via Composer) to generate
RFC 4122–compliant v5 hashes. It depends only on core's System module. This is a
developer and devops tool that affects config *identity* only — it has no content or
access-control role. Enable it early, before you create the configuration you want to
keep in sync, so those items get deterministic UUIDs from the start. This is the
1.0.3 release for core 9.4, 10, or 11; it is not covered by Drupal's security
advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

The module has **no settings form and no admin page** — it works automatically once
enabled, so there is no configuration page.

## How to use it

1. Enable the module **early** in a project's life, before creating the configuration
   you intend to synchronize (see [Installation](installation/index.md)).
2. Export your configuration as usual with `drush config:export` (or core's export
   UI). The exported files now carry deterministic, name-derived UUIDs.
3. Because the same config name always yields the same UUID, you can reuse and import
   that configuration across environments without UUID-mismatch conflicts, and your
   version-control diffs stop showing pointless UUID changes.

### Existing sites: normalize once

New configuration created after enabling gets deterministic UUIDs automatically, but
configuration that already exists keeps its original random UUIDs until you convert it.
The module ships a Drush command for that one-time backfill:

```bash
drush cud:normalize --dry-run   # preview what would change
drush cud:normalize             # rewrite existing config UUIDs (active storage)
drush cud:normalize --include-sync   # also rewrite the config/sync files
```

The command is idempotent (running it again changes nothing) and deliberately never
touches `system.site` or field-storage configs whose database tables would break.
Export and commit your config first, then re-export and review the diff afterwards —
it should show only UUID changes.

Advanced users can customize the namespace UUID (the module ships with a default of
`00000000-0000-0000-0000-000000000000`) by changing the `NAMESPACE` constant in the
module's classes for a project-specific implementation. It pairs well with
Config Split, Config Filter, and Config Ignore in a broader config-management
workflow.

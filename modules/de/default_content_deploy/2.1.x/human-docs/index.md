# Default Content Deploy — manual setup guide

**Default Content Deploy** (`default_content_deploy`) exports and imports
*content* between Drupal environments — nodes, taxonomy terms, media, users and
their relationships — so you can move a defined set of content from, say, a
staging site into production and keep doing it continuously rather than as a
one‑off. It is often shortened to "DCD".

Drupal's configuration management already moves *config* between environments,
but content is deliberately left out — and yet some content really behaves like
configuration: the front‑page nodes, a standard taxonomy, the demo or seed
content a site ships with. Moving that by hand, or by copying the whole
database, is crude and gives you no way to review what changed. DCD treats
content as something you export to files (which you can keep in Git) and import
elsewhere, correcting entity IDs automatically and preserving references through
each entity's UUID. Note that it does **not** depend on the core Default Content
module — it is a separate approach — and it relies on core's **HAL** module for
serialization.

Most of the work is done through Drush commands (`drush dcde`, `dcder`,
`dcdes`, `dcdi`), though an import can also be triggered from the administration
interface. There is one setting you will usually want to add in `settings.php`
— where the exported content directory lives — and two permissions,
`default content deploy export` and `default content deploy import`, that
control who may run those operations. Treat the import permission with care: an
import **writes and can overwrite entities** on the target site, so on
production that capability belongs to a trusted deployment process, not a
broadly granted role. An optional submodule,
**Search API Default Content Deploy** (`search_api_default_content_deploy`),
leverages Search API to track content changes and drive "continuous content
export streams".

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and (optionally) enable the Search API submodule.
2. [Configuration](configuration/index.md) — set the content directory in
   `settings.php`, the Drush command reference, and how imports work.

## Where it lives in the admin menu

DCD has no single central settings form of its own; its content directory is set
in `settings.php` (see [Configuration](configuration/index.md)) and its main
workflow runs through Drush. An import can additionally be run from the
administration interface. The two permissions are managed on the standard
**People → Permissions** page (`/admin/people/permissions`) — search for
"default content deploy".

## How to use it

The typical cycle is: on the source environment run an export command to write
content JSON files into your content directory, commit those files to Git (or
otherwise ship them), then on the target environment run `drush dcdi` to import
them. Imports are matched by UUID, so an entity is created if new or updated if
it already exists — and by default only if the imported version is newer.
See [Configuration](configuration/index.md) for the full command list and the
import rules.

# Bibcite Import OAI — manual setup guide

**Bibcite Import OAI** (`bibcite_import_oai`) harvests bibliography references
from **OAI-PMH repositories** — such as DSpace or OpenAIRE-based institutional
repositories — and turns them into Bibcite Reference entities on your site. It
solves the problem of populating a Bibcite bibliography from an external
publications repository without re-entering everything by hand.

An administrator stores one or more OAI *ListRecords* URLs on the module's
settings form. When you run an import, the module fetches each URL server-side,
parses the returned Dublin Core (`oai_dc`) XML, and creates a
`bibcite_reference` for each record — along with the contributor (author) and
keyword entities each record references, reusing existing ones where they
match. An optional "Update daily" flag re-runs the import from cron each night.

It depends on the Bibcite module and lives in the Bibliography & Citation
package. Imports can be triggered from an admin form or from a Drush command.

**Data and access notes, honestly:** the repository URLs are admin-supplied and
validated as well-formed URLs before saving; there is no public endpoint that
fetches an arbitrary user-supplied URL, so the server-side fetch is admin-only.
Fetches use cURL with TLS peer verification left at its (enabled) default and a
600-second timeout, following redirects. No credentials are needed for public
OAI endpoints, so there is no secret to store. One caveat worth knowing: the
module's routing references its permission by a human-readable title rather than
its declared machine name (`import from oai`), so on some releases the admin,
config and import routes can **fail closed** (access denied) until that is
corrected upstream — keep it in mind if the pages appear inaccessible despite
granting the permission.

This guide is written for a **human** clicking through the admin UI. If you
want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and grant the OAI import permission.
2. [Configuration](configuration/index.md) — add repository URLs, run an import,
   and optionally schedule nightly harvests.

## Where it lives in the admin menu

- **Settings (repository URLs):** `/admin/bibcite_import_oai/config`
  (`bibcite_import_oai.admin_settings`) — add the OAI ListRecords URLs and the
  daily-update option.
- **Run an import:** `/admin/oai-import/import` — tick which configured URLs to
  import and start the batch.

You can also run an import from the command line with
`drush oai-import:import --url="…"`.

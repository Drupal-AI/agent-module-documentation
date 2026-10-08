# Bibcite Crossref — manual setup guide

**Bibcite Crossref** (`bibcite_crossref`) adds **DOI lookup via Crossref** to
the Bibliography & Citation (Bibcite) module. Rather than typing every field of
a citation by hand, you can enter a publication's DOI and have the module fetch
that reference's metadata from Crossref and use it to auto-populate a citation.
It depends on Bibcite and Bibcite Entity, and lives in the Bibliography &
Citation package.

**How your data leaves the site:** Bibcite Crossref makes outbound HTTPS
requests to the public **Crossref API** — the DOI (or query) you enter is sent
to Crossref, and the metadata Crossref returns is imported into your citation
entities. No API key or credentials are typically required for these lookups,
so there is nothing secret to store; just treat Crossref as an external
dependency that your site reaches over the network. Because the returned data
comes from an outside service, it is worth reviewing imported references before
publishing them.

This module has no admin settings page and no permissions or access-control
role of its own — the lookup is used inline while you are creating a reference.

This guide is written for a **human** clicking through the admin UI. If you
want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Once enabled, use the DOI lookup while adding a Bibcite reference: enter the
DOI, let the module query Crossref, and it fills in the reference's fields from
the returned metadata. Review the imported details and save. Because the request
goes to Crossref over the internet, the lookup needs the site to have outbound
HTTPS access.

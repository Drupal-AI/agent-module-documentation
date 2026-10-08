# Bibliography Citation PubMed — manual setup guide

**Bibliography Citation PubMed** (`bibcite_pubmed`) adds **PubMed import and
lookup** to the Bibliography & Citation (Bibcite) module. Academic and medical
sites that keep bibliographies can use it to pull reference metadata from
PubMed — the public database of biomedical literature — instead of typing each
citation by hand. It depends on Bibcite and Bibcite Entity.

**How your data leaves the site:** the module queries PubMed's **public API**
and imports the reference metadata it returns. PubMed reads typically need no
credentials, so there is nothing secret to store. Two practical things to keep
in mind: stay within PubMed's request rate limits, and — because the data comes
from an outside service — review or validate imported references before
displaying them.

The module has no dedicated admin settings page and no permissions or
access-control role of its own; the import/lookup is used while managing your
Bibcite citations.

Note this is a **beta** release (2.0.0-beta1); test it before relying on it in
production.

This guide is written for a **human** clicking through the admin UI. If you
want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Once enabled, use the PubMed lookup/import while working with Bibcite
references: look up a citation in PubMed and import its metadata to create the
matching Bibcite reference. Because the request goes to PubMed over the
internet, the site needs outbound HTTPS access; keep your usage within PubMed's
rate limits and check imported data before publishing it.

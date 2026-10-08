# Bibcite Import ORCID — manual setup guide

**Bibcite Import ORCID** (`bibcite_import_orcid`) imports a researcher's
publication list from **ORCID** — the researcher-identifier service — into the
Bibliography & Citation (Bibcite) module. Given an ORCID iD, it pulls that
researcher's works and creates the corresponding Bibcite citations, so you can
populate a publications listing from ORCID rather than entering each reference
by hand. It depends on the Bibcite module and provides its own permissions.

**How your data leaves the site, and credentials — honestly:** the module calls
the **ORCID API** over the network (HTTPS) and imports the data ORCID returns,
which you should treat as external content and review before publishing. Where
the ORCID API access it uses requires credentials or a token, those are secrets:
never hard-code them in code or commit them to configuration. Store the value in
an environment variable via DDEV — for example
`ddev dotenv set .ddev/.env --orcid-client-secret=<value>` (which becomes the
variable `ORCID_CLIENT_SECRET`), keep `.ddev/.env` out of version control, then
`ddev restart` so the container loads it. Public ORCID record reads generally do
not need credentials, so you may not need to store anything at all.

This module has no separate admin settings page documented; it provides
permissions to control who may run imports, but no access-control role beyond
that.

Note this is a release on the **2.0.x** branch (2.0.11) published under the
Omibee package.

This guide is written for a **human** clicking through the admin UI. If you
want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and grant its import permission.

## How to use it

After enabling the module, grant its ORCID-import permission at **People →
Permissions** (`/admin/people/permissions`) to the roles that should be able to
run imports. Then run an import for the ORCID iD whose publications you want,
and the module creates the matching Bibcite citations. Because the data comes
from ORCID over the internet, the site needs outbound HTTPS access, and it is
worth reviewing the imported references before making them public.

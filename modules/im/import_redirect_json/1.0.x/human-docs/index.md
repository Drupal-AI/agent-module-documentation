# Import redirect JSON — manual setup guide

**Import redirect JSON** (`import_redirect_json`) bulk‑loads URL redirects from a
JSON file into the [Redirect](https://www.drupal.org/project/redirect) module. When
you migrate or relaunch a site, you often have a big list of old‑URL → new‑URL
pairs to carry over so old links keep working. Rather than typing each one into the
Redirect UI, you upload a JSON file and this module creates the redirects for you in
one pass.

The clever part is the **field mapping**. Your JSON objects can use whatever key
names you like — `source_path`, `destination`, `status_code`, `language`, or names
of your own — and you tell the module once which key means what. From then on the
import form reads any file that follows that shape and shows you an example based on
your mapping. It depends on the Redirect module and on core's Database Logging
(so import activity is logged).

Because redirects control where URLs send visitors, treat this as a trusted‑admin
tool: restrict its permission to people you trust, and validate the JSON source
before importing — a bad or malicious redirect map could quietly send users to
unexpected or external destinations. The module acts with the privileges of
whoever runs the import.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Redirect.
2. [Configuration](configuration/index.md) — map your JSON keys, then run the
   import.

## Where it lives in the admin menu

The module lives under the Redirect module's admin area. You define your field
mapping at **Configuration → Search and metadata → URL redirects → Import redirect
JSON → Mapping**
(`/admin/config/search/redirect/import-redirect-json/mapping`), and you run imports
at `/admin/config/search/redirect/import-redirect-json`.

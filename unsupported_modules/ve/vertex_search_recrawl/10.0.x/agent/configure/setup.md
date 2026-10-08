<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Vertex AI Search Recrawl

## Google Cloud prerequisites
1. Enable the **Discovery Engine API** in a GCP project.
2. Create a **Vertex AI Search data store** of type *Website (Advanced)*.
3. Create a **service account** with the *Discovery Engine Editor* (or Admin) role
   and download its JSON key.
4. Place the JSON key on the server, ideally outside the web root or under
   `private://` (e.g. `/var/secrets/vertex-service-account.json`), readable by the
   web server user.

## Module settings
Path: `/admin/config/search/vertex-search-recrawl` (`administer site configuration`).
- **Enable Vertex Search Recrawl** — master on/off (`enabled`).
- **GCP Project ID** — e.g. `my-prod-web-0`.
- **Data Store ID** — the Vertex AI Search data store id.
- **Location** — usually `global`.
- **Service Account JSON Key File Path** — absolute path or `private://…`; the form
  validates the file exists, is readable, and is a valid key
  (`private_key` + `client_email` present).
- **Node Types** — check which bundles trigger a recrawl; leave all unchecked to
  trigger for every node type.

## Runtime
- Insert/update → recrawl request so Vertex reindexes the current content.
- Delete → recrawl of the now-404 URL so Vertex removes it from the index.
- Success is logged; the service returns FALSE and logs when disabled,
  misconfigured, the key file is unreadable, or the API call fails.

## Security
- Store the key as a **file path**, not pasted into config; keep the file out of
  the docroot. All Google calls use HTTPS with default TLS verification.

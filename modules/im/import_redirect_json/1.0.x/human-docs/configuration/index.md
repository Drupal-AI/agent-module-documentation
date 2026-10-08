# Configuration

Using the module is a two‑step flow: first tell it how to read your JSON (the
**mapping**), then upload a file to run the **import**.

## Step 1 — Map your JSON keys

1. Log in as a trusted administrator with the module's import permission.
2. Go to **Configuration → Search and metadata → URL redirects → Import redirect
   JSON → Mapping**, or navigate directly to
   `/admin/config/search/redirect/import-redirect-json/mapping`.
3. Map each redirect property to the key your JSON uses:
   - **Source path** — the old/incoming path (for example the `source_path` key).
   - **Destination** — where the redirect sends visitors (for example
     `internal:/node/{ID}` or an external URL).
   - **Status code** — the HTTP redirect code, typically `301` (permanent) or `302`
     (temporary).
   - **Language** — the language code the redirect applies to (for example `en`).
4. Save the mapping.

A JSON file matching a typical mapping looks like this:

```json
[
  {
    "source_path": "/from-url",
    "destination": "internal:/node/123",
    "status_code": "301",
    "language": "en"
  }
]
```

## Step 2 — Run the import

1. Go to `/admin/config/search/redirect/import-redirect-json`.
2. The form shows an example based on the mapping you saved, so you can confirm your
   file's shape matches.
3. Upload your JSON file and run the import. The module creates a Redirect entry for
   each object in the file.

## Before you import — safety checks

- **Restrict the permission.** Redirects decide where URLs send visitors, so only
  trusted administrators should be able to run imports.
- **Validate the source file.** Review the JSON before uploading — an erroneous or
  malicious map could send users to unexpected or external destinations. Spot‑check
  a few destinations after importing.
- **Import activity is logged** to the database log (Recent log messages), so you
  can review what an import did.

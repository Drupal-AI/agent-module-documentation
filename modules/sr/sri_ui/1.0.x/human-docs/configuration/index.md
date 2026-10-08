# Configuration

Subresource Integrity UI does nothing until you tell it which asset to protect
and generate its hash. That happens on one settings screen.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Web services → SRI**, or navigate directly to
   `/admin/config/services/sri`.

## Generate a hash for an asset

On the form, enter the asset's **full URL** in the required field and submit. The
module fetches the file, computes its SHA-256 hash, and stores it so the
`integrity` (and `crossorigin`) attributes can be attached to the matching asset
library.

As an alternative to the form, you can refresh the stored hashes from the command
line with the module's Drush command:

```bash
drush update-assets-hash256
```

## Make sure SRI actually helps rather than breaks the page

Two behaviors of SRI itself — not of this module — decide the outcome, and both
are easy to trip over:

- **`crossorigin` must be present, and the host must allow CORS.** The browser
  can only verify a resource it fetched in CORS mode from a host that sends
  permissive CORS headers. If either is missing, the browser refuses to load the
  file at all instead of just skipping verification. Test the page after
  applying SRI to confirm the asset still loads.
- **The hash pins one exact build.** As soon as the upstream file changes, its
  hash no longer matches and it stops loading. Pin versioned URLs where you can,
  and when you *do* need to move to a newer version of a library, treat updating
  the hash as a deliberate review step — that gate is exactly what SRI is buying
  you.

After entering a URL and submitting, reload a page that uses the asset and confirm
in your browser's developer tools that the script or stylesheet loads without an
integrity error.

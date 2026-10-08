# Configuration

The module does nothing until you tell it where to send the SBOM and give it a
licence key. Everything happens on one settings form.

## Open the settings form

1. Log in as a user with the **Administer Proofwright** (`administer proofwright`)
   permission.
2. Go to **Configuration → System → Proofwright**, or navigate directly to
   `/admin/config/system/proofwright`.

## The settings

- **Console URL** — the base URL of your Proofwright console. It **must** start with
  `https://`; if you enter a plain `http://` address the send is refused with the
  message "The console URL must use https." The only exception is a loopback host
  (`http://localhost` or `http://127.0.0.1[:port]`), which is allowed purely for local
  testing. The default is `https://console.proofwright.eu`. Point it at a self‑hosted
  console or the default EU console.
- **Licence key** — the key that authenticates your uploads. It is sent as a Bearer
  token in the `Authorization` header, over HTTPS only, so it is never transmitted in
  clear text. Keep it secret.

## Send the SBOM

With the URL and key saved, trigger a send from the form. The module builds a
CycloneDX 1.5 SBOM of core, contrib, and custom extensions and POSTs it to
`{console}/api/v1/sbom`. An unchanged inventory produces a stable serial number, so a
repeat send is recognised as identical rather than looking like drift.

You can also let the send run on **cron**, so your console always holds current
evidence. A good habit is to refresh the SBOM after each deployment or whenever you
add or update a module, since that is when your software composition changes.

## Save

Click **Save configuration**. Because a valid link and key are all that is required,
the module is ready to send as soon as the form is saved.

# Configuration

Site Version needs a little configuration to be useful — you set the version and
build values yourself, and decide whether to expose them as JSON.

## Open the settings form

1. Log in as a user with the **`site_version admin`** permission.
2. Go to **Configuration → System → Site Version**, or navigate directly to
   `/admin/config/system/site-version`.

## The settings form

On the settings form you can set:

- **Version** — the human‑set version string for this environment (for example a
  release tag or semantic version).
- **Build** — a build number, typically bumped by your deploy pipeline.
- **Description** — free text describing the release.
- **Enable the JSON API** — a toggle that turns the `/site-version/json` endpoint
  on or off. It is **off by default**.
- **JSON API access key** — the 32‑character key generated on install. Callers
  must supply this exact value as an `api_key` query parameter to read the JSON.
  The form also displays the full API link so you can copy it. Treat this key as
  a secret and only give it to tooling you trust.

Saving the form updates the stored "changed" timestamp.

## Viewing the data

- **The page:** users with the `site_version view` permission can read the version
  table at `/site-version`.
- **The JSON endpoint:** `/site-version/json?api_key=<your-key>` returns the
  version, build, description, site name, UUID and core version — but *only* when
  the JSON API is enabled and the supplied key exactly matches the stored one.
  Otherwise it returns a structured error object rather than the data.

## Registering with a remote host (optional)

If you use the companion *Site Version Host* module to watch many sites from one
dashboard, the **Host Auto Configuration** form at
`/admin/config/system/site-version/host-autoconfig` (same `site_version admin`
permission) registers this site's endpoint with a remote host URL you enter. The
host URL is entered by an administrator, so this is not an attacker‑controllable
request — but only point it at a host you control.

## Save

Click **Save configuration**. Your changes take effect immediately.

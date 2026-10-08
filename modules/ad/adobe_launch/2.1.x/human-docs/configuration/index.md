# Configuration

## Open the settings form

Go to **Configuration → Web services → Adobe Launch**
(`/admin/config/services/adobe_launch/configure`). You need the **Administer site
configuration** permission.

## Enable and choose an environment

- **Enable Adobe Launch** — the master switch. Nothing is injected unless this is
  ticked.
- **Target environment** — which of your three script URLs to inject: **dev**,
  **staging**, or **prod**. (The stored default is *staging*.) This lets you keep
  all three URLs on file and flip between them with one selection — or override the
  choice per environment from `settings.php`.

## The environment script URLs

- **Production URL**, **Staging URL**, **Dev URL** — the Adobe Launch script URLs
  for each environment. Use **protocol-relative** URLs (starting with `//`), for
  example `//assets.adobedtm.com/launch-xxxxxxxx.min.js`, so the script matches the
  page's scheme. On save, each URL is validated as a real external URL, so malformed
  entries are rejected.
- **Registrant email** — an informational field for recording who owns the Adobe
  Launch subscription. It does not affect the injected tag.

## Loading options

- **Async** — add the `async` attribute to the script tag so it loads without
  blocking page rendering. Recommended, and on by default.
- **Initialize data layer** — attach a small library that sets up
  `window.digitalData = { events: [] }` and `window.DTM_DATA` **before** the Launch
  snippet runs, so your tags have a data layer to read. On by default.

## Path rules — where the snippet loads

Two settings work together to decide which pages get the tag:

- **Paths** — a list of path patterns, **one per line**, where `*` is a wildcard.
  The default list is:

  ```
  /admin
  /admin/*
  /node/*/edit
  ```

- **Include / exclude mode** — controls how that list is interpreted:
  - **Exclude** (default) — the snippet loads everywhere **except** the listed
    paths. With the default list, that keeps analytics off admin and node-edit
    pages so editorial activity doesn't skew your data.
  - **Include only** — the snippet loads **only** on the listed paths. Use this to
    scope the tag to one section, e.g. add `/products/*` and switch to include mode.

The current path is matched by both its alias and its internal path.

## Save

Click **Save configuration**. On the next page load, matching pages will carry the
selected environment's Launch script in the `<head>`.

## For developers

Other modules can override the per-request "should the snippet load here?" decision
by implementing `hook_adobe_launch_path_check_alter(&$result)` — see the sibling
[`agent/`](../agent/configure/settings.md) docs.

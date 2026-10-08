# PCI SRI — manual setup guide

**PCI SRI** (`pci_sri`) hardens your site by adding **Subresource Integrity (SRI)**
to the JavaScript assets provided by your modules and themes (both contrib and
custom). SRI works by attaching an `integrity` attribute — a cryptographic hash —
to each script tag, so the browser verifies that the file it downloaded exactly
matches the recorded hash **before executing it**. If a file has been tampered with
(for example by a compromised CDN or a man-in-the-middle), the browser refuses to
run it.

The module exists to help sites meet **PCI DSS** requirements 6.4.3 and 11.6.1
(effective 31 March 2025), which call for exactly this kind of script-integrity
control. It is a **positive security** feature: it does not change what your site
does, it just guarantees that the scripts running in visitors' browsers are the ones
you shipped.

There is no settings form to fill in. You generate the SRI hashes with a Drush
command, review them on an admin page, and regenerate them whenever a JavaScript
file legitimately changes so the hashes stay in sync.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   generate the initial SRI hashes.

There is **no configuration form**. Setup is a generate-and-review workflow,
described below.

## Where it lives in the admin menu

After you generate the hashes, review them at **`/admin/structure/sri`**. The main
action — generating (and later regenerating) hashes — is done with the
`drush sri-gen` command.

## How to use it

1. After enabling the module, generate the SRI configuration:

   ```bash
   drush sri-gen
   ```

2. Review the generated configuration at **`/admin/structure/sri`**.
3. Clear caches and view a page's source:

   ```bash
   drush cr
   ```

   You should see `integrity` attributes on the script tags. In the browser
   console, confirm no scripts are being blocked (a block means a hash mismatch).
4. **When a JavaScript file legitimately changes** (a module update, a code
   change), run `drush sri-gen` again to refresh the hashes — otherwise the browser
   will block the now-mismatched file.

> **Scope note:** this module does **not** add integrity attributes to Drupal core
> JavaScript, to *aggregated* JavaScript, or to cloud/CDN-hosted scripts. For
> externally hosted scripts, the separate `external_script_sri` module covers that
> case.

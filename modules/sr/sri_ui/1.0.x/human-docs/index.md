# Subresource Integrity UI — manual setup guide

**Subresource Integrity UI** (`sri_ui`) lets you add `integrity` and
`crossorigin` attributes to your site's asset libraries from a configuration
screen, without patching any module's code.

Subresource Integrity (SRI) is a browser security feature. When a page loads a
script or stylesheet from somewhere else — a CDN, a third-party host — you
normally have to trust that whatever comes back is what you expect. SRI lets you
pin a cryptographic hash of the exact file you reviewed; the browser fetches the
resource, hashes it, and refuses to run it if the hash does not match. That
protects you if a CDN is compromised, a host is hijacked, or a maintainer quietly
republishes a different build under the same URL — the tampered file simply will
not execute, and you get a clear signal instead of silently running unreviewed
code.

The catch is that the `integrity` attribute usually has to be declared in a
module's own `libraries.yml`, which a site cannot change without patching. This
module moves that decision to the site: you point it at an asset's URL, it
generates the hash, and it attaches the attributes for you. It works on Drupal 8
through 11, and the settings screen sits behind the **Administer site
configuration** permission. There are no dependencies and no submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — generate a hash for an asset and
   apply SRI attributes, plus the two things that decide whether SRI protects a
   page or breaks it.

## Where it lives in the admin menu

Once enabled, the settings screen is at **Configuration → Web services → SRI**
(`/admin/config/services/sri`). Enter an asset's full URL, submit the form, and
the module generates and stores the SHA-256 hash. There is also a Drush command,
`drush update-assets-hash256`, that refreshes the stored hashes.

## Two things to know before you turn this on

SRI is powerful but unforgiving, and both of these catch people out:

- **`crossorigin` is required for SRI to work at all.** The browser needs a
  CORS-mode fetch to inspect the response, and the host serving the file must
  send permissive CORS headers. If either is missing, the script *fails to load*
  entirely rather than merely failing verification — this is the most common way
  an SRI rollout accidentally takes a site down.
- **A hash pins one exact file.** When the upstream provider publishes an update,
  the old hash no longer matches and the script stops loading until you update
  the hash. That is the point, not a bug: pin versioned URLs, and treat a hash
  update as a deliberate review step.

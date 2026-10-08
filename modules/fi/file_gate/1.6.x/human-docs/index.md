# File Gate — manual setup guide

**File Gate** (`file_gate`) gates the delivery of **private files** behind
pluggable "gate methods" and streams them through its own signed endpoint. It is
built for decoupled and traditional Drupal alike: a trusted back end runs its own
gate (a lead form, a login, a purchase, a step-up authentication) and mints a
short-lived signed URL, and any front end redeems it — the bytes are delivered
only through File Gate, never through `/system/files`.

**The problem it solves.** Core's private file system grants an anonymous visitor
download access to a private file whenever any published entity that references it
is viewable. That is often too permissive for gated content, and it ties delivery
to your Drupal site's own access model — awkward when the front end lives
elsewhere. File Gate replaces that with an explicit, **deny-by-default** decision:
its `hook_file_download()` implementation returns a hard veto (`-1`) for any gated
private file requested at `/system/files`, unless the account holds an explicit
bypass permission. The file is instead streamed from a self-hosted signed
endpoint only after a gate method approves the request, so the private path is
never disclosed and delivery does not depend on anonymous file access.

Grants are **HMAC-signed**: a signer computes a signature over the resource id,
the claims, and a secret from a secret registry, with a short time-to-live, so a
link cannot be forged or reused past its expiry. Several gate methods ship in the
core module — short-lived **signed URLs** (with TTL, availability window, and
usage limits such as one-time links), **authenticated** delivery to a logged-in
user with an optional role allowlist, a revocable per-grant **token** method, a
**referrer lock** (defence in depth, not authorization), and an emailed
single-use **OTP**. Three more arrive as optional submodules (Form, Commerce,
Assurance) so the core module stays dependency-light.

Because it is security machinery, a few essentials matter: keep the files on the
**`private://` scheme** (public files bypass all gating), **store the signing
secret securely** (an environment variable, a Key entity, or the secret registry —
a leaked secret lets anyone mint valid links), use **short TTLs**, and serve over
**HTTPS**. It depends on core's **File** module and requires Drupal 11.4+.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and pick the optional submodules you need.
2. [Configuration](configuration/index.md) — choose a gate method per field, store
   the signing secret securely, and set TTLs and limits.

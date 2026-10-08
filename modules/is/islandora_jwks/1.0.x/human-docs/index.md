# Islandora JWKS — manual setup guide

**Islandora JWKS** (`islandora_jwks`) publishes a **JWKS (JSON Web Key Set)
endpoint** for the JWT tokens Islandora issues. It serves the **public verification
keys** at `/oauth/discovery/keys`, so other services — Islandora microservices, API
gateways, and the like — can fetch those keys and independently verify that a JWT
really came from your Islandora site.

The important security point is that a JWKS endpoint, by design, exposes **public
keys only**. The **private signing key never leaves the server**; it stays under the
control of the JWT module. Publishing the public key is exactly what enables
distributed verification without ever sharing the secret.

It depends on the **JWT** module (and is intended for use with **Islandora**). One
post-installation requirement: your JWT **public key** must be available to the
container at `/var/run/s6/container_environment/JWT_PUBLIC_KEY`. If you run your
Islandora site with **isle-buildkit**, this is handled for you automatically.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, make the JWT
   public key available, and enable the module.

There is **no settings form** for this module. Once the public key is in place and
the module is enabled, the JWKS endpoint is served automatically, described in "How
to use it" below.

## Where it lives in the admin menu

The module adds no admin configuration page. Its output is a machine endpoint, not a
UI: the key set is served at **`/oauth/discovery/keys`**.

## How to use it

1. Ensure the JWT **public key** is available at
   `/var/run/s6/container_environment/JWT_PUBLIC_KEY` (automatic with isle-buildkit).
2. With the module enabled, visit **`/oauth/discovery/keys`** — you should see a
   JSON Web Key Set containing your public verification key(s).
3. Point any service that needs to verify Islandora's JWTs at that JWKS URI. It will
   fetch the public key and validate tokens without ever needing your private
   signing key.

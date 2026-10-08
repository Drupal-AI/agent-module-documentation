# Multiaccess — manual setup guide

**Multiaccess** (`multiaccess`) provides lightweight, cross‑site single sign‑on
between related Drupal sites using **encrypted, server‑to‑server one‑time login
links**. The idea: a "source" site (where a user already has an account) can issue
a one‑time login link (ULI) that logs that user into a paired "destination" site —
creating the account there and assigning mapped roles if it does not yet exist.
It is designed for groups of related sites that should feel like one system to the
end user, without building a full authentication API.

It is deliberately minimal in its footprint. It has **no admin UI**, stores nothing
in the database, and does not use Configuration Manager. Instead, everything —
site UUIDs, URLs, RSA key pairs, and role mappings — lives in **unversioned local
settings files** and is driven with **Drush** helper functions. An optional
submodule, **Multiaccess ULI UI** (`multiaccess_uli_ui`), adds a "Remote sites" tab
to user accounts and a redirect route so users can jump to destination sites.

Because it uses per‑pair RSA key pairs, the security of the whole scheme rests on
keeping those keys — and the settings files that hold them — **out of version
control** and private to the paired sites. The project's own documentation stresses
this. Treat each source site as having full control over its destinations, and
review the trust model carefully before deploying it: within a site group, every
member is treated as equally trusted.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and set up integrations via settings files and Drush.

There is **no configuration UI or settings form** for this module — it is
configured entirely through unversioned settings files and Drush commands, covered
in the installation guide. The optional `multiaccess_uli_ui` submodule adds the only
web‑facing pieces (an account tab and a redirect route).

## Where it lives in the admin menu

Multiaccess itself adds **no admin page**. If you enable the `multiaccess_uli_ui`
submodule, users get a **Remote sites** tab at `/user/{user}/multiaccess`, and a
redirect route at `/multiaccess/redirect/{uuid}` sends a user to a paired
destination.

## How it is set up (in brief)

1. On each paired site, add the integration configuration (site UUIDs, URLs, RSA
   key pairs, role mappings) to **unversioned** local settings files.
2. Register a new destination integration with the Drush helper
   `multiaccess_new_integration()`.
3. Verify the pairing end‑to‑end with `multiaccess_selftest()`, and list
   configured destinations with `multiaccess_list()`.
4. Issue a one‑time login link programmatically via
   `integrationDestinationFactory()->fromDestinationUuid(...)->uli(...)`, or let the
   optional submodule's redirect flow do it for users.

See [Installation](installation/index.md) for the full sequence and the important
key‑handling cautions.

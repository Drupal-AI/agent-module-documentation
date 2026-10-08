# Persistent Identifiers Field Set — manual setup guide

**Persistent Identifiers Field Set** (`pid_field_set`) adds a field that lets
editors enter or mint a **persistent identifier** — a DOI, ARK, Handle, or UUID —
for a piece of content. It builds on the
[Persistent Identifiers](https://www.drupal.org/project/persistent_identifiers)
module and is aimed at research, library, and repository sites that need stable,
citable identifiers attached to their content.

You can use it two ways: editors can simply record an identifier that already
exists, or — if you configure the identifier **minters** first — the module can
mint a new one. Minting requires setting up the minter configuration before it
will work.

Administration of the module's settings is gated by the **Administer pid_field_set
configuration** permission, so grant that only to the roles that should manage
identifier minting. This is a beta release (`1.1.0-beta1`) and is not covered by
Drupal's security advisory policy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Persistent Identifiers dependency.

The module's minter settings are folded into "How to use it" below rather than a
separate page.

## Where it lives in the admin menu

The module adds a **field** you attach to content types, plus a settings form for
configuring the identifier minters. The maintainers point you to the settings via
**Help → Persistent Identifiers Field Set Module → Persistent id field set
settings**.

## How to use it

1. **Set up the minters (only needed if you want to mint new identifiers).** Go to
   **Help → Persistent Identifiers Field Set Module → Persistent id field set
   settings**, fill in the configuration for the identifier type(s) you want to
   mint (DOI, ARK, Handle, and so on), and click **Save configuration**. This
   requires the **Administer pid_field_set configuration** permission. If you only
   want editors to record identifiers that already exist, you can skip this step.
2. **Add the field.** On the content type that needs identifiers, go to **Manage
   fields → Add field** and add the persistent‑identifier field provided by the
   module.
3. **Create content.** Editors can now enter an existing identifier — or, when
   minters are configured, mint a new one — for each item.

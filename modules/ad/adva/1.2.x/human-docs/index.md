# Advanced Access (adva) — manual setup guide

**Advanced Access** (`adva`) is an entity-agnostic **access-control API**. Drupal
core has a powerful access-grants system, but historically it only applied to
nodes. Advanced Access generalizes that model — realms, grant IDs, and per-entity
access records — so it can work with *any* entity type: media, custom entities, and
more. It is a framework for building access rules, not a ready-made policy you
switch on.

It works through two kinds of plugins. **Access Providers** compute the grants a
user holds and the access records an entity gets — for example a provider that
grants access based on department, subscription, or ownership. **Access Consumers**
switch adva on for a particular entity type. A *basic* consumer only exposes
provider configuration (this is how the node submodule bridges back to core's
node-grant system), while an *overriding* consumer additionally takes over that
entity type's access handling and stores its grants in adva's own table. On the
settings page you choose which providers apply to each entity type, and saving
queues a rebuild of that type's access records.

Two submodules apply the API to real entity types out of the box: **adva_na** for
nodes and **adva_media** for media. A hidden **adva_example_provider** ships as a
reference implementation for developers writing their own provider.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the API,
   and pick the node/media submodules.
2. [Configuration](configuration/index.md) — the settings form, enabling providers
   per entity type, rebuilding access records, and the permissions.

## Where it lives in the admin menu

The settings form is at **Configuration → People → Advanced Access**
(`/admin/config/people/adva`), gated by the **Administer adva** permission. Grants
are stored in a dedicated `adva_access` database table.

## How to use it

Advanced Access does nothing visible until you enable a consumer (the `adva_na` or
`adva_media` submodule, or a custom one) and turn on at least one provider for it.
The built-in **anonymous** provider is a simple starting point. After you enable
providers and save, you rebuild the entity type's access records so the
`adva_access` table matches your new configuration. The step-by-step is in
[Configuration](configuration/index.md).

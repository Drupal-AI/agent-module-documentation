# TAPIS Tenant — manual setup guide

**TAPIS Tenant** (`tapis_tenant`) is the foundation of the TAPIS suite of modules
for Drupal. TAPIS (the science-gateway API platform) organises everything into
*sites* and *tenants* — every user, system, app and job belongs to a tenant, and
a site can host several tenants. This module lets a Drupal site administrator
connect existing TAPIS sites and tenants to Drupal, so that the other TAPIS
modules (Auth, Systems, Apps, Jobs) can create and manage resources inside the
right tenant. A single Drupal site can therefore span multiple TAPIS sites and
tenants.

TAPIS sites and tenants are modelled as custom content types in Drupal, so you
create and edit them the same way you create any node. The module depends on the
**Key** module (for storing tenant credentials securely), plus core **Node**,
**Field**, and **Content Moderation**.

There is no central settings form — you work through the TAPIS Site and TAPIS
Tenant content you create. Because a tenant record holds connection credentials
and secrets, this module (correctly) stores those through the Key module: keep
your keys in a secure provider such as an environment variable, never commit them
to code, and make sure Drupal talks to TAPIS over HTTPS.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and its dependencies.

## How to use it

After enabling, add your TAPIS connection by creating **Tapis Site** and **Tapis
Tenant** content (base URLs and the associated credentials, stored via a Key).
Once a tenant is defined, install TAPIS Auth and the other TAPIS modules on top of
it — they read the tenant configuration from here. Because this module handles
sensitive connection secrets, store every credential as a Key (backed by an
environment variable) rather than typing it into plain configuration.

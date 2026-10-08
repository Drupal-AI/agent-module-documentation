# TAPIS Systems — manual setup guide

**TAPIS Systems** (`tapis_system`) brings TAPIS *systems* into Drupal. In TAPIS, a
system is the combination of a user account and a server that can run compute jobs
or store data. With this module, Drupal users can create and manage TAPIS systems,
their credentials, and batch scheduler profiles inside any TAPIS site and tenant
connected to the Drupal site.

Systems and scheduler profiles are modelled as custom content types (**Tapis
System** and **Tapis System Scheduler Profile**), while system credentials are a
custom entity type. The module also builds two views on the user's profile page —
one listing the systems a user can reach, and one listing their system
credentials. It exposes a `TapisSystemProvider` service that other modules use to
perform system-level operations (create a system, update a credential, and so on).
It depends on **TAPIS Tenant**, **TAPIS Auth**, core **Node**, and **Views**.

A note on how access works: at the TAPIS API layer a system can be shared with a
whole tenant, but at the Drupal layer this module enforces finer-grained access
control (using Node Casbin) so the site can apply its own, more flexible rules. A
note on credentials: a system credential is a public/private key pair — the public
key is stored in Drupal, but the private key is **never** stored in Drupal; it is
kept securely inside TAPIS only. All TAPIS calls go out over the external TAPIS API
(egress) via TAPIS Auth, so keep credentials secured and connect over HTTPS.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and its TAPIS dependencies.

## How to use it

With TAPIS Tenant and TAPIS Auth already configured, enable this module and then
create **Tapis System** content to describe the compute/storage resources your
jobs will use, add **Tapis System Credential** entities for the accounts that
access them, and optionally define **Tapis System Scheduler Profile** content for
the module commands to run when launching jobs. Users see the systems and
credentials they can access via the two views added to their profile page.

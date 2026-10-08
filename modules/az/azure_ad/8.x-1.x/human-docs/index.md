# miniOrange Azure AD / B2C Synchronization — manual setup guide

**miniOrange Azure AD / B2C Synchronization** (`azure_ad`) keeps Drupal user
accounts and a Microsoft **Azure AD / Azure AD B2C** directory in step with each
other. Using the Microsoft **Graph API**, it can provision new Drupal users into
Azure, de‑provision (disable/remove) them, and import Azure users into Drupal —
so a corporate directory and your Drupal site share the same set of accounts. It
is a miniOrange product and supports Drupal 9, 10, and 11.

It is entirely admin‑configured, through a set of screens under
**Configuration → People → Azure AD**: a setup/overview wizard, forms for each sync
direction (Drupal → Azure and Azure → Drupal), attribute and role mapping,
automatic and manual/on‑demand provisioning, advanced settings, audit logs, and a
review step. The actual directory calls and OAuth token handling are performed by
its required companion module, **User Provisioning**
(`user_provisioning`). Every one of its own screens requires the **Administer site
configuration** permission.

Because it handles Azure client credentials (tenant, client ID, client secret),
store the secret securely — via a Key entity or environment variable, never in
plain configuration. As a commercial product, the interface also includes trial,
upgrade, and support screens that communicate with miniOrange, and some
functionality (real‑time sync, larger user volumes) is gated behind a paid plan —
review what the trial/support forms transmit before submitting them.

This guide is written for a **human** setting the module up. If you want terse,
token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (User Provisioning is required).
2. [Configuration](configuration/index.md) — register an Azure app, connect,
   choose a sync direction, map attributes/roles, and provision.

## Where it lives in the admin menu

All screens live under **Configuration → People → Azure AD** at
`/admin/config/people/azure_ad/*`, starting from the overview wizard at
`/admin/config/people/azure_ad/overview`. Every screen requires the **Administer
site configuration** permission.

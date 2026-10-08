# Domain Theme Switch — manual setup guide

**Domain Theme Switch** (`domain_theme_switch`) lets each domain on a Domain Access
site use its own front-end and admin theme, all managed from one simple form. If you
run several branded domains from a single Drupal install — country sites, microsites,
white-label partner domains — this is how you give each one a distinct look while
sharing the same content and codebase.

The module is essentially one admin form that lists every domain you have defined.
For each domain you tick an **Enable theme override** checkbox and choose a **site
theme** and an **admin theme** from your installed themes. Domains you leave unchecked
simply inherit the site-wide default theme. In the 3.x version the module stores
nothing of its own: it writes the per-domain theme choices as overrides of core's
`system.theme` into the configuration collection that the **Domain Configuration**
module manages, and Domain Configuration's standard override mechanism does the actual
theme switching — so there is no custom theme negotiator involved.

It works as soon as you enable it (alongside its required Domain modules); the form is
where you make your choices. It has no permissions of its own — access uses Domain
Access's **Administer domains** permission — and no Drush commands. If you are
upgrading from the 2.x version, its update hooks migrate your old per-domain theme
settings into the new override format and clean up an obsolete permission
automatically.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module
   (with its Domain dependencies).
2. [Configuration](configuration/index.md) — the per-domain theme form and how the
   overrides work.

## Where it lives in the admin menu

The one form is at **Configuration → Domain → Domain Theme Switch**
(`/admin/config/domain/domain_theme_switch/config`), guarded by the **Administer
domains** permission (which comes from Domain Access, not from this module).

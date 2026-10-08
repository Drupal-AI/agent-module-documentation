# Profile Manager — manual setup guide

**Profile Manager** (`profile_manager`) is a **helper module for people who build
and maintain Drupal installation profiles / distributions**. Its goal is to ease
the recurring headache of shipping one profile across many sites when different
sites need slightly different functionality. Its central idea is the **Optional
Module**: a piece of functionality that a site can turn on or off without forking
the profile.

Profile Manager provides the tooling around that idea. It makes it straightforward
for developers to define and configure Optional Modules; it lets you grant users
permission to enable those Optional Modules for their own site; and it manages the
Optional Modules' configuration. When an Optional Module's config changes, it can
import the updates from the module's own `config/install` directory rather than
from the site's current `config/sync`, and it supports **Config Partials** —
where an Optional Module ships only a piece of config (such as adding specific
permissions to a role) that installs alongside it. It also provides deployment
tooling that prevents Optional Modules and their configuration from being
uninstalled during a deployment, and an API for building a custom administration
toolbar tailored to a profile (similar to core's *Manage* menu, but separate and
profile-specific).

In short, this is a **developer/distribution tool** rather than a site-builder
feature: you'll get value from it while assembling and maintaining a profile, not
by clicking through an admin form. It works within core's node and user access
model and has no access-control role of its own beyond the permissions it defines.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no site-wide settings form** for this module. You use it by defining
Optional Modules in your profile and by granting the permission that lets site
maintainers enable them, as described below.

## How to use it

- **Grant the permission.** At **People → Permissions**, give the role that
  maintains a site the permission to enable Optional Modules, so they can turn
  profile features on and off without developer intervention.
- **Define Optional Modules in your profile.** As the profile developer, declare
  and configure your Optional Modules and any Config Partials they carry (for
  example role permissions to install with a feature).
- **Rely on the deployment tooling.** Let Profile Manager's deployment
  orchestration keep Optional Modules and their config from being uninstalled
  during deployments.
- **Optionally build a custom toolbar.** Use the provided API to assemble a
  profile-specific administration toolbar for your distribution.

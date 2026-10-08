# Donotuse — manual setup guide

**Donotuse** (`donotuse`) is exactly what its name says: an empty placeholder
module that you should not install on a real site. It ships only an `.info.yml`
file (which declares dependencies on `cohesion` and `cohesion_base_styles`), a
Composer manifest requiring `acquia/cohesion`, a one‑line README, and a license.
There is no PHP, no routes, no services, no hooks, no permissions, and no
configuration.

Enabling it does nothing except pull in the declared Acquia Cohesion
dependencies. It appears to be a namespace or experimental artifact that was
published to drupal.org rather than a functional module — its own project
description reads simply "testing purpose."

This page exists for completeness and honesty. If you find Donotuse enabled on a
site, treat it as inert: it has no code, so there is nothing to configure and
nothing to attack. It is safe to remove, as long as you first confirm nothing
inadvertently depends on it. It is not covered by Drupal's security advisory
policy, and it targets Drupal 9.3 and up.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — provided only for completeness. In
   practice, the correct action is *not* to install this module.

There is **no configuration page** for this module, because it contains no code.

## How to use it

Do not use it. That is the module's own instruction, and it is the right one. If
you are auditing a module inventory, flag `donotuse` as a non‑functional
placeholder and exclude it from production. If it is present and enabled, verify
nothing depends on it and then uninstall it.

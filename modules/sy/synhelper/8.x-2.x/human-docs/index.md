# Synapse Helper — manual setup guide

**Synapse Helper** (`synhelper`) is a developer utility module — the
"Synapse-helpers" toolkit from Synatix — that bundles a collection of helper
functions and Drush commands for developers working on Synapse/Synatix projects.
Its value is to other code: it fills small gaps and provides conveniences that
modules and developers build on, rather than offering a feature end users
interact with directly.

Beyond the helper library, the module does a few site-level things worth knowing
about up front, taken from its own documentation. It adds a **`/privacy-policy`**
page by default containing a unified legal agreement intended to suit a wide range
of sites. It also **deliberately intervenes in the administrator experience**: it
prevents installing modules through the graphical Extend UI, pre-fills some
checkboxes, and warns against certain errors. If you ever feel the module is
"resisting" being turned off, that is usually because it is listed as a dependency
of the **synmini** installation profile — in that case you remove it from the
`dependencies` block of `/profiles/synmini/synmini.info.yml` rather than fighting
the module.

Synapse Helper depends on the `idna` library, provides Drush commands, belongs to
the Synapse package, and supports Drupal 8, 9, 10 and 11. It is covered by
Drupal's security advisory policy. It has no settings form of its own.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Synapse Helper is mostly consumed by other code — its helper functions and Drush
commands are there for developers to call. After enabling it, its Drush commands
become available on the command line (run `drush list` to see what it registers),
the `/privacy-policy` page is added to the site, and the administrator-experience
behaviours described above take effect. There is no configuration screen; if you
need to remove it and it is pinned by the synmini profile, edit that profile's
`.info.yml` as noted above.

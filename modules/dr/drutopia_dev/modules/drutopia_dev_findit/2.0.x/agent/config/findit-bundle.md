<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# drutopia_dev_findit — dependencies and the Features bundle

What this submodule does at enable time. No settings form (`configure: null`).

## Install & enable

```bash
drush en drutopia_dev_findit -y
```

`drutopia_dev_findit.info.yml` declares these module dependencies (no `composer.json` of its own):

- `drutopia_findit_organization`, `drutopia_findit_program` — Find It content features.
- `drutopia_page` — generic Drutopia page feature.
- `features`, `features_ui` — the Features module and its UI, for packaging config.
- `dblog`, `node`, `user` — core logging, content, and accounts.

The `info.yml` still carries the legacy `core: 8.x` key next to `core_version_requirement: ^8 || ^9 || ^10`.

## The Features bundle (`config/install/features.bundle.drutopia.yml`)

Installs the `features.bundle.drutopia` config entity (machine name `drutopia`, `is_profile: true`,
`profile_name: drutopia`) with the standard Drutopia assignment plan (`base`, `core`, `dependency`,
`exclude`, `existing`, `forward_dependency`, `namespace`, `optional`, `packages`, `profile`, `site`,
`alter`). `drutopia_dev_findit.features.yml` (`bundle: drutopia`, `required: true`) marks this
submodule as a required member of that bundle.

## Mutual exclusivity with the parent

This file is **byte-for-byte identical** to `drutopia_dev`'s `config/install/features.bundle.drutopia.yml`.
Because two modules cannot both own-install the same config object, the submodule's README states that
`drutopia_dev_findit` is **separate from and does not require** `drutopia_dev`, and is **mutually
exclusive** with it. The README also suggests the eventual fix (move the parent's non-bundle config into
a `drutopia_dev_drutopia` submodule and drop this duplicated bundle file). In practice: enable the
parent module OR this submodule, not both, on the same site.

## Uninstall

Uninstalling removes the submodule; the installed `drutopia` bundle config follows the normal
config-install lifecycle. It is a development/feature-building aid — keep it off production.

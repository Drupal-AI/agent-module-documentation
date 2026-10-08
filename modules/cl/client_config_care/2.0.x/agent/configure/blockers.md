<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How protection works

## Recording
Config event subscribers `ConfigSave` / `ConfigDelete` / `ConfigImport` observe config changes. `Validator\ArrayDiffer` computes the real per-key diff, and changes are stored as revisionable `config_blocker_entity` entities (with a log of who/when). Manage them under **Structure → Config blocker entities**; configure route `client_config_care.config_blocker_entity`.

## Enforcement
The `IgnoreFilter` Config Filter plugin (id `client_config_care`, requires the `config_filter` module) reads active blockers and, during config **read / exists / listAll / collection** operations, keeps the blocked config's live value — so `drush config:import` will not overwrite it and export won't drop it. This is like `config_ignore` but driven by tracked blocker entities rather than a static ignore list.

## Toggling
`Deactivator` (backed by `SettingsFactory`) globally enables/disables protection — e.g. deactivate to force a full clean re-import, then reactivate. Check state with `drush client_config_care:is_activated`.

## Access
All entity operations are permission-gated (*add / administer / edit / delete / view (un)published / revision* permissions); the *administer* permission is flagged `restrict access`.

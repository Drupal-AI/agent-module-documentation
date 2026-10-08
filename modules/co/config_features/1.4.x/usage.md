<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Config Features packages a selected set of configuration into its own folder so it can be exported from one Drupal site and imported into another.

---

Config Features lets you group chosen configuration objects into a named **feature**, whose config
is pulled out of the site's main config export and written to a dedicated folder. That folder can be
committed or copied to another site and imported there. When importing, the module reconciles the
**UUID** differences between sites so the same configuration is *updated* rather than duplicated or
rejected. It is a code-level derivative of **Config Split** — the same config-transform split/merge
engine — reoriented from per-environment splits toward sharing config between sites. It moves
**configuration, not content**, provides a single restricted admin permission (`administer
configuration features`), integrates with core config sync via a `STORAGE_TRANSFORM` event
subscriber, and adds a batch export/download of tarballs. Features are defined at
**Config → Development → Configuration → Configuration Features**.

---

- Bundle a set of related config objects into a reusable "feature".
- Export a feature's config to its own folder, separate from the main sync directory.
- Import a feature exported on another site.
- Update matching configuration across sites despite differing UUIDs.
- Add configs to a feature by explicit name or by wildcard pattern.
- Exclude specific configs that would otherwise be pulled in as dependencies.
- Automatically include the dependency closure of the configs you select.
- Enable or disable a feature (toggle whether its config leaves the main export).
- Activate a feature to write its config into the active configuration.
- Deactivate a feature to remove its config from active configuration.
- Preview a two-way diff before importing or exporting a feature.
- Order features by weight to control import/export sequence.
- Store a feature's config in a folder relative to `site.path` (e.g. a sibling of the sync dir).
- Download a single feature's config as a `.tar.gz` archive.
- Download the full site configuration as a batch-built tarball.
- Keep generated export tarballs in the private filesystem, gated behind config-export access.
- Package config for version control or for handing to another site's builders.
- Reproduce a content type, view, or block layout on another site without hand-copying YAML.
- Work alongside core `drush config:export` / `config:import` through the transform subscriber.
- Restrict all feature operations to trusted administrators via a single permission.
- Review a feature's contents before sharing, since exported config can embed settings you may not
  want to distribute.

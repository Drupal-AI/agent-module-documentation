<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Migrate Process Vardump — agent index

One Migrate **process plugin**, id `vardump`, for debugging migrations. It runs PHP `var_dump()`
on the pipeline value and returns the value unchanged (passthrough). Core `^9.3 || ^10 || ^11`.
Package Migration. No config UI, no permissions, no services, no dependencies declared in info.yml
(uses core `migrate` classes). Version **2.0.2**.

Developer/debugging feature only — inspects a value during import under the migration's control;
no runtime, content, or access role. Output goes to stdout, so run the migration from the CLI
(e.g. `drush migrate:import`) to see it. Meant to be removed once the migration works.

- agent/plugins/process.md — the `vardump` plugin id, its optional `header` config key, and a YAML
  `process:` example.

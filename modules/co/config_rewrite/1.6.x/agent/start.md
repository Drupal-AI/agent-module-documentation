<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# config_rewrite — agent start

Lets a module **rewrite configuration another extension already installed** — core
`config/install/` can only create *new* config, never edit existing config. On the
installing module's `hook_module_preinstall`, the `config_rewrite.config_rewriter`
service scans its `config/rewrite/*.yml`, deep-merges each file onto the matching
*active* config object, and saves it. No admin UI, no permissions, no Drush commands —
it is a developer/build-time building block.

- The `config/rewrite/` directory convention + the rewrite YAML format (`config_rewrite:`
  control key, `replace`, uuid handling, multilingual) → [extend/rewrite-yaml.md](extend/rewrite-yaml.md)
- The `config.rewriter` service — `rewriteConfig()` / `rewriteModuleConfig()`, calling it
  directly in code → [api/rewriter-service.md](api/rewriter-service.md)

Key facts: service id `config_rewrite.config_rewriter`
(`Drupal\config_rewrite\ConfigRewriterInterface`). Rewriting config that was never
installed throws `NonexistentInitialConfigException`. Default merge preserves the
original `uuid` + `_core` keys.

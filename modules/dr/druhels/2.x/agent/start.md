<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drupal Helpers (druhels) — agent index

A **code-only developer utility library**: static helper classes under the `Drupal\druhels` namespace that wrap common Drupal coding patterns. **No routes, permissions, config, schema, plugins, services, or admin UI.** Documenting the **2.x dev branch** — the on-disk `druhels.info.yml` has **no `version:` line**.

- License GPL-2.0-or-later. `php >=7.4` (composer.json). Core `^8 || ^9 || ^10 || ^11 || ^12 || ^13 || ^14 || ^15`.
- **No declared dependencies** in `druhels.info.yml` (`dependent_modules: []`). Individual helper classes soft-depend on optional modules at call time (node, taxonomy, file, image, block, block_content, paragraphs, field, commerce_*, and `improvements` used by `BlockHelper`); a helper only works if that module is present.
- `druhels.module` provides `hook_mail()` (backing `DrupalHelper::sendMail()`) and two global aliases `timer_start()` / `timer_stop()`.

## What it provides

15 helper classes in `src/` (each a class of `public static` methods; `CommonHelper` is currently empty):

- Context: `NodeHelper`, `TaxonomyHelper`, `CommerceHelper`, `EntityHelper`, `DrupalHelper`
- Data: `ArrayHelper`, `StringHelper`, `DateHelper`
- Entity/field: `EntityHelper`, `NodeHelper`, `TaxonomyHelper`, `UserHelper`, `ParagraphHelper`, `FileHelper`
- Render/markup: `BlockHelper`, `SeoHelper`, `FormHelper`

## Solution docs

- **Full helper-class + key-method map (all 14 active classes)** → [api/helpers.md](api/helpers.md)

## Usage shape

Call the static method directly after a `use` statement, e.g. `use Drupal\druhels\NodeHelper;` then `NodeHelper::getCurrentNode()`. Install/enable with `drush en druhels -y`; nothing to configure.

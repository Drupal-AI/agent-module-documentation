<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Updater service & entity operation

## Service `entity_change_default_language_ui.updater`

Class `Drupal\entity_change_default_language_ui\Updater` (`src/Updater.php`), declared in
`entity_change_default_language_ui.services.yml`. Constructor-injected dependencies:
`@entity_change_default_language`, `@entity_type.bundle.info`, `@entity_type.manager`,
`@language_manager`, `@logger.factory`, `@current_route_match`.

Methods (all used by the two forms):

- `update($node, $to, $is_create, $langcodes)` — thin delegator: returns
  `entityChangeDefaultLanguage->update($node, $to, $is_create, $langcodes)`. The **actual** langcode
  rewrite, optional translation creation, and deletion of non-preserved translations live in the
  `entity_change_default_language` API module, not here.
- `getNodeBundles($formatted = TRUE)` — node bundle info from `entity_type.bundle.info`, returned as
  `id => label` options.
- `getLanguages($formatted = TRUE)` — installed languages from `language_manager`, returned as
  `langcode => name` options.
- `getTranslations($langcode = 'en', $original = TRUE, $bundle = NULL)` — builds a node entity query
  conditioned on `langcode`, on `default_langcode = 1` (when `$original`), and on `type` (when a
  bundle is given), then `loadMultiple()`s the matches. Used by the batch form to collect targets.
- `getCurrentNode(): ?Node` — reads the `node` route parameter (or loads it by id) and returns the
  `Node`, or NULL. Used by the per-node form.

## Entity operation hook

`entity_change_default_language_ui_entity_operation()` in `entity_change_default_language_ui.module`
adds, for **node** entities only, an operation `change_default_language` titled *"Change default
language"* (weight 42) linking to route `entity_change_default_language_ui.form` with the node id.
This is what surfaces the per-node form from admin content lists.

## Install / enable

`composer require drupal/entity_change_default_language_ui` then enable both this module and its
dependency `entity_change_default_language`. No config, no schema, no permissions ship with this
module; access is controlled entirely by the route permission on the two forms (see
[../forms/change-default-language.md](../forms/change-default-language.md)).

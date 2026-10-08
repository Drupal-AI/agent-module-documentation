<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Unpublished-term access & reference rules

Two overrides, wired by hooks in `better_unpublished_terms.module`. No config, no UI, no permissions of its own —
it reuses core's per-vocabulary term permissions (`create|edit|delete terms in <bundle>`).

## Install / enable

`ddev drush en better_unpublished_terms -y`. Requires `taxonomy` and `inline_entity_form` (both must be enabled).
Effect is immediate and site-wide; nothing to configure. To revert, disable the module — access reverts to core's
`TermAccessControlHandler` / `TermSelection`.

## Hook wiring (`better_unpublished_terms.module`)

- `better_unpublished_terms_entity_type_alter(array $info)` →
  `$info['taxonomy_term']->setHandlerClass('access', BetterTermAccessControlHandler::class)`.
- `better_unpublished_terms_entity_reference_selection_alter(array &$info)` →
  `$info['default:taxonomy_term']['class'] = BetterUnpublishedTermSelection::class`.

## `BetterTermAccessControlHandler::checkAccess($entity, $operation, $account)`

Extends `Drupal\taxonomy\TermAccessControlHandler`. Only the `view` operation is customized; every other operation
falls through to `parent::checkAccess()` (unchanged core behavior for update/delete/create).

Order of decision for `view`:
1. `administer taxonomy` → `AccessResult::allowed()->cachePerPermissions()`.
2. Entity must implement `EntityPublishedInterface` (taxonomy terms do); otherwise it throws
   `InvalidArgumentException`.
3. **Published term** → allowed iff `access content` (i.e. core's normal published-term rule),
   `cachePerPermissions()` + `addCacheableDependency($entity)`.
4. **Unpublished term** → allowed iff the account has ANY of
   `edit terms in {$entity->bundle()}`, `delete terms in {$entity->bundle()}`, or `create terms in {$entity->bundle()}`
   (bundle = the term's vocabulary machine name). Otherwise access is not granted, with a reason set.

Net effect: unpublished terms become viewable by that vocabulary's editors, not just `administer taxonomy` holders.
Users with none of those permissions still cannot view unpublished terms. Results are cached per-permissions and per
the term entity, so publish/unpublish and permission changes invalidate correctly.

## `BetterUnpublishedTermSelection` (entity-reference selection)

Extends `Drupal\taxonomy\Plugin\EntityReferenceSelection\TermSelection`. Governs which terms appear in
autocomplete / select / IEF widgets and which referenced values validate.

- `buildEntityQuery($match, $match_operator, $limit = 0)` calls
  `parent::buildEntityQuery($match, $match_operator)`, then computes `$see_unpublished`:
  - TRUE if `administer taxonomy`;
  - else TRUE if, for **any** taxonomy bundle, the user has `edit|delete|create terms in <bundle>`
    (loops `entityTypeBundleInfo->getBundleInfo('taxonomy_term')`, breaks on first match).
  - If `$see_unpublished` is FALSE it adds `->condition('status', 1)`, hiding unpublished terms from the widget.
  - Note this gate is not per-bundle — permission in *any* vocabulary lets unpublished terms of *all* referenceable
    bundles into the query; the final view/label rendering is still access-checked by the handler above, and
    `target_bundles` still limits which vocabularies the field offers.
- `validateReferenceableNewEntities(array $entities)` — for newly created (IEF) terms: first filters to the field's
  `target_bundles`; then, for non-`administer taxonomy` users, keeps a term only if the user has
  `edit|delete|create terms in <term bundle>` **or** the term `isPublished()`. This is the per-bundle mirror of the
  query gate for new entities.

## Operating notes

- There is nothing to configure and no permission named by this module. All behavior is driven by core's existing
  per-vocabulary term permissions plus the term published flag.
- The module changes entity access, so consumers that honor entity access (canonical term page, entity-reference
  formatters, JSON:API, Views with entity access checking) inherit the broadened rule. Views queries that do not
  enforce entity access are core's responsibility, not this module's.
- `tests/src/Functional/BetterUnpublishedTermsTest.php` is an empty class — do not treat it as coverage.

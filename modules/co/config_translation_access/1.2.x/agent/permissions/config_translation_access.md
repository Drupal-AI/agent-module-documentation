# Configuration Translation Access — permission & access logic

## Permission
`config_translation_access.permissions.yml`:

- **`translate editable configuration`** — title "Translate editable configuration",
  `restrict access: true`. Grant to roles that should translate the config they can already edit.

This is the *only* thing the module adds; everything else is the access decorator below.

## How access is decided
`config_translation_access.services.yml` decorates the two core services that guard config-translation
routes, both pointing at `Drupal\config_translation_access\ConfigTranslationAccess` (extends core
`ConfigTranslationOverviewAccess`):

- `config_translation.access.overview` → inner `config_translation_access.overview.inner`
- `config_translation.access.form` → inner `config_translation_access.form.inner`

`ConfigTranslationAccess::access(RouteMatchInterface $route_match, AccountInterface $account, ?string $langcode)`:

1. `$result = $inner->access(...)` — run core's own check first.
2. If `!$result->isNeutral()` (i.e. core already said **Allowed** or **Forbidden**), return it unchanged.
   → The module never overrides or weakens a core decision; it only fills the Neutral gap.
3. `$result->cachePerPermissions()`.
4. If `$account->hasPermission('translate editable configuration')`:
   - `$mapper = $this->getMapperFromRouteMatch($route_match)` (the config_translation mapper for the item);
   - `$edit = $this->accessManager->checkNamedRoute($mapper->getBaseRouteName(), $mapper->getBaseRouteParameters(), $account)`
     — does the account have access to the item's **original edit route**?
   - `$result = $result->orIf(AccessResult::allowedIf($edit))`.
5. Return `$result`.

## Net behaviour / security posture
- Access to translate an item ⇔ (core allows) OR (holds the permission AND can reach the item's base
  edit route). It is a strict **widening only within** what the user can already edit — a fail-safe,
  not fail-open design: a core Forbidden is preserved, and without base-route access the added
  permission grants nothing.
- Because the effective reach depends on the base routes the holder can access, the permission is
  correctly marked `restrict access: true` — treat it as trusted and pair it with the base
  edit permissions you actually want translatable.
- No config, schema, hooks, services beyond the two decorators, or Drush commands.

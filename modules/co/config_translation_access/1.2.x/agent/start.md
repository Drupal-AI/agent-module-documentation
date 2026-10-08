# Configuration Translation Access — agent index

Adds one permission, `translate editable configuration`, that grants config **translation** route
access whenever the user can access the config item's **base edit** route — a least-privilege
alternative to core's broad `translate configuration`. Works by decorating core's two
config-translation access services. No config UI, no schema, no Drush. Depends on `config_translation`.

- **The permission, what it gates, and the exact access algorithm (decorator, base-route check, caching)** →
  [permissions/config_translation_access.md](permissions/config_translation_access.md)

Key facts:
- Permission `translate editable configuration` (`restrict access: true`).
- `config_translation_access.services.yml` decorates `config_translation.access.overview` and
  `config_translation.access.form` with `Drupal\config_translation_access\ConfigTranslationAccess`.
- Grants access **only** if the inner/core check is Neutral AND the user holds the permission AND
  `access_manager->checkNamedRoute(mapper base route)` allows — never overrides a core Forbidden.

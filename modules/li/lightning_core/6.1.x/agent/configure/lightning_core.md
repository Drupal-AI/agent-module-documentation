# Configure — Lightning Core

Lightning Core has **no settings form of its own**. `configure: lightning_core.settings`
(path `/admin/config/system/lightning`) is a menu-block landing page that collects the
config links of Lightning submodules; it renders via
`SystemController::systemAdminMenuBlockPage` and is gated by the `_is_administrator`
access check (any user in an admin role passes). Menu link defined in
`lightning_core.links.menu.yml`.

## Config this module ships / manages

### `long_12h` date format (config/install)
Installed on enable as a normal core date format:
- id `long_12h`, label `Long (12-hour)`, pattern `F j, Y \a\t g:i A`.
- Read: `drush cget core.date_format.long_12h pattern`.
- Recreate in code:
```php
\Drupal\Core\Datetime\Entity\DateFormat::create([
  'id' => 'long_12h', 'label' => 'Long (12-hour)',
  'pattern' => 'F j, Y \a\t g:i A', 'locked' => FALSE,
])->save();
```

### Entity descriptions (roles, view modes, form modes)
Via `hook_entity_type_alter`, Lightning Core swaps the entity classes for `user_role`,
`entity_view_mode` and `entity_form_mode` so each gains a description stored as a
**third-party setting** under the `lightning_core` provider. Schema in
`config/schema/lightning_core.schema.yml`:

| Config entity | third-party keys (`lightning_core`) |
|---|---|
| `user.role.*` | `description` |
| `core.entity_view_mode.*.*` | `description`, `internal` (bool) |
| `core.entity_form_mode.*.*` | `description`, `revision_ui` (bool) |

Set/read in code (any config entity of these types):
```php
$role = \Drupal\user\Entity\Role::load('content_editor');
$role->setThirdPartySetting('lightning_core', 'description', 'Edits articles.')->save();
$desc = $role->getThirdPartySetting('lightning_core', 'description');
// Roles/modes also implement EntityDescriptionInterface: $role->setDescription('…').
```
Read with drush: `drush cget user.role.content_editor third_party_settings`.
The role add/edit form (`RoleForm`) exposes the description as a field; view/form-mode
add/edit forms expose description + the internal / revision-ui toggles.

### `_is_administrator` route access check
Use in any `*.routing.yml` to require an admin-role user:
```yaml
requirements:
  _is_administrator: 'true'
```
Backed by `access_check.administrator_role` (`AdministrativeRoleCheck`), which treats a
role as administrative when its `is_admin` flag is set.

## Drush integration (no standalone commands)
Command **hooks** only (`src/Commands/Hooks.php`):
- `drush core:status` gains a `base-profile` field (the distribution's base profile, if any).
- Before `drush updatedb`, all plugin discovery caches are cleared to avoid stale-cache
  update errors.

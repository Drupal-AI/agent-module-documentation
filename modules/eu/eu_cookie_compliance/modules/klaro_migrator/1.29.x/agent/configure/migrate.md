# Migrate EUCC → Klaro

1. Enable `klaro` (contrib) and this `klaro_migrator` submodule.
2. Go to `/admin/config/system/eu-cookie-compliance/klaro-migration`
   (route `eu_cookie_compliance.klaro_migration_form`, permission
   `administer eu cookie compliance popup`).
3. Submit the form (`src/Form/KlaroMigrationForm.php`). It calls
   `KlaroMigrationManager` (`src/KlaroMigrationManager.php`, service in
   `klaro_migrator.services.yml`) to read current EUCC settings/categories and write the
   equivalent Klaro configuration.
4. Review the generated Klaro services/purposes, switch your active consent manager to Klaro,
   then uninstall `klaro_migrator` (and optionally `eu_cookie_compliance`).

Programmatic use: load the `KlaroMigrationManager` service and invoke its migration method
from custom code / an update hook instead of the form.

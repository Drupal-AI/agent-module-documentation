# Admin User Language — agent index

Forces a chosen **administration pages language** (`preferred_admin_langcode`) onto users on
create/update, via `hook_entity_presave()`. Requires ≥2 active languages to be meaningful. No
plugins, no Drush.

- **The two settings, the form, and how they change behavior (force vs. new-only, locking the field)** →
  [configure/settings.md](configure/settings.md)
- **The permission that gates the settings form** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Config `admin_user_language.settings`: `default_language_to_assign` (langcode, or `-1` = no
  preference, or `preferred_langcode` = mirror the user's site language) and `prevent_user_override`
  (bool). Shipped defaults: `-1` / `FALSE`.
- `prevent_user_override = FALSE` → language applied only to **new** users; `TRUE` → applied on
  **every** user save AND the admin-language field is disabled on the user form.
- Settings form route: `admin_user_language.basic_form` → `/admin/config/admin_user_language/settings`.
  Permission: `administer admin interface language`.
- Does not switch the admin UI at request time — pair with `admin_language_negotiation` for that.

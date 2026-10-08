# environment_indicator — agent start

Colored per-environment banner (+ optional toolbar tint, favicon, switcher dropdown).
Config UI: **Admin → Config → Development → Environment Indicator**
(`/admin/config/development/environment-indicator`, route `environment_indicator.settings`).
Switcher config entities live at `.../environment-indicator/switcher`.

- Settings form, `settings.php` overrides, Environment Switcher entities → [configure/settings.md](configure/settings.md)
- Read the active environment in code (`environment_indicator.indicator` service) → [api/service.md](api/service.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)
- Theme hook / preprocess for the indicator markup → [theming/theming.md](theming/theming.md)

Submodules (documented separately): `environment_indicator_toolbar`, `environment_indicator_ui`.

# gin_login — agent start

Restyles Drupal user auth pages (login/register/password/logout) to match the **Gin**
admin theme via a theme negotiator + Twig templates. Requires the Gin theme.
Config UI: **Admin → Config → System → Gin Login**
(`/admin/config/system/configuration/gin-login`, route `gin_login.configuration_form`).

- Configure logo & wallpaper → [configure/settings.md](configure/settings.md)
- Templates & how the login theme is applied → [theming/templates.md](theming/templates.md)
- Add/alter which routes are login pages → [hooks/route-definitions.md](hooks/route-definitions.md)

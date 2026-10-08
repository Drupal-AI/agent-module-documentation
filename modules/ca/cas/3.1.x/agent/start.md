# cas — agent start

CAS single sign-on client. Redirects to a CAS server, validates tickets, provisions users
via `externalauth`. Config UI: **Admin → Config → People → CAS**
(`/admin/config/people/cas`, route `cas.settings`). Depends on `externalauth`.

- Server + login/registration settings → [configure/settings.md](configure/settings.md)
- Services (helper, validator, redirector, user manager) → [api/services.md](api/services.md)
- Events to hook login/registration/redirect → [hooks/events.md](hooks/events.md)
- Drush command → [drush/drush.md](drush/drush.md)

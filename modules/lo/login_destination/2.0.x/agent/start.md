# login_destination — agent start

Redirects users after **login / logout / registration / one-time login** to a destination
chosen by the first matching **`login_destination`** config entity ("rule"). Rules match on
trigger + conditions (roles, pages, language) and are ordered by weight (priority). Depends on
core `path_alias`. Beta release. Config UI: **Admin → Config → People → Login destinations**
(`/admin/config/people/login-destination`); configure route `login_destination.list`.

- Create/order login destination rules + the settings form → [configure/configure.md](configure/configure.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)

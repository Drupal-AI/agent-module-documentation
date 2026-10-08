# flood_control — agent start

Exposes core's hidden flood limits in a UI and unblocks locked-out IPs/users. No
dependencies. Config UI: **Admin → Config → People → Flood control**
(`/admin/config/people/flood-control`, route `flood_control.settings`). Unblock screen at
`/admin/people/flood-unblock`.

- Edit login/contact flood thresholds + IP allow-list → [configure/settings.md](configure/settings.md)
- Unblock IPs/users from the UI or CLI → [drush/commands.md](drush/commands.md)
- Bypass flood via the IP allow-list decorator → [extend/whitelist.md](extend/whitelist.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)

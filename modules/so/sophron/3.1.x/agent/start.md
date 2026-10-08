# sophron — agent start

Extensive MIME type management API backed by `fileeye/mimemap`. Central service:
`Drupal\sophron\MimeMapManagerInterface`. Config UI: **Admin → Config → System → Sophron**
(`/admin/config/system/sophron`, route `sophron.settings`). Submodule `sophron_guesser`
replaces core's MIME guesser.

- Settings: map class + map commands → [configure/settings.md](configure/settings.md)
- Query types/extensions via the MimeMapManager service → [api/manager.md](api/manager.md)
- Extend/correct the map via the init event → [extend/events.md](extend/events.md)
- MIME types JSON feed + permission → [permissions/permissions.md](permissions/permissions.md)

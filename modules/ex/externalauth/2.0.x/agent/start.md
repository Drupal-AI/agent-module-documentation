# externalauth — agent start

Low-level helper: maps Drupal users to external-provider identities (authmap) and runs the
login/register/link flows for SSO modules. **No config UI** — used from code. Admin listing of
stored mappings at `/admin/people/authmap`.

- Services to call (ExternalAuth, Authmap) → [api/services.md](api/services.md)
- React to login/register / alter authmap (events) → [extend/events.md](extend/events.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)

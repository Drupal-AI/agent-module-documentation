# captcha — agent start

Adds spam-blocking challenges to arbitrary forms. Challenge types come from `hook_captcha()`
(base module ships "Math"; the `image_captcha` submodule adds an image challenge). Config UI:
**Admin → Config → People → CAPTCHA** (`/admin/config/people/captcha`, route `captcha_settings`).

- Global settings (default challenge, persistence, validation, whitelist) → [configure/settings.md](configure/settings.md)
- Attach a challenge to a form (CAPTCHA points) → [configure/captcha-points.md](configure/captcha-points.md)
- Implement/alter a challenge type + control placement (hooks) → [hooks/hooks.md](hooks/hooks.md)
- Services & helper functions for code → [api/services.md](api/services.md)
- The `#type => captcha` render element & theming → [theming/element.md](theming/element.md)
- Permissions → [permissions/permissions.md](permissions/permissions.md)

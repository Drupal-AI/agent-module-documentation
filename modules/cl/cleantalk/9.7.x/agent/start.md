# cleantalk — agent start

Cloud anti-spam (CleanTalk) with no CAPTCHA. Submissions are sent to the CleanTalk API for
an allow/deny verdict; a SpamFireWall (SFW) can block known spam IPs/bots before the page
renders. All settings live in the single **`cleantalk.settings`** config object. Config UI:
**Admin → Config → Content authoring → Antispam by Cleantalk → Settings**
(`/admin/config/cleantalk/cleantalk_settings_form`, route `cleantalk.settings`).

Live spam verdicts require the CleanTalk **Access key** (`cleantalk_authkey`) plus outbound
network access to the CleanTalk API — the per-form protection toggles are stored either way,
but no remote check happens without a valid key.

- Access key, which forms are protected, exclusions, SFW, all config keys → [configure/settings.md](configure/settings.md)
- Programmatic spam check + helper services/functions → [api/api.md](api/api.md)
- The `change cleantalk settings` permission → [permissions/permissions.md](permissions/permissions.md)

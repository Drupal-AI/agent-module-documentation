# friendlycaptcha — agent start

Adds the privacy-friendly **Friendly Captcha** service as a CAPTCHA challenge type. It is an
add-on for the **CAPTCHA** module (depends on `captcha:captcha`) — it registers via
`hook_captcha()`, it is not standalone. Visitors' browsers solve a background cryptographic
proof-of-work (no interactive puzzle); the token is verified server-side. Config UI:
**Admin → Config → People → CAPTCHA → Friendly Captcha**
(`/admin/config/people/captcha/friendlycaptcha`); route `friendlycaptcha.admin_settings_form`,
config object `friendlycaptcha.settings`. No own permissions (uses CAPTCHA's
`administer CAPTCHA settings`).

- Configure keys, endpoints, proof-of-work, and use as a challenge → [configure/friendlycaptcha.md](configure/friendlycaptcha.md)

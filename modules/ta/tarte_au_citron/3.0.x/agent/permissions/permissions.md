# Tarte au citron permissions

From `tarte_au_citron.permissions.yml`.

| Permission | `restrict access` | Gates |
|---|---|---|
| `administer tarte au citron` | `true` | The JS settings form `tarte_au_citron.configuration_js` (library config + service enablement). Trusted-admin permission. |
| `translate tarte au citron` | — | The texts form `tarte_au_citron.configuration_texts` (banner text overrides / language strategy). Grantable to non-admin translators. |
| `bypass tarte au citron` | — | When held, `ServicesManager::isNeeded()` returns `FALSE`, so `hook_page_attachments_alter()` does NOT attach the consent library/banner for that user. |

Notes:
- `bypass tarte au citron` is a *display* bypass (the banner/library are not attached for that role); it
  does not itself load or authorize any tracking script — it just suppresses the consent UI.
- The parent menu container route `tarte_au_citron.config` (`/admin/config/tarte_au_citron`) requires
  core `administer site configuration`.
- No permission is `restrict access: true` except `administer tarte au citron`.

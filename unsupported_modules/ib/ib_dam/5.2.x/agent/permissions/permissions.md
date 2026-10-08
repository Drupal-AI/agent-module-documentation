# IntelligenceBank DAM permissions

From `ib_dam.permissions.yml`:

| Permission | Gates |
|---|---|
| `administer intelligencebank configuration` | The global settings form `/admin/config/services/ib_dam` (route `ib_dam.settings_form`) and the ib_dam_media configuration form `/admin/config/services/ib_dam/media`. |

This is the only permission the base module defines, and both the base settings form and the
`ib_dam_media` media-mapping form require it. Grant it only to trusted administrators who should
manage the IntelligenceBank connection (Platform URL, SSO/login defaults, embedding toggle,
media-type mapping). The asset-browser route added by ib_dam_media
(`id_dam_media.asset_browser_form`) is not gated by this permission (`_access: 'TRUE'`); it is
reached from within the Media Library add flow.

# Configuration

Configuration lives on the global settings form. Note that **no configuration ships
by default** — the values are empty until you save the form for the first time.

## The permission

Everything below is gated by a single permission, **Administer intelligencebank
configuration**. Grant it at **People → Permissions** (`/admin/people/permissions`)
to trusted administrators only — it controls both the global settings form and (when
`ib_dam_media` is enabled) the media-mapping form. Give it only to people who should
manage the IntelligenceBank connection.

## The global settings form

Go to **Configuration → Web services → IntelligenceBank DAM**
(`/admin/config/services/ib_dam`). The settings are stored in the `ib_dam.settings`
config object.

- **Debug** (`debug`) — turn on verbose logging of IntelligenceBank API activity,
  useful when troubleshooting a connection.
- **Staging** (`staging`) — use IntelligenceBank's beta/staging connector browsing
  interface instead of production. Leave off for normal use.
- **Allow embedding** (`allow_embedding`) — allow editors to **embed** IB assets via
  a public CDN link, in addition to downloading/importing them. This also controls
  whether the "IB embed" option appears in the Media Library add menu (via
  `ib_dam_media`).
- **Platform URL / login sub-domain** (`login_url`) — the default IntelligenceBank
  Platform URL / sub-domain for editors, entered without the `https://` prefix (for
  example `acme.intelligencebank.com`).
- **Allow custom URL** (`login_enable_custom_url`) — let editors enter their own
  Platform URL rather than being locked to the fixed sub-domain above.
- **Enable browser login** (`login_enable_browser_login`) — enable browser-based
  login, which is how single sign-on (SSO) to IntelligenceBank works.

Save the form to store the connection defaults.

You can also set these from the command line, for example:

```bash
drush cset ib_dam.settings allow_embedding 1 -y
drush cset ib_dam.settings login_url 'acme.intelligencebank.com' -y
drush cset ib_dam.settings login_enable_browser_login 1 -y
```

## Connecting to IntelligenceBank (credentials)

The settings above are only *defaults for the connection*. Actual connectivity needs
valid IntelligenceBank platform credentials/SSO configured against your IB account —
editors log in through the browser/SSO flow, and the module then authenticates each
API request by sending the IntelligenceBank **session id** as a header. The module
stores **no API key of its own** in `ib_dam.settings`, so there is no long-lived
secret to paste here; the sensitive part is the live IB session, which is handled at
login time.

## Advanced: API timeout (settings.php)

The HTTP timeout used by the IntelligenceBank API service defaults to 120 seconds.
It is read from a Drupal setting rather than config, so to change it add to
`settings.php`:

```php
$settings['intelligencebank_api_timeout'] = 120; // seconds
```

## Submodule configuration (`ib_dam_media`)

When the `ib_dam_media` submodule is enabled, it adds its own configuration form for
mapping IntelligenceBank source types to local media types and setting the upload
location, at **`/admin/config/services/ib_dam/media`** (same *Administer
intelligencebank configuration* permission). See the `ib_dam_media` documentation for
its options.

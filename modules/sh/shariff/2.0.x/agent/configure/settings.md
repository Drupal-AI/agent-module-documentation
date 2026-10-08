# Configure — global Shariff settings

Settings form: `shariff.settings_form` at **`/admin/config/services/shariff`** (permission:
`administer site configuration`). It edits the config object **`shariff.settings`**.

## Config keys (`shariff.settings`)

| Key | Type | Values / notes |
|---|---|---|
| `shariff_services` | sequence (map `id: id`) | active networks in order — see service ids below |
| `shariff_theme` | string | `colored` \| `grey` \| `white` |
| `shariff_css` | string | `complete` (incl. Font Awesome) \| `min` \| `naked` |
| `shariff_orientation` | string | `horizontal` \| `vertical` |
| `shariff_button_style` | string | `standard` \| `icon` \| `icon-count` |
| `shariff_hidden` | boolean | hide block when the browser Web Share API is supported |
| `shariff_twitter_via` | string | Twitter "via" screen name |
| `shariff_mail_url` | string | mail target, e.g. `mailto:` |
| `shariff_mail_subject` / `shariff_mail_body` | string | mail button subject / body |
| `shariff_referrer_track` | string | appended to share URL (disabled when empty) |
| `shariff_backend_url` | string | Shariff backend for share counts (validated as URL) |
| `shariff_flattr_category` / `shariff_flattr_user` | string | Flattr options |
| `shariff_media_url` | string | media URL to share (Pinterest) |
| `shariff_info_url` / `shariff_info_display` | string | Info button URL / display (`blank`\|`popup`\|`self`) |
| `shariff_title` | string | fixed share title (Twitter/WhatsApp) |
| `shariff_url` | string | fixed canonical URL to share |

Service ids (from the settings form): `twitter, facebook, linkedin, pinterest, vk, xing,
whatsapp, addthis, telegram, tumblr, flattr, diaspora, reddit, stumbleupon, weibo, flipboard,
pocket, print, tencent-weibo, qzone, threema, mail, info, buffer`.

## Shipped defaults (`config/install/shariff.settings.yml`)

```yaml
shariff_css: complete
shariff_theme: colored
shariff_orientation: horizontal
shariff_services:
  twitter: twitter
  facebook: facebook
```

## Read / write with drush

```bash
drush cget shariff.settings
drush cset shariff.settings shariff_theme grey -y
```

```php
// Set active services + orientation programmatically.
\Drupal::configFactory()->getEditable('shariff.settings')
  ->set('shariff_services', ['whatsapp' => 'whatsapp', 'telegram' => 'telegram'])
  ->set('shariff_orientation', 'vertical')
  ->save();
```

`shariff_services` is stored as a map of `service_id: service_id`; the submit handler drops
unchecked services. Order in the array is the button order (set via the drag-and-drop weight
table on the form).

## Schema

`config/schema/shariff.schema.yml` types `shariff.settings` as a `config_object`. Share
counts (`shariff_button_style: icon-count`) require a working `shariff_backend_url`.

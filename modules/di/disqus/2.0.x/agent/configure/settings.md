<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Disqus settings (`disqus.settings`)

Route `disqus.settings` → `/admin/config/services/disqus` (form
`Drupal\disqus\Form\DisqusSettingsForm`, permission `administer disqus`). All values persist
in the single `disqus.settings` config object. Shipped defaults are all empty/false.

## Config keys (with schema)

```yaml
disqus_domain: ''            # REQUIRED: your Disqus site "shortname" (example.disqus.com -> "example")
behavior:
  disqus_localization: false        # override Disqus language with the site language
  disqus_inherit_login: false       # pre-fill Disqus 'Post as Guest' with the user's name/email
  disqus_track_newcomment_ga: false # send new-comment events to Google Analytics (needs google_analytics)
  disqus_notify_newcomment: false   # email content author on new comment (needs secret key)
advanced:
  disqus_useraccesstoken: ''  # user access token (enables thread update/close/remove)
  disqus_publickey: ''        # Disqus application public key (needed for SSO)
  disqus_secretkey: ''        # Disqus application secret key (needed for SSO)
  api:
    disqus_api_update: false  # update thread title/URL on entity save (needs token + disqus-php lib)
    disqus_api_delete: '0'    # on entity delete: '0' none, DISQUS_API_CLOSE, DISQUS_API_REMOVE
  sso:
    disqus_sso: false         # enable Single Sign-On (needs public+secret keys)
    disqus_use_site_logo: false
    disqus_logo: ''           # managed file id/uri for a custom 143x32 SSO login button
```

The **API sub-settings** (`disqus_api_update`, `disqus_api_delete`) only appear on the form
when the `DisqusAPI` class exists (i.e. the `disqus/disqus-php` library is autoloadable). The
**SSO** fieldset only shows once both public and secret keys are set.

## Read / set via drush

```bash
drush cget disqus.settings disqus_domain
drush cset disqus.settings disqus_domain example -y
drush cset disqus.settings behavior.disqus_inherit_login true -y
```

Or in PHP:

```php
\Drupal::configFactory()->getEditable('disqus.settings')
  ->set('disqus_domain', 'example')
  ->set('behavior.disqus_notify_newcomment', TRUE)
  ->save();
```

The shortname is the only strictly required value for threads to render; everything else is
optional behavior/credentials. `disqus.settings` is also config-translatable
(`disqus.config_translation.yml`).

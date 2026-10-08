<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the CookiePro consent script

CookiePro has exactly one setting: the raw script markup to inject into every page's `<head>`.

## The config

- Config object: **`cookiepro.header.settings`**
- Key: **`scripts`** (type `text`)
- The object has **no install default** — it is created the first time you save the form, and
  deleted on module uninstall.

## Via the UI

1. Go to *Configuration → Development → CookiePro by OneTrust*
   (`/admin/config/development/cookiepro`, route `cookiepro.admin.header`).
2. Paste the **Main Cookies Script Tag** from your CookiePro/OneTrust account into the
   **Scripts** textarea (remove the leading/trailing HTML comments OneTrust wraps it in).
3. Optionally add the Cookie Settings button and Cookie List snippets.
4. **Save configuration.** The banner is now emitted on every page.

Access to this form requires the **`cookiepro_settings`** permission
(*People → Permissions*, "CookiePro by OneTrust").

## Via drush (scriptable)

```bash
# Set the consent script:
drush cset cookiepro.header.settings scripts \
  '<script src="https://cdn.cookielaw.org/scripttemplates/otSDKStub.js" type="text/javascript" charset="UTF-8" data-domain-script="YOUR-ID"></script>' -y

# Read it back:
drush cget cookiepro.header.settings scripts
```

Or in PHP:

```php
\Drupal::configFactory()->getEditable('cookiepro.header.settings')
  ->set('scripts', '<script ... data-domain-script="YOUR-ID"></script>')
  ->save();
```

## Notes

- The value is emitted **verbatim** into `<head>` (comments stripped) — treat it as trusted
  admin input; only the `cookiepro_settings` permission should be granted to trusted roles.
- Getting a real banner requires a CookiePro/OneTrust account and its `data-domain-script` id;
  the module itself contributes no consent logic, only the script tag.

# Configuration

CookiePro has exactly one setting: the raw script markup to inject into every
page's `<head>`. That's the whole configuration surface — one textarea.

## Open the settings form

1. Log in as a user with the **CookiePro by OneTrust** permission
   (`cookiepro_settings`) — an administrator by default.
2. Go to **Configuration → Development → CookiePro by OneTrust**, or navigate
   directly to `/admin/config/development/cookiepro`.

## The Scripts field

The form has a single **Scripts** textarea. Whatever you paste here is emitted
into the `<head>` of every page on your site. In practice you paste the code
OneTrust gives you from your CookiePro account:

- **Main Cookies Script Tag** *(required for a working banner)* — the autoblocking
  OneTrust SDK loader. It looks like this, with your own data-domain-script id in
  place of the placeholder:

  ```html
  <script src="https://cdn.cookielaw.org/scripttemplates/otSDKStub.js"
          type="text/javascript" charset="UTF-8"
          data-domain-script="YOUR-ID"></script>
  ```

  When you copy this from OneTrust it is usually wrapped in HTML comments —
  remove the leading/trailing `<!-- ... -->` before pasting.

- **Cookie Settings snippet** *(optional)* — a small button/link snippet that
  reopens the preference center so visitors can change their choices.

- **Cookie List snippet** *(optional)* — outputs a categorized list of cookies,
  handy on a cookie-policy page.

You can paste more than one tag into the field — both `<script>` and `<noscript>`
fallbacks are supported. The module splits the input into individual tags and
rebuilds each one, preserving its attributes (`src`, `type`, `charset`,
`data-domain-script`, and so on).

When you're done, click **Save configuration**. The banner is emitted on every
page immediately.

## Good to know

- **The value is emitted verbatim** (only HTML comments are stripped). Treat this
  field as trusted admin input, and only grant the `cookiepro_settings` permission
  to roles you trust — anything pasted here runs in every visitor's browser.
- **It's global.** There is no per-page, per-path, or per-role targeting; the
  script loads for all visitors on every page. That's deliberate — the consent
  banner needs to run before other trackers fire.
- **No install default.** The configuration object (`cookiepro.header.settings`,
  key `scripts`) doesn't exist until you first save the form, and it's deleted
  cleanly when you uninstall the module.
- **You still need a OneTrust account.** This module only delivers the script; the
  banner, preference center, and cookie categorization all come from OneTrust and
  depend on the `data-domain-script` id tied to your account. Swap that id when
  moving from a test data domain to production.

## Setting it from the command line

Because it's a single config value, you can script it:

```bash
# Set the consent script:
drush cset cookiepro.header.settings scripts \
  '<script src="https://cdn.cookielaw.org/scripttemplates/otSDKStub.js" type="text/javascript" charset="UTF-8" data-domain-script="YOUR-ID"></script>' -y

# Read it back:
drush cget cookiepro.header.settings scripts
```

This is also how the setting travels between environments — export
`cookiepro.header.settings` with the rest of your configuration and it deploys
like anything else.

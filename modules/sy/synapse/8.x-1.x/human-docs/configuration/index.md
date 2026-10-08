# Configuration

Synapse Staff provides a settings form at the `synapse.settings` route. Open it
as a user with permission to administer site configuration. According to the
module's own documentation, the form covers two things: a Google Tag Manager
connection and a couple of site-verification meta tags.

## Connect to Google Tag Manager

Enter your Google Tag Manager container details so the site loads GTM. This lets
you manage analytics and marketing tags through the Tag Manager console rather
than editing the site's code.

## Add site-verification meta tags

The form also lets you add site-ownership verification meta tags that search
engines look for:

- **Google Webmaster** — the verification meta value from Google Search Console,
  used to prove you own the site.
- **Yandex Webmaster** — the equivalent verification meta value for Yandex
  Webmaster tools.

Enter the values each service gives you and save. The module then outputs the
corresponding meta tags in the site's markup so the verification checks pass.

## Beyond these settings

Synapse Staff is a vendor/site-specific customization module, so a given
deployment may carry additional Synatix/Synapse-specific behaviour beyond the
options above. For anything particular to your setup, consult the vendor's own
documentation, and review what the module does in your context before relying on
it.

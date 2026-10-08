# Configuration

Obfuscator's settings form lets you choose which fingerprints to strip. Each option
is independent, so you can turn on only the ones you want.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to the Obfuscator settings page — the `obfuscator.admin_settings` route,
   reached from the site's configuration section.

## What you can turn on

- **Remove the Drupal version from HTML** — strips the version from the generator
  `<meta>` tag in the page source, so viewing source no longer reveals which Drupal
  version you run.
- **Remove the version from HTTP headers** — removes the version from response
  headers (such as `X-Generator`), so tools that read headers can't read it off
  directly.
- **Strip asset version strings** — removes the `?v=…`‑style version query strings
  appended to CSS and JavaScript URLs in the HTML, which otherwise hint at core and
  module versions.

Turn on the options you want and **save** the form. The changes take effect on the
next page render (clear caches if you don't see them immediately).

## Disabling TRACE and TRACK (Apache)

Obfuscator can also help disable the HTTP **TRACE** and **TRACK** request methods,
which are rarely needed and can assist certain attacks. This part is handled
through your Apache configuration (`.htaccess`) rather than the settings form,
following the module's guidance. After applying it, confirm the methods are
rejected — for example a `TRACE` request to your site should no longer be echoed
back. On non‑Apache web servers, apply the equivalent method restriction in your
server configuration instead.

## A reminder on scope

Everything here shrinks the *fingerprinting surface* — it does not close any
vulnerability. Keep this in perspective: the option that actually protects your
site is staying **patched**. Obfuscator is the thin extra layer on top.

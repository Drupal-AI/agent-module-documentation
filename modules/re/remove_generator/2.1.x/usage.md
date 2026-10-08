Remove Generator strips the `<meta name="Generator" content="Drupal …">` tag that core adds to every page, so the site no longer advertises that it runs Drupal. Enable to remove it, disable to restore it — no configuration.

---

Drupal core's System module attaches a `Generator` meta tag (keyed `system_meta_generator`) to the `html_head` of every page, publicly declaring "Drupal 11 (https://www.drupal.org)". This is a minor fingerprinting/version-disclosure signal that some site owners prefer to hide. Remove Generator is a one-file module: it implements `hook_page_attachments_alter()`, loops `$attachments['#attached']['html_head']`, and `unset()`s the entry whose key equals `system_meta_generator`. There is nothing to configure — no settings form, no permissions, no config schema, no dependencies. Enabling the module removes the tag site-wide; uninstalling it lets core add the tag back. Note this only removes the HTML meta tag; it does not change the `X-Generator` HTTP header or other Drupal fingerprints (which other hardening tools address).

---

- Hide the Drupal Generator meta tag from page source for basic security-through-obscurity.
- Reduce automated fingerprinting that keys off the `<meta name="Generator">` tag.
- Meet a client/security requirement to not disclose the CMS in HTML output.
- Remove the tag without writing a custom module or theme override.
- Clean up page `<head>` output to omit the core "Drupal 11" advertisement.
- Pair with server-side header hardening to reduce version-disclosure signals overall.
- Suppress the generator tag across an entire multisite by enabling one module.
- Avoid third-party services (e.g. BuiltWith-style detectors) reading the generator tag.
- Temporarily restore the tag by simply disabling the module (no config to revert).
- Standardize "no generator tag" as part of a site security baseline/profile.
- Drop the tag on a decoupled/marketing site where the CMS should stay unadvertised.
- Remove the tag on pages served to anonymous crawlers and bots.
- Enable it in a hardening install profile so new sites ship without the generator tag.
- Satisfy a penetration-test finding that flagged CMS version/product disclosure in HTML.
- Keep the `<head>` free of the generator tag without maintaining a custom `hook_page_attachments_alter()`.
- Uninstall to instantly confirm the tag is core-added (A/B check) during debugging.

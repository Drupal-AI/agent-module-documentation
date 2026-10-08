# Configuration

Ironstar is a **host-integration** module, so its configuration is about aligning
Drupal with the Ironstar platform rather than switching on features. It provides a
settings form (defined by the `ironstar.settings` configuration object) for the
platform options it manages, behind the module's own administer permission — grant
that permission only to trusted administrators.

## Open the settings form

Log in as a user with the module's administer permission and open the Ironstar
settings form from the site's configuration area. Because this module ships
recommended configuration for other modules, much of the "configuration" is applied
by the module's recipes rather than by you clicking individual fields.

## What it configures

The module currently provides recommended configuration for:

- **Fastly** — edge caching / CDN behaviour tuned for the Ironstar platform.
- **Memcache** — object caching aligned with the platform's caching layer.
- **Monolog** — logging routed the way the platform expects.

## The important operational settings live at the platform level

For a hosting-integration module, the settings that matter most for correctness and
security are **reverse-proxy / trusted-host handling** and environment-specific
configuration. Those are typically set in `settings.php` (and provided by the
platform) rather than in this form. Follow **Ironstar's own guidance** for:

- Trusted host patterns.
- Reverse-proxy and trusted-header settings so client IPs and HTTPS are detected
  correctly behind the platform's edge.
- Any environment variables the platform injects.

## Save

If you change any values in the settings form, save it. Then verify against
Ironstar's documentation that caching, logging, and edge behaviour work as expected
on the hosted environment — that, rather than a visible on-page change, is how you
confirm the configuration is correct.

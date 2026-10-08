<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# miniOrange User Provisioning — agent index

Provisions/de-provisions **Drupal users and groups to/from external IdPs** (Okta, Keycloak). Admin
screens gated by `administer site configuration`; config at `user_provisioning.overview`. Version
**8.x-1.33**. Core `^9||^10||^11`.

**Security:** store IdP API credentials as secrets; admin routes correctly restricted; outbound calls
checked — **does not disable TLS** (unlike sibling miniOrange modules). Vendor promotes paid tiers.

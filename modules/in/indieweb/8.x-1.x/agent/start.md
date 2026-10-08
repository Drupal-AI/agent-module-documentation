<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# IndieWeb — agent index

**IndieWeb building blocks** for Drupal — submodules for **IndieAuth** (auth/token), **Micropub** (token-auth
posting API), **Webmention** (cross-site mentions), Microsub, WebSub, microformats. Provides permissions +
dashboard (`indieweb.admin.dashboard`). Version **8.x-1.28**. Core `^10||^11`.

Touches auth/public endpoints — **correctly gated**: Micropub (`/indieweb/micropub`, public by necessity)
**validates the IndieAuth bearer token + scope on every branch** (401 missing/invalid, 403 insufficient scope)
before creating content (verified). Serve over **HTTPS**; treat inbound Webmentions as untrusted.

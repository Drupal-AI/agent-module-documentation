<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Smart Content CDN - agent index

Edge/CDN personalization for Smart Content on Pantheon. Version **1.1.1** (1.1.x), core `^8..^11`. Depends on `smart_content`, `smart_content_block`, `js_cookie`; uses `Pantheon\EI\HeaderData`.

- Config form `/admin/config/system/smart-content-cdn` (`smart_content_cdn.config`, perm `configure smart content cdn`, `restrict access: TRUE`); maps interest fields.
- `HeaderEventSubscriber::onRespond` (priority -200): adds `Audience`/`Interest` to the `Vary` header when response cache tags contain `smart_content_cdn.geo` / `smart_content_cdn.interest`.
- `SmartCDNCookie` subscriber reads/manages a `subscriberToken` cookie from the request.

Security: personalization keys off Pantheon-injected request headers; a client can only change which marketing variant they see (self-scoped), not access restricted content. Config route is behind a restricted permission. No verified finding.

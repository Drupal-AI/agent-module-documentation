<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Toasty (toasty) — agent index
**Toast-notification UI for Drupal Messenger messages, with real-time delivery via Pusher.**

- **Version:** 1.0.x (1.0.0-alpha3)
- **Core:** >=10.1 (PHP 8.1)
- **Depends on:** pusher_mini
- **Service:** `messenger.middleware.toasty_post_handle` (`ToastyPostHandleMiddleware`) — post-handle Messenger middleware.
- **Transport:** Pusher (via pusher_mini config).

**Security:** no routes, permissions, or admin forms of its own; it decorates the Messenger pipeline. Realtime credentials are managed by pusher_mini — ensure Pusher channels don't broadcast sensitive message content to unintended clients.

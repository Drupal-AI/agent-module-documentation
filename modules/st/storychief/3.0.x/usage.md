<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
StoryChief lets you post stories from the StoryChief platform to your Drupal site, with incoming webhook requests authenticated by an HMAC signature.

---

StoryChief integrates the StoryChief content-distribution platform — StoryChief pushes published
stories to the Drupal site (via a webhook) where they become content, so authors write once in StoryChief
and distribute to Drupal. It is configured at `storychief.admin` and provides its own permissions.

The incoming webhook is properly authenticated: `StoryChiefAccessCheck` recomputes an HMAC-SHA256 of the
payload keyed with the configured API key and compares it against the request's `mac` using
`hash_equals()` (constant-time), returning `AccessResult::forbidden` on mismatch. So a forged request
without the shared key cannot inject content — the correct posture for a content-push webhook. When
adopting, store the StoryChief API key as a secret (it authenticates the webhook), and be aware pushed
stories become site content (treat as trusted-source content since it's HMAC-authenticated, but the source
is whoever holds the key). Configure the connection and field mapping.

---

- Publish StoryChief stories to Drupal.
- Receive stories via webhook.
- Authenticate the webhook with HMAC.
- Recompute HMAC-SHA256 of the payload.
- Compare with hash_equals (constant-time).
- Reject forged requests (forbidden).
- Depend on the shared API key.
- Store the StoryChief API key as a secret.
- Configure at storychief.admin.
- Provide its own permissions.
- Write once, distribute to Drupal.
- Map StoryChief fields to content.
- Treat pushed stories as key-authenticated.
- Reject unsigned requests.
- Handle content push securely.
- Configure the connection.
- Publish from StoryChief.
- Verify the webhook signature.
- Distribute content to Drupal.
- Integrate StoryChief.

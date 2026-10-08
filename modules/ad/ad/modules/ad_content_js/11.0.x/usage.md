<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Experimental (WIP) submodule that adds a JavaScript advertisement type for running network/third-party ad scripts.

---

`ad_content_js` adds a **JavaScript advertisement** bundle (`javascript_ad`) to the `ad_content`
entity, with a single `field_javascript` (`string_long`) field meant to hold the JavaScript that
renders a third-party/network ad. It is marked **experimental** and is a work in progress: the
module's `hook_ENTITY_TYPE_view` implementation — the part that would inject the stored script into
the page — is entirely commented out in `ad_content_js.module`, so as shipped the type stores code
but does not execute it. It depends on `ad_content` and core `text`, ships the bundle, its
field storage/instance, and default form/view displays, and nothing else (no routes, services,
permissions, or config schema).

---

- Prototype a JavaScript-driven ad unit alongside image and text ads.
- Store a network/third-party ad script against an advertisement entity.
- Model an ad-network integration as a first-class ad type in the ad system.
- Reuse the standard ad workflow (placement, publishing, scheduling) for a JS ad.
- Author JS ad code through the normal ad content add/edit form.
- Evaluate the experimental JS ad type before it becomes functional.
- Keep JS ad content revisioned like other ad types.
- Restrict who may create JS ads via the ad_content per-type permissions.
- Plan for a future where network ad scripts render through the ad framework.
- Test the ad_content bundle/field plumbing for a code-carrying ad type.

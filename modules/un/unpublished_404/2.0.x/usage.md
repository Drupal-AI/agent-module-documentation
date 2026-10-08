<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Unpublished 404 makes an unpublished node return **404 Not Found** instead of **403 Forbidden** to visitors who aren't allowed to see it, so the existence of the node isn't leaked. It works automatically with zero configuration.

---

By default Drupal answers a request for an unpublished node that the current user cannot view with a `403 Access Denied`, which quietly confirms that *something* exists at that URL. This module registers an exception subscriber (`unpublished_404.not_found`, a `HttpExceptionSubscriberBase` handling `on403` at priority 1000, HTML format only) that intercepts those 403s: if the current user lacks the `view own unpublished content` permission **and** the request resolved to a `node` route parameter **and** that node is unpublished, it replaces the response by throwing a `NotFoundHttpException`, i.e. a 404. Published nodes, users who do have the permission, and non-node 403s are left untouched. There is no settings page, no config, no permissions of its own, no Drush, and no dependencies beyond core — installing it is the entire setup. This is an anti-enumeration / information-disclosure hardening measure: crawlers, scrapers, and curious visitors get an indistinguishable "page not found" for both nonexistent and merely-unpublished URLs.

---

- Hide the existence of unpublished/draft nodes from anonymous visitors (404 instead of 403).
- Prevent URL enumeration that would otherwise reveal which node IDs are "taken but hidden".
- Stop leaking that a soon-to-launch landing page already exists at a guessable path.
- Give embargoed press releases a clean 404 until they are published.
- Keep draft articles invisible to search crawlers that probe sequential `/node/N` URLs.
- Return 404 for unpublished content so it matches the site's normal not-found handling and theming.
- Harden a site against information disclosure without writing any custom code.
- Ensure scheduled/unpublished content can't be confirmed to exist before its go-live date.
- Present a consistent "not found" experience for both deleted and unpublished pages.
- Reduce the signal available to competitors scraping for unreleased products or posts.
- Avoid tipping off users that a moderated node is sitting unpublished in review.
- Complement content moderation workflows by hiding non-published revisions' URLs.
- Apply the behavior site-wide simply by enabling the module (no per-content-type setup).
- Let authors with `view own unpublished content` still reach their own drafts normally (they get 403/200, not 404).
- Combine with an editorial workflow where reviewers have the permission and the public does not.
- Make automated security scanners unable to distinguish hidden nodes from missing ones.
- Keep unpublished nodes out of "guess the ID" reconnaissance during a site launch.
- Provide privacy for members-only or gated draft content that hasn't gone live.
- Use on multisite/publishing platforms where hiding draft URLs is a baseline requirement.
- Avoid custom EventSubscriber boilerplate by using this drop-in module instead.

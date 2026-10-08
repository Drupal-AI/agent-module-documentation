<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Cookie Condition (commerce_cookie_condition) — agent index

**Commerce condition plugin** that is true when a named request cookie is present and equals a configured value.

**Version:** 1.0.x (1.0.0). Core: `^10 || ^11`. Depends on `commerce`.

Plugin: `UserCookieCondition` (`@CommerceCondition` id `user_cookie_condition`, category "Customer", entity_type `commerce_order`, parent_entity_type `commerce_promotion`). Reads cookies from `request_stack`; config form supplies the cookie name + expected value. No routes, permissions, services or admin page of its own — configured inside a promotion/condition host.

**Security:** evaluates a client-supplied cookie, so it is a targeting/marketing condition, not an access control (cookies are client-spoofable — do not use to protect sensitive access). No endpoints of its own; no findings.
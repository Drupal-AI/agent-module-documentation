<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cookie Condition adds one Drupal condition plugin (`cookie`) that matches when a named request cookie exists and either equals or contains a configured value.

---

Drupal's condition-plugin system underlies block visibility and a good deal of contrib — anything that collects conditions can collect this one. The module is a single class, `src/Plugin/Condition/Cookie.php` (plugin id `cookie`, label "Cookie"), extending core's `ConditionPluginBase`. Its form has three settings: the cookie name, an operator (`is` for exact match, `contains` for substring match), and the value to compare, alongside the standard "Negate the condition" checkbox inherited from the base class. At evaluation it reads the cookie from the current request's cookie bag (`request_stack` → `getCurrentRequest()->cookies`) and returns a boolean.

Put the condition on a block and the block shows only for visitors carrying that cookie/value; use it anywhere else conditions are gathered and it behaves identically. Because output that varies by cookie must vary the cache too, the plugin declares the matching `cookies:<cookie_name>` cache context, so a block placed with it caches per cookie value rather than serving one visitor's result to everyone.

A cookie is set by the client and can be forged from the browser, so this plugin decides what is *displayed*, not what is *permitted* — treat it as a presentation/visibility tool and keep genuine restrictions on permissions or entity access. The module has no menu, no site-wide settings, no routes, no permissions, and no dependencies beyond Drupal core; configuration lives entirely inside each host (e.g. a block's visibility settings).

---

- Show a block only to visitors carrying a specific cookie.
- Show a block only when a cookie holds an exact value (operator `is`).
- Show a block when a cookie value contains a substring (operator `contains`).
- Hide a block from visitors who have a given cookie (Negate).
- Hide a promotional banner once it has been dismissed via a cookie.
- Reveal a beta feature to an internal audience marked by a cookie.
- Vary a call-to-action block for returning visitors.
- Align a block with a consent cookie written by a cookie banner.
- Show a region-specific block based on an edge/CDN-set cookie.
- Suppress a block for users in a particular A/B-test bucket cookie.
- Display a welcome message to visitors arriving from a campaign cookie.
- Reuse the condition anywhere Drupal collects condition plugins (not just blocks).
- Combine it with other block-visibility conditions on the same block.
- Check for a cookie's presence by matching against its known value.
- Match an exact session/marketing cookie value with the `is` operator.
- Drive layout differences from a cookie your reverse proxy already sets.
- Gate a Layout Builder section's visibility on a cookie (any condition consumer).
- Avoid writing a custom condition plugin for a simple one-off cookie check.
- Understand why a cookie-varying block caches per value (the `cookies:` context).
- Provide presentation-only personalization without touching access control.

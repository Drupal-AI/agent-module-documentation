<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Cookie Condition adds a reusable Commerce condition, "Current user has cookie", that evaluates true when a specified cookie is present on the request and matches a configured value. It plugs into anywhere Commerce conditions apply — promotions, payment gateways, shipping and other condition-driven business rules.

The plugin (`user_cookie_condition`, category "Customer", parent entity `commerce_promotion`, applies to `commerce_order`) reads the current request's cookies via the request stack and compares the configured cookie name/value. Because it reads a client-supplied cookie, it is a marketing/targeting tool rather than a security control: cookies can be set or spoofed by the client, so do not use it to gate anything that must be tamper-proof.

There is no admin page of its own — you add the condition when configuring a promotion (or other condition host) and set the cookie name and expected value there. Typical uses are campaign attribution (a marketing cookie unlocks a discount) or steering checkout/pricing based on a tracking cookie.
---
Add the "Current user has cookie" condition to a promotion (or other Commerce host) and set the cookie name/value to match.
---
- Unlock a promotion only when a campaign cookie is set
- Match a marketing/UTM cookie to apply a discount
- Restrict a payment gateway to visitors with a cookie
- Target pricing based on a tracking cookie
- Gate a shipping method by cookie value
- Reward newsletter-referred visitors via a cookie flag
- Combine with other Commerce conditions on a promotion
- Check both cookie presence and exact value
- A/B a checkout path using a cookie
- Enable a partner/affiliate offer via a cookie
- Apply a condition scoped to commerce_order
- Configure the cookie name and value per condition instance
- Show a promotion only to returning-cookie visitors
- Layer campaign logic without custom code
- Reuse the same cookie condition across multiple promotions
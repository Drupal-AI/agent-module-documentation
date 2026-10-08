# Configuration

Registration Limit is configured from its settings form, which you open as a user
holding the module's administration permission (see below). Its settings are
stored in configuration and can be exported and deployed like any other Drupal
config.

## Grant the permission

At **People → Permissions** (`/admin/people/permissions`), grant the module's
administration permission — provided by Registration Limit — to the roles that
should be allowed to change its settings and manage the whitelist. Keep this to
trusted administrators only.

## Time window

This is the heart of the module: how recently an IP must have logged in for a new
registration from that same IP to be blocked. For example, a window of one day
means "if this IP was used to log into any account within the last 24 hours,
refuse a new registration from it." A longer window is stricter (blocks for
longer) but increases the chance of catching legitimate users who share an IP; a
shorter window is more permissive. Tune it to balance abuse prevention against
false positives for your audience.

## IP whitelist

Add any IP addresses that should **never** be blocked — for instance your office,
a testing machine, or a trusted partner network. Whitelisted IPs bypass the check
entirely, so registrations from them always proceed regardless of prior logins.
This is the escape hatch for the module's biggest weakness: shared or NAT IPs
where many legitimate people appear as one address.

## Save

Click **Save configuration**. The new window and whitelist apply to subsequent
registration attempts.

## Understand the limits (important)

Because Registration Limit keys on **IP address**, it is only a weak signal:

- **It can block legitimate users.** People behind a shared office, school,
  household, mobile-carrier, or VPN IP all look like one address. A strict window
  may refuse genuine sign-ups. Use the whitelist and a modest window to limit
  this.
- **It is easy to bypass.** An abuser can rotate IPs with a VPN, proxy, or
  botnet, so it will not stop a determined attacker.

Do not rely on it alone. Combine it with **CAPTCHA** (or Honeypot), **email
verification**, and Drupal's **flood control**, and keep admin approval on if your
policy needs it.

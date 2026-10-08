# Configuration

Simple IP Login is configured by creating **IP Wildcard** rules — each rule maps an
IP address pattern to a user account. When a request arrives from a matching IP, that
account is logged in automatically. Before you add any rule, read the safety notes at
the end of this page: a mistake here can hand out a logged‑in session to the wrong
people.

## Open the IP Wildcard collection

1. Log in as an administrator.
2. Go to **Configuration → System → Simple IP Login** (the module's IP Wildcard
   collection).

## Create an IP Wildcard rule

Add a rule that ties an **IP pattern** to a **user account**:

- **IP pattern** — a regular expression matching the client IP(s) you want to trust.
  For example, `/127\.0\.0\.0/` matches localhost, and a pattern like
  `/192\.[0-9]*\.[0-9]*\.[0-9]*/` matches addresses of the form `192.*.*.*`. Keep the
  pattern as tight as possible — match exactly the addresses you intend to, and no
  more.
- **User account** — the account to log in when the pattern matches. When a visitor's
  client IP matches, the module finalises a full authenticated session as this user.

Save the rule. From then on, a request from a matching IP is signed in automatically,
with no password prompt.

## Safety rules — read before mapping any IP

This feature grants a real session based only on the source IP, so treat it with the
same care as any authentication mechanism:

- **Trusted, controlled networks only.** Only map IPs you fully control — a kiosk, a
  locked‑down office network, a specific trusted device.
- **Never map a shared IP.** On NAT, CGNAT, office, or VPN networks, many people share
  one public IP. Everyone arriving from that IP would be logged in as the mapped
  account. Do not map an IP that untrusted users share.
- **Never map a privileged account on a shared network.** Mapping an administrator (or
  any high‑privilege role) to a broadly shared IP effectively hands that account to
  anyone on the network.
- **Fix your proxy configuration first.** The module reads the client IP through
  `getClientIp()`, which respects Drupal's trusted‑proxy settings rather than blindly
  trusting `X-Forwarded-For`. But if `settings.php` is set to trust all proxies, an
  attacker can spoof `X-Forwarded-For` and impersonate any mapped user. Configure
  `reverse_proxy` / `trusted_hosts` correctly before you rely on IP matching.

Used within these boundaries the module is a genuine convenience; used outside them it
becomes an authentication bypass. The risk lives in your deployment and configuration
choices.

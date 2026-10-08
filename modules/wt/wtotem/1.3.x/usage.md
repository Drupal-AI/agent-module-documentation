<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Integrate the WebTotem website-security monitoring service.

---

WebTotem helps increase the security of your website — integrating the WebTotem service (website security monitoring, malware/vulnerability scanning, defacement detection) so a Drupal site's security status is monitored and reported through the WebTotem platform.

**Security warning (as shipped, 1.3.1):** the WebTotem API client sets Guzzle `'verify' => false` (TLS certificate verification disabled) while sending the site's `Authorization: Bearer` token — a network MITM can steal the token and tamper with traffic. **Remove `'verify' => false`.** The WebTotem API token is admin-configured (store securely, env-backed). Supports Drupal 8.8 and 11.

---

- Integrate WebTotem monitoring.
- Scan for malware/vulnerabilities.
- Detect defacement.
- Report security status.
- WARNING: TLS verification disabled.
- Remove `'verify' => false`.
- Store the API token securely.
- Support Drupal 8.8 and 11.
- Aid website security.
- Handle WebTotem.
- Monitor security.
- Protect the site
- Support Drupal.
- Support Drupal.
- Support Drupal.

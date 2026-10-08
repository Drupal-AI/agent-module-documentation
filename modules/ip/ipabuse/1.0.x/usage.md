<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Automatically block malicious IPs using the ipabuse.org reputation database.

---

IPAbuse Firewall automatically blocks malicious IPs using the ipabuse.org reputation database — reporting brute-force logins and syncing a blocklist on cron, so known-bad IPs are denied access, hardening the site against abusive traffic.

Any ipabuse.org API credentials should be stored securely (env-backed). It's a defensive security module; IP-based blocking can affect shared IPs. Depends on core `user`; supports Drupal 10 and 11.

---

- Block malicious IPs.
- Use the ipabuse.org database.
- Report brute-force logins.
- Sync a blocklist on cron.
- Deny known-bad IPs.
- Harden against abuse.
- Store credentials securely.
- Depend on core `user`.
- Support Drupal 10 and 11.
- Watch shared-IP false positives.
- Aid security.
- Handle IP blocking
- Support Drupal.
- Support Drupal.
- Support Drupal.

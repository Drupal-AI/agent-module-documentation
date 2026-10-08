<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Password Stats provides statistics about the algorithms used in stored password hashes.

---

Password Stats **reports on the algorithms used in stored password hashes** — counting total hashes, legacy
hashes, and hashes matching given algorithm prefixes, so admins can find accounts still using outdated password
hashing that should be upgraded. It is in the Security package and exposes Drush commands.

Use it to audit password-hash strength across accounts. This is a **security-positive** audit tool. To be clear
about what it reads: it inspects the **hashed** `pass` values only (it cannot and does not read plaintext
passwords), classifying them by hash algorithm — useful for identifying legacy/weak hashes for rehashing.
Security note: password hashes are still **sensitive data**, so keep the stats output and Drush commands to trusted
administrators (don't expose hash counts/prefixes to untrusted users). It has no access-control role. Run the
password-hash audit.

---

- Report on password-hash algorithms.
- Count total/legacy/prefix-matching hashes.
- Find accounts on outdated hashing.
- Serve security/audit.
- Expose Drush commands.
- BE security-positive.
- READ only hashed pass values (never plaintext).
- Classify hashes by algorithm for rehashing.
- Keep hash stats/commands to trusted admins (hashes are sensitive).
- Have no access-control role.
- Run the password-hash audit.
- Handle hash stats.
- Audit hashes.
- Configure nothing (audit).
- Count hashes.
- Handle the stats.
- Classify hashes.
- Identify legacy hashes.
- Restrict the output.
- Provide password-hash statistics.

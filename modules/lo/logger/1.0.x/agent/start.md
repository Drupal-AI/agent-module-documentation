<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Logger — agent index

Flexible Drupal **logger** — stores custom metadata per entry, writes to **database/file/syslog/stdout-stderr**
(stdout for containers). Version **1.0.0-alpha6**. Core `^10||^11`.

Developer/logging. **Avoid logging secrets/PII**; file logs → outside the web root, not web-servable. No
content-access role.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Monolog-Logz — agent index

Configures Monolog to **ship Drupal logs to Logz.io** (hosted ELK/observability). Requires **PHP 8.2**;
depends on `monolog`. Version **1.0.1**. Core `^10||^11`.

**Security:** store the Logz.io shipping token as a secret; log content (possibly sensitive) is sent to
Logz.io — scrub sensitive data.

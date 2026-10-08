<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Monolog Datadog — agent index

Monolog handler to **ship Drupal logs to Datadog**. Depends on `monolog`. Version **3.0.1**. Core
`^10.1||^11||^12`.

**Security:** store the Datadog API key as a secret; log content (request data/errors, possibly sensitive)
is sent to Datadog — scrub sensitive data.

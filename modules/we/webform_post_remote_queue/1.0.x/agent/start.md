<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Post Remote Queue — agent index

**Queues Webform submissions and POSTs them to a remote endpoint** asynchronously (queue worker + retries).
Depends on `webform`. Version **1.0.0-beta3**. Core `^9||^10||^11`.

Forms/integration — submission **PII sent to a configured remote endpoint** (egress): trusted HTTPS endpoint,
store its auth secret securely, disclose the flow. No access role.

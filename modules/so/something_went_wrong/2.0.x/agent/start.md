<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Something Went Wrong — agent index

**Catches Drupal exceptions and sends them to Slack or mail**. Version **2.0.0-alpha1**. Core `^10||^11`.

Development/ops — exception reports include **stack traces/request data (sensitive)** and are **sent externally**
(Slack/email egress): trusted destination, treat the Slack webhook URL as a secret, consider redacting. No access
role.

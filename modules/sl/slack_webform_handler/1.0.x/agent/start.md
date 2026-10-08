<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Slack Webform Handler — agent index

**Sends messages to Slack when a webform is submitted**. Depends on `webform`. Version **1.0.1**. Core `^10||^11`.

Integration/notification — sends **submission data to Slack** (egress; can include PII); the **Slack webhook URL is
a secret** (store as env/Key, not committed; HTTPS). No access role.

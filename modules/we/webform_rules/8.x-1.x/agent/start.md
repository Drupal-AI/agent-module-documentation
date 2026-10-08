<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform Rules — agent index

Adds **Rules integration for Webform submissions** — Rules events on submit (trigger notifications,
entity create/update, service calls). Depends on `webform`, `rules`. Version **8.x-1.0-alpha2**. Core
`^8.8||^9||^10||^11`.

Automation/business-rules — review the configured Rules (esp. any changing access / creating privileged
entities / sending comms) so a submission can't trigger unintended privileged actions.

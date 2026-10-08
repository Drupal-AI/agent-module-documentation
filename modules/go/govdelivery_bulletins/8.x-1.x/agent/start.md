<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GovDelivery Bulletins — agent index

Service + queue for **sending bulletins via the GovDelivery (Granicus) Bulletins API** (gov email/SMS to
subscriber lists). Config at `govdelivery_bulletins.govdelivery_bulletins_admin_form`; provides permissions.
Version **8.x-1.12**. Core `^10.1||^11`.

**Security:** store GovDelivery credentials as **secrets**; HTTPS; gate who can trigger bulletins (sends
reach real subscribers). No content-access role beyond permission.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions

From `registration_cancel_by.permissions.yml`:

| Permission | Allows |
|---|---|
| `bypass cancel by access` | cancel a registration **after** its host's `cancel_by` deadline has passed |

Without this permission, a registrant may cancel only while the current time is before the host's
`cancel_by` date (enforced by `CancelByAccessCheck` on the cancel transition route). Grant it to staff
roles that need to make late cancellations.

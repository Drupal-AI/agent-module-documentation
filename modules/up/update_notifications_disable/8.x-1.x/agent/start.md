<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Update Notification Disable — agent index

Turns off **core's update notifications** + removes the "Update Status module not enabled" warning. Version
**8.x-1.3**. Core `>=8.9<12`.

**SECURITY CAVEAT — risky:** these warnings tell admins about **security updates** (the key defense against
known vulns). Disabling them can leave a site silently unpatched. **Only defensible if updates are reliably
tracked/applied by another mechanism** (Composer + monitoring pipeline/platform) that surfaces security
updates — otherwise it removes a critical safety net. Don't enable without that. No content-access role.

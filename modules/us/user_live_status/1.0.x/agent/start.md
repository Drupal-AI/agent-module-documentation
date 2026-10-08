<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User Live Status (user_live_status) — agent index
**Per-user presence status (online/busy/away/offline) with a colored toolbar indicator.**

- **Version:** 1.0.x (1.0.2)
- **Core:** ^10.3 || ^11
- **Field:** `user_status` on the user entity.
- **Route:** `user_live_status_toolbar.set` `/admin/user-live-status/{status}` → `UserLiveStatusController::setStatus` (`_permission: 'access toolbar'`).
- **Toolbar:** `UserLiveStatusHooks::toolbar()` (tray with Online/Busy/Away/Offline links); CSS library `user_live_status/status`.

**Behaviour:** the route updates only the *current* user's own status (`$this->currentUser()`); other users' presence is not exposed.

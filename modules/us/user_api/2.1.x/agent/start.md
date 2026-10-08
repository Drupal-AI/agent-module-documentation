<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User API — agent index

**REST resources for user registration and management** (register, set-password, cancel, resend email). Depends on
core `rest`, `user`, `simple_oauth`, `verification`. Version **2.1.0**. Core `^10.3||^11`.

Web-services/auth — **securely built**: set-password changes only the **current user's** password and needs the
**current password or a `verification` token** (no takeover); registration **respects core registration settings**
(approval/activation; no role/status injection) via the core resource. Gate the `restful post <resource>`
permissions to intended roles, **rate-limit** public register/resend endpoints, HTTPS.

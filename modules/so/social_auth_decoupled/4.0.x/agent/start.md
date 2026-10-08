<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Social Auth Decoupled — agent index

A **base module for decoupled (headless) social login** on the Social Auth framework (returns the user ID + a
**CSRF token** to the front end). Depends on `social_auth`, core `system`. Version **4.x** (dev). Core
`^9.5||^10||^11`.

Auth — builds on **Social Auth** (provider flow/state) and core's **CSRF token generator**. For decoupled
auth: HTTPS, safe token storage on the client, scoped origins (CORS). Grants access via the wrapped Social Auth
login.

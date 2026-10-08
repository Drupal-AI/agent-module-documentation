<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# League OAuth Login Slack — agent index

A **Slack provider plugin for League OAuth Login** (log in with Slack). Depends on `league_oauth_login` (which
owns the login flow). Version **8.x-1.4**. Core `^8||^9||^10||^11`.

Only the Slack provider plugin — the redirect/callback flow is in base `league_oauth_login`. Store the Slack
**client secret** as a secret; HTTPS.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Persistent Visitor Parameters — agent index

**Captures GET/HTTP request parameters from a visitor and persists them** across the session (UTM/campaign/
referral; `persistent_visitor_parameters_user_registration` submodule attaches them at registration). Provides
permissions. Version **1.0.1**. Core `^10.3||^11`.

Marketing/attribution — persisted values are **user-controlled input**: sanitize/escape on output (reflected
XSS), validate before storing, don't trust for security. No access role beyond permission.

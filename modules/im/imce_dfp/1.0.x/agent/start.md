<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# IMCE Dynamic File Path — agent index

Adds **dynamic (token-based) upload path functionality to IMCE profiles** (compute the IMCE upload dir per
user/token vs a fixed folder). Depends on `imce`. Version **1.0.0**. Core `^9||^10||^11`.

Media/file-management — ensure the computed path stays **within the intended, permission-scoped area** (a path
outside a user's folder widens file access); IMCE profile permissions gate access. No other access role.

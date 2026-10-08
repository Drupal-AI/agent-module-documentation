<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Teamleader — agent index

Integrates the **Teamleader CRM** with Drupal via its API (`teamleader_contact` submodule). Provides
permissions. Version **4.0.1**. Core `^10.2||^11||^12`.

Integration/CRM — authenticates via **OAuth2** (client credentials/tokens as secrets, HTTPS); sends
**contact/customer PII** to Teamleader (egress/privacy — per policy). No access role beyond permission.

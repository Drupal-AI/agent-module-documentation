<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Salesforce OAuth Password Provider — agent index

Provides **password-based (OAuth username-password grant) Salesforce authentication** (username + password +
security token + consumer key/secret). Depends on the Salesforce Suite. Version **1.0.1**. Core
`^9||^10||^11`.

**SECURITY CAVEAT:** this flow **stores/uses a Salesforce password** — store **all** credentials (username/
password/security-token/consumer key+secret) as **secrets**; HTTPS; dedicated least-privilege integration
user. The username-password flow is **less secure / being deprecated by Salesforce** — **prefer JWT bearer or
client-credentials** flows. No access role.

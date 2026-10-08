<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node Package Manager (npm) — agent index

Provides **npm actions from Drupal** (require packages, run scripts) — for build/tooling workflows. Version
**3.0.1**. Core `^9||^10||^11`.

**SECURITY — dangerous by design:** requiring/running invokes **npm on the server** = **code execution**
(npm installs run untrusted third-party scripts as the web/CLI user). Dev/build-time tool only — restrict to
trusted admins/CLI, **never expose to untrusted users**, be very cautious on production. No content-access
role but severe capability.

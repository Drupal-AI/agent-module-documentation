<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Module Manager manages and installs Drupal.org modules from the web UI.

---

Module Manager **manages and installs Drupal.org modules from the admin UI** — it browses drupal.org, downloads
a chosen module's release ZIP, validates it with Composer, extracts it and enables/disables/removes modules, all
from within Drupal. Its routes are gated by core's `administer modules` permission.

Use it to add modules without shell/Composer access. This is a **powerful, code-execution-capable** capability and
should be treated with the same caution as core's web-install flow. Understand the risk: installing a module means
**adding executable code to the running site**, so a compromise of any account with `administer modules` becomes
arbitrary code execution, and it **bypasses your controlled deployment pipeline** (Composer/CI, code review, lock
files). It downloads release archives from the network and installs them — trust of that supply chain matters.
Mitigations: keep `administer modules` restricted to fully-trusted administrators, prefer **Composer-based
deployment** for production, and consider that on hardened sites you may want the opposite (see the
`disable_web_install` module, which blocks web installs entirely). Use it deliberately and ideally only in
non-production contexts.

---

- Install Drupal.org modules from the UI.
- Download a release ZIP + Composer-validate + enable.
- Browse/enable/disable/remove modules.
- Gate routes by core's 'administer modules' permission.
- Serve module administration.
- Add modules without shell/Composer.
- BE code-execution-capable (installing a module adds executable code).
- BYPASS the controlled deployment pipeline (Composer/CI/review).
- Turn an 'administer modules' account compromise into arbitrary code execution.
- Keep 'administer modules' to fully-trusted admins + prefer Composer deployment.
- Consider disable_web_install for hardened/production sites.
- Use it deliberately, ideally non-production.
- Handle module installing.
- Install modules.
- Configure nothing (action).
- Download modules.
- Handle the install.
- Enable modules.
- Restrict the permission.
- Provide web module installation.

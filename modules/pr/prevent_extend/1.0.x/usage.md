<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Prevent Extend disables the admin Extend menu.

---

Prevent Extend **disables the admin Extend menu** — removing the UI to install/uninstall modules, so
modules can't be enabled/disabled through the web interface (only via code/config deployment). It is in the Other
package.

Use it to lock down module management on production. This is a **security-hardening** measure: installing a
module is effectively arbitrary-code execution, so blocking the Extend UI reduces the blast radius if an admin
account is compromised (an attacker with admin access can't trivially enable a malicious module via the UI). Note
it is defense-in-depth, not absolute (someone with file/deployment access can still change modules), and it
removes a legitimate admin tool (manage modules via deployment instead). It has no per-content access role.
Enable it to hide the Extend page.

---

- Disable the admin Extend menu.
- Block installing modules via the UI.
- Force module changes via deployment.
- BE a security-hardening measure.
- Reduce blast radius if admin is compromised.
- Treat module install as code execution.
- Be defense-in-depth (not absolute).
- Note file/deploy access can still change modules.
- Remove a legitimate admin tool (use deployment).
- Have no per-content access role.
- Enable it to hide the Extend page.
- Handle the Extend page.
- Hide Extend.
- Configure nothing (behavior).
- Lock down modules.
- Handle the hardening.
- Block module UI.
- Restrict Extend.
- Harden production.
- Provide Extend-menu blocking.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Node Package Manager provides npm actions such as requiring a package or running a script, executing npm commands from Drupal.

---

Node Package Manager (npm) provides npm actions from within Drupal — requiring npm packages, running npm
scripts, and similar — for build/tooling workflows that need to invoke npm (e.g. building front-end assets).
It is in the Javascript package.

**Security caveat — this executes shell/npm commands, effectively code execution on the server.** Requiring
a package or running a script invokes npm on the server (which runs arbitrary package install/build scripts
as the web/CLI user), so this is a powerful, dangerous-by-design capability: anyone who can trigger these
actions can effectively run code on the server, and npm package installs run untrusted third-party install
scripts. Therefore: treat it as a **development/build-time tool**, restrict its actions to trusted
administrators/CLI only, **never expose npm actions to untrusted users**, and be very cautious about running
it on production (arbitrary npm execution on a live server is a major risk). It has no content-access role,
but its capability is severe. Use it only in controlled build contexts.

---

- Run npm actions from Drupal.
- Require npm packages.
- Run npm scripts.
- Build front-end assets.
- Understand it executes shell/npm commands.
- Treat it as code execution.
- Restrict actions to trusted admins/CLI.
- Never expose npm actions to untrusted users.
- Be cautious on production.
- Know npm installs run untrusted scripts.
- Use as a dev/build-time tool.
- Avoid arbitrary npm on live servers.
- Have no content-access role (but severe capability).
- Use in controlled build contexts.
- Restrict tightly.
- Run build tooling.
- Manage npm packages.
- Execute npm safely.
- Guard the dangerous capability.
- Use for builds only.

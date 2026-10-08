<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Backward Compatibility switches off Drupal's core-compatibility check so a module whose `core_version_requirement` excludes your running core can still be installed and enabled.

---

Do not mistake this for a compatibility layer: it restores no functions, defines no services, and ships no shims. The entire module is one `hook_system_info_alter()` that sets `$info['core_incompatible'] = FALSE` on **every** extension Drupal inspects, plus a `hook_install()` that gives itself weight **-1000** so the alter runs before anything else. The net effect is that Drupal's extension system stops refusing to install modules that declare — via `core_version_requirement` — that they do not support the current core major. It is the code equivalent of hand-patching every module's `.info.yml` to add `^9 || ^10 || ^11`, which is exactly the maintainer's stated intent: a way to install and test modules that merely *forgot* to widen their core constraint, without editing files. What it explicitly does **not** do is make an old module actually work — if the module calls a function or service that core has genuinely removed, it will still fatal at runtime. So the honest workflow is: install this, enable the target module, and find out whether it runs. If it runs, the module was compatible all along and only its metadata was stale; if it fatals, you have learned that real porting work is needed, and this module bought you nothing but the crash. Because the flag is set unconditionally for all extensions, this is a blunt, site-wide override of a guardrail that exists to stop untested code from loading against a core it was never verified against — appropriate on a scratch/upgrade-testing environment, reckless as a permanent fixture on production. Version **1.0.2** (**2023**), Custom package, declaring `^9 || ^10 || ^11`; a 2023 module asserting support for a later core major is itself a declaration, not a test result.

---

- Install a contrib module that only forgot to add `core_version_requirement: ^9 || ^10 || ^11`.
- Enable a module Drupal marks "incompatible" so you can find out if it actually runs.
- Test a stalled contrib module against a new core major before doing real porting work.
- Avoid hand-patching many modules' `.info.yml` files just to widen their core constraint.
- Set up a throwaway upgrade-testing environment where every module is allowed to load.
- Trial an inherited custom module whose metadata predates the current core.
- Unblock the install screen when a module's only problem is a stale core declaration.
- Distinguish "metadata is stale" from "code is genuinely broken" by seeing whether it fatals.
- Prototype a core upgrade quickly without first fixing every module's `.info.yml`.
- Keep an in-progress upgrade moving while porting patches land upstream.
- Enable a module during a migration dry-run to inventory what still breaks.
- Bypass the compatibility gate for a module you have separately verified is fine.
- Reproduce a module's runtime failure on new core to file an accurate porting issue.
- Allow a site to boot with an over-strict but functionally-fine module enabled.
- Batch-evaluate a set of contrib modules for "works if allowed to load" versus "needs a port".
- Run local experiments against modules that pin an older core than you are testing on.
- Temporarily silence the "This module is incompatible with this version of Drupal" message.
- Give a module manager the chance to enable something core would otherwise refuse.
- Confirm a dependency chain installs once the artificial core block is removed.
- Stage an upgrade where you plan to remove this module again the moment porting is complete.

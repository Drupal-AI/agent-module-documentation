<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DPL Override is a placeholder/test module ("A module to check dpl override capabilities") that ships only an info.yml and a license — it contains no routes, services, hooks, or PHP classes.

---

Enabling it registers the module with Drupal but adds no functional behavior; it appears to exist to verify module-override or deployment tooling for a "DPL" distribution/package. There is nothing to configure and no runtime surface.

---
- Enable the module to register it with Drupal.
- Use it to test module deployment/override tooling.
- Confirm it adds no routes, services, or permissions.
- Disable/uninstall it safely; it holds no data.
- Treat it as a scaffolding/placeholder reference.
- Verify module enable/uninstall hooks in a distribution.
- Use as a smoke-test target for override tooling.
- Confirm no config schema or permissions are added.
- Include in a DPL package build to validate packaging.
- Check that core_version_requirement resolves on D9/D10.
- Clone as a starting scaffold for a real module.
- Ensure it leaves no residual data after uninstall.
- Validate deployment pipelines register the module.
- Use to test dependency resolution with an empty deps list.
- Document it as a non-functional placeholder for auditors.

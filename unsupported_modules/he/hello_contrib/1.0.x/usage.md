<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Hello Contrib is a minimal module built to test the Drupal.org contrib publication workflow; it exposes a single admin page that prints a greeting.
---
The module registers one route, `hello_contrib.admin` at `/admin/hello-contrib`, gated by the core `access administration pages` permission, whose controller returns a translated `#markup` string ("Hello Drupal Contrib 👋"). There is no configuration, no services, no custom permissions, and no data handling — it exists purely as a reference/skeleton and as a smoke test for packaging and enabling a contrib module.

It is useful as a copy-paste starting point for a new module (info.yml + routing.yml + a ControllerBase subclass) and to verify that a fresh contrib project installs and enables cleanly on Drupal 10/11.

Typical setup: enable the module and visit `/admin/hello-contrib`.
---
- Verify a new contrib module installs and enables on D10/D11.
- Use as a minimal module skeleton to copy from.
- Learn the info.yml + routing.yml + controller pattern.
- Smoke-test the Drupal.org packaging workflow.
- Confirm an admin route renders behind a core permission.
- Demonstrate returning a render array from a controller.
- Teach `ControllerBase` and `$this->t()` usage.
- Provide a "hello world" page for onboarding.
- Test Composer `require drupal/hello_contrib` flow.
- Test `drush en hello_contrib` enablement.
- Show the simplest possible admin menu route.
- Serve as a reference for permission-gated pages.
- Use in tutorials about module scaffolding.
- Validate a CI pipeline against a trivial module.
- Check that translations work for controller markup.
- Confirm `access administration pages` gating.
- Provide a baseline for measuring module overhead.
- Demonstrate a route + title definition.
- Use as a placeholder while scaffolding a real module.
- Sanity-check a local dev environment setup.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
WissKI Coding Standard ships PHPCS sniffs for the project's code style. Its own description says, in capitals: **DO NOT INSTALL THIS MODULE.**

---

This is a development artefact, not a site module. It contains PHPCS sniffs used when writing WissKI code — the kind of thing that belongs in a contributor's toolchain, invoked by a linter, not enabled on a Drupal site.

The instruction in its own info file is unambiguous and should be repeated rather than softened: *"PHPCS sniffs for WissKI code style checks. DO NOT INSTALL THIS MODULE."*

Its usefulness is to someone contributing to WissKI, who should point their PHPCS installation at these sniffs so their patches match the project's conventions. For anyone running a WissKI site it has no function, and enabling it on a production site is the kind of thing an audit should flag — not because it is dangerous, but because a module enabled for no reason is a module nobody is thinking about.

If you find it enabled, uninstall it and check what else was enabled at the same time; it usually indicates that everything in the project directory was turned on indiscriminately.

---

- Check WissKI code against project style.
- Point PHPCS at the project's sniffs.
- Match a patch to project conventions.
- Contribute code to WissKI.
- Recognise a development-only module.
- Avoid installing it on a site.
- Uninstall it if found enabled.
- Check what else was enabled alongside it.
- Detect indiscriminate module enabling.
- Audit a production site for dev modules.
- Run style checks in CI.
- Understand the project's conventions.
- Review a contribution before submitting.
- Document its exclusion from site installs.
- Add it to a contributor guide.

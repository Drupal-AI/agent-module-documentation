<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Test Commit Message is a fixture module that intentionally calls deprecated Drupal 10/11 APIs so drupal-rector can generate patches against it during automated testing.
---
It exists purely to exercise the drupal-rector `project_analysis` flow and the project-update bot's GitLab issue posting; it provides no site functionality. The `.module` file deliberately uses deprecated APIs — the `REQUEST_TIME` constant (dep. 10.0), `watchdog_exception()` (10.1), `check_markup()` (11.0), `filter_formats()`/`filter_fallback_format()` (11.4), and `system_region_list()`/`system_default_region()` (11.4) — each mapped to the specific rector rule expected to rewrite it.

Do not enable this on a real site: it is a CI/testing artifact. Use it as a target for running drupal-rector and verifying the generated patches, commit messages and bot issue output.
---
- Provide a rector target containing known deprecated APIs.
- Test `ReplaceRequestTimeConstantRector` against `REQUEST_TIME`.
- Test `WatchdogExceptionRector` against `watchdog_exception()`.
- Test `CheckMarkupToProcessedTextRector` against `check_markup()`.
- Test `FilterFormatFunctionsToServiceRector` against `filter_formats()`.
- Test `SystemRegionFunctionsRector` against region functions.
- Validate drupal-rector patch generation end to end.
- Exercise the project-update bot's GitLab issue posting.
- Verify generated commit messages for rector patches.
- Serve as a reference for what deprecated calls look like.
- Run `project_analysis` against a controlled fixture.
- Confirm rector rules map to the right code patterns.
- Regression-test rector after Drupal core updates.
- Demonstrate Drupal 10→11 deprecation migrations.
- Keep a stable, minimal reproduction for CI.
- Train contributors on fixing deprecations.
- Compare before/after code for each rector rule.
- Benchmark rector runtime on a small module.
- Test automated MR creation workflows.
- Document the deprecated-API-to-rule mapping.

Editoria11y CSA (Community-Supported Addons) extends Editoria11y with an extra developer/contrast test suite, custom-test config entities, a crawler dashboard, and license/maintenance tooling.

---

CSA layers optional "pro"/community features on top of the base Editoria11y checker. It adds a color-contrast test and a separate developer-oriented test suite that can be shown only to developer roles on designated development domains, configured on its own settings form (`/admin/config/content/editoria11y/csa`). It introduces an `ed11y_custom_test` config entity so site builders can define their own named tests (test key, tooltip title/body) and manage them at `/admin/config/content/editoria11y/custom-tests`. A crawler View plus dashboard-actions form give maintenance and bulk update tools, and a `hook_cron` keeps things current. Because some capabilities are gated by a membership license, CSA ships a `LicenseManager` (with the Key module for secure key storage) and Drush commands to set the key, activate/deactivate, check status, and lock/unlock. It requires the main `editoria11y` module and reuses its permissions (`administer editoria11y checker`). Use it when you need contrast checking, developer-only tests, or your own custom accessibility rules beyond the built-in Editoria11y test set.

---

- Add color-contrast checking to the Editoria11y checker.
- Run a developer-only test suite visible only to developer roles.
- Limit developer tests to specified development domain patterns.
- Define a custom accessibility test as a config entity.
- Give a custom test its own tooltip title and guidance text.
- Manage a library of custom tests in an admin list.
- Override which built-in tests are shown to content editors vs developers.
- Ignore specific selectors for the contrast test (e.g. `.sr-only`).
- Set a developer-specific scan root selector.
- Provide a crawler dashboard view for site-wide sweeps.
- Run maintenance/update actions from a dashboard actions form.
- Store the CSA membership license key securely via the Key module.
- Activate the CSA license from the command line with Drush.
- Check CSA license status via Drush.
- Deactivate or lock/unlock the license during maintenance.
- Keep dashboard data fresh with a cron task.

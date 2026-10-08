<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Webform MyEmma (webform_myemma) — agent index

**What**: Provides a single Webform handler plugin (`myemma`) that, on a new submission,
imports the submitted email address and mapped element values into one or more MyEmma
(Emma) email-marketing groups via the `judicialcouncil/emma` client
(`JudicialCouncil\Emma\JccClient::import_single_member()`).

**Dependencies**: `webform:webform` (module). Composer: `judicialcouncil/emma:^4.0`,
`drupal/webform:^6.2 || ^6.3`. Core `^10.3 || ^11.0`. Package: Webform.

**Provides**
- Webform handler plugin: `WebformMyEmmaHandler` (`@WebformHandler id="myemma"`,
  cardinality unlimited, results processed) — `src/Plugin/WebformHandler/WebformMyEmmaHandler.php`.
- Settings form: `SettingsForm` (`ConfigFormBase`) — `src/Form/SettingsForm.php`.
- Config object + schema: `webform_myemma.settings` — `src/config/schema/webform_myemma.schema.yml`.
- Permission: `administer webform myemma` — `webform_myemma.permissions.yml`.
- Route: `webform_myemma.settings` → `/admin/config/services/webform_myemma`
  (permission `administer webform myemma`) — `webform_myemma.routing.yml`.
- Admin menu link: `webform_myemma.admin` under System > Configuration > Web services —
  `webform_myemma.links.menu.yml`.
- `hook_help()` (renders README.md) and `hook_requirements()` (install-phase library check) —
  `webform_myemma.module`, `webform_myemma.install`.

**Solution docs**
- Configure MyEmma accounts / credentials: [`agent/config/settings.md`](config/settings.md)
- The `myemma` webform handler (mapping + submission flow): [`agent/plugins/handler.md`](plugins/handler.md)

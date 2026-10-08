<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Sites devel is a development aid for the Sites multi-site ecosystem that renders a debug block and unlocks Devel dumper output while the Sites `sites.development` parameter is TRUE.
---
The module adds a "Sites devel debug" block that dumps the site candidates, active site, current route, language and (when the `sites_path_alias`/`sites_redirect` submodules are present) path-alias and redirect information for the current request. It also ships a service that decorates Devel's `devel.dumper` (`DevelDumperManagerDecorator`) so dumper output is shown to developers whenever development mode is on — bypassing the usual Devel access permission.

Access to the debug features is granted to users holding the *Use sites development* permission (`use sites_devel`, marked `restrict access: true`) or to everyone while the container parameter `%sites.development%` is TRUE. Because that parameter opens the dumper to all visitors, this is strictly a development module and must not be enabled on production. There is no admin form and no configuration route — enabling the module is the whole setup.
---
- Install alongside Sites + Devel to inspect multi-site request resolution.
- View the active site chosen for the current request.
- See the ordered list of site candidates considered for the request.
- Inspect the matched route name in the debug block.
- Check the negotiated language for the current page.
- View path-alias info per site when `sites_path_alias` is installed.
- View redirect info for the current entity when `sites_redirect` is installed.
- Grant the "Use sites development" permission to a developer role.
- Toggle site development mode via the `sites.development` parameter.
- Let Devel dumper output render without the standard Devel permission in dev mode.
- Debug why a given hostname resolves to a particular site.
- Confirm which site context a block or view is running under.
- Diagnose language negotiation issues in a multi-site build.
- Keep the block enabled only in local/dev environments.
- Remove or disable the module before deploying to production.
- Pair with the `redirect` module (suggested dev dependency) for richer output.
- Use it as a reference for decorating Devel's dumper service.
- Verify the Sites plugin is picking the expected canonical site.
- Troubleshoot per-site path aliases during content editing.
- Read request internals without adding ad-hoc `dump()` calls in code.

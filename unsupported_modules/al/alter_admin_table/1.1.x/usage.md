<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Alter Admin Table adds admin-side table tooling that lets you tailor listing columns to content-type fields and find modules to install.

---
The module ships a single help hook and one route, `/alter-admin-table` (`_permission: 'access content'`), whose controller currently returns a "Hello World" placeholder. Its intended purpose per the README is to make admin listing tables (and module discovery for newcomers/site builders) easier by exposing composer commands and column customisation. There is no configuration form and no writable/state-changing endpoint.

Operationally it is a lightweight developer/admin convenience module; the shipped controller is a stub, so most value is in the help text and the alteration hooks. No secrets, no external calls.
---
- Enable the module to add its admin-table help.
- Visit `/alter-admin-table` to see the module's help page.
- Read hook_help output on the module's route.
- Use it as a starting point for customising admin listing columns.
- Tailor admin table columns to content-type fields.
- Help new site builders discover modules to install.
- Surface composer commands for module installation.
- Review the module list from an admin-friendly table.
- Grant `access content` to expose the help route.
- Restrict the route by tightening the `access content` permission.
- Combine with core's Extend page for module management.
- Inspect the `HelperController::test` output.
- Extend the controller to render a real admin table.
- Document admin table conventions for your team.
- Keep as a scaffold for admin dashboard reporting.
- Remove if you only need core's module list.

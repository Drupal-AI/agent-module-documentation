<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Site Config provides functionality to manage the global site configuration.

---

Site Config provides **management of global site configuration** — a place to define/edit site-wide
settings (with language support), plus `site_config_jsonapi` and `site_config_rest` submodules that **expose
that config over JSON:API/REST** for decoupled front ends. It depends on core Language, in the Site Config
package.

Use it to manage and (optionally) expose global settings. It is an administration/config feature with a
web-services angle: if you enable the **JSON:API/REST** submodules, the site config becomes **readable over an
API** — so only expose settings that are safe to be **public** (don't expose secrets/admin-only settings via
the API), and gate the REST resources appropriately. It has no access-control role of its own. Configure the
site config and (if used) the API exposure carefully.

---

- Manage global site config.
- Support site-wide settings.
- Optionally expose config via JSON:API/REST.
- Depend on core Language.
- Provide jsonapi/rest submodules.
- Serve decoupled front ends.
- Only expose settings safe to be public.
- Not expose secrets/admin settings via the API.
- Gate the REST resources.
- Have no access-control role of its own.
- Configure the config + API exposure carefully.
- Handle site config.
- Manage settings.
- Configure the config.
- Expose config.
- Handle the settings.
- Manage globals.
- Configure exposure.
- Restrict the API.
- Provide site config.

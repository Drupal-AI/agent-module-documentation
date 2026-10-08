<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON:API Menu adds a JSON:API resource for menus with items.

---

JSON:API Menu adds a **JSON:API resource for menus** — exposing a menu and its (nested) menu items over
JSON:API, so a decoupled front end can fetch the site's navigation menus. It depends on core Menu Link Content
and the JSON:API Resources module.

Use it to consume menus in a decoupled front end. It is a decoupled/web-services feature. Security note: it
exposes **menu structure and link items** over JSON:API — menus are usually public navigation, but be aware
the endpoint reveals the menu tree (including any links to admin/less-discoverable paths that are in the menu),
so don't put sensitive URLs in exposed menus and rely on each linked route's own access for actual protection.
It has no access-control role of its own. Enable the menu resource.

---

- Expose menus over JSON:API.
- Return a menu and its items.
- Serve decoupled front ends.
- Depend on Menu Link Content and JSON:API Resources.
- Fetch navigation menus.
- Return nested menu items.
- KNOW it reveals the menu tree.
- Not put sensitive URLs in exposed menus.
- Rely on each route's own access.
- Have no access-control role of its own.
- Enable the menu resource.
- Handle menu JSON:API.
- Expose navigation.
- Configure the resource.
- Return menus.
- Handle the integration.
- Expose menu items.
- Fetch menus.
- Enable it.
- Provide menu JSON:API.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permission

`mathjax.permissions.yml` defines exactly one permission:

| Permission | Title | Flags |
|---|---|---|
| `administer mathjax` | Administer MathJax | `restrict access: TRUE` |

It is the `_permission` requirement of the only route the module declares, `mathjax.settings`
(`/admin/config/content/mathjax`), and therefore controls the CDN URL, the configuration mode,
the raw JSON `config_string` and the admin-pages toggle.

Because `config_string` is injected verbatim into `window.MathJax` by `js/config.js`, this
permission lets a user inject arbitrary JavaScript configuration — hence `restrict access: TRUE`.
Grant it only to trusted administrators.

```bash
drush role:perm:add site_admin 'administer mathjax'
drush php:eval 'foreach (\Drupal::entityTypeManager()->getStorage("user_role")->loadMultiple() as $r) {
  if (in_array("administer mathjax", $r->getPermissions(), TRUE)) { print $r->id() . "\n"; }
}'
```

Adding the **MathJax filter** to a text format is a separate concern, gated by core's
`administer filters`. Which users see typeset maths is decided by their access to the text format,
not by any MathJax permission.

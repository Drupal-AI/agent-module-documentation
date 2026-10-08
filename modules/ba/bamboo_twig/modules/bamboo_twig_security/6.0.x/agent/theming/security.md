<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permission & role checks

Class `Security`, service `bamboo_twig_security.twig.security` (constructor args
`@current_user`, `@entity_type.manager`). When the `user` argument is omitted the **current user**
is used. For an anonymous or non-existent user the functions return `null` (falsy).

- `bamboo_has_permission(permission, user = null)` → bool.
- `bamboo_has_permissions(permissions[], conjunction = 'AND', user = null)` → bool; `conjunction`
  must be `'AND'` or `'OR'` (anything else throws `InvalidArgumentException`).
- `bamboo_has_role(role, user = null)` → bool (role machine name).
- `bamboo_has_roles(roles[], conjunction = 'AND', user = null)` → bool.

```twig
{% if bamboo_has_permission('access administration pages') %}
  <a href="/admin">Admin</a>
{% endif %}

{% if bamboo_has_role('editor') or bamboo_has_role('administrator') %}…{% endif %}

{% if bamboo_has_roles(['editor', 'reviewer'], 'OR') %}…{% endif %}

{# check a specific user by uid #}
{% if bamboo_has_role('administrator', 1) %}user 1 is an admin{% endif %}
```

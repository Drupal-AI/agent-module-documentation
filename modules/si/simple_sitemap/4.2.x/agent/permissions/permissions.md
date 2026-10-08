# Permissions

Defined in `simple_sitemap.permissions.yml`.

| Permission | Gates |
|---|---|
| `administer sitemap settings` | Full access to the Simple XML Sitemap admin UI: entity/bundle inclusion, variants, sitemap types, custom links, settings, and on-demand generation. Restricted (trusted) permission. |
| `edit entity sitemap settings` | Lets a user change sitemap inclusion/priority/changefreq on individual entity add/edit forms (without full admin access). |

```
drush role:perm:add content_editor 'edit entity sitemap settings'
```

Submodule `simple_sitemap_engines` adds `index entity on save` (send an IndexNow notice on
entity save). `simple_sitemap_views` defines no permissions.

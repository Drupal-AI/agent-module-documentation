# Ban — permission

One permission, defined in `ban.permissions.yml`:

- **`ban IP addresses`** — required to reach the IP-ban admin page (`/admin/config/people/ban`) and
  its add/unban routes (`ban.admin_page`, `ban.delete`, `ban.delete.multiple`). This is a
  restricted, trusted permission (it lets a user block site access by IP).

```bash
drush role:perm:add site_admin 'ban IP addresses'
```

There is no separate permission for the CLI commands — they run with the CLI user's privileges.

# Honeypot permissions

`honeypot.permissions.yml`:

- **administer honeypot** — access the settings form (`honeypot.config`) and manage which
  forms are protected.
- **bypass honeypot protection** — users with this permission are exempt from all honeypot
  checks (hidden field + time restriction). Grant to trusted authenticated/editor roles so
  legitimate fast submissions are never rejected.

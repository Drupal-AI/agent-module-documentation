# username_enumeration_prevention — agent start

Security hardening module that stops attackers enumerating valid usernames/emails.
Two mechanisms, **no configuration and no admin UI** — enable it and it works.
Depends only on core `user`. Defines no permissions, routes, config, or Drush commands.

- How the two protections work (forgot-password message + 403→404 on user routes),
  what enable-and-forget means, and the one core permission that can defeat it →
  [extend/username_enumeration_prevention.md](extend/username_enumeration_prevention.md)

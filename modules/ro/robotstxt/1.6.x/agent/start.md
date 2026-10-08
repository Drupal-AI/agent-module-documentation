# robotstxt — agent start

Serves `/robots.txt` dynamically from config editable in the UI. Requires the
physical `robots.txt` in the docroot to be removed so the dynamic route wins.

- Edit content, config key, the docroot gotcha → [configure/settings.md](configure/settings.md)
- Append lines from code via `hook_robotstxt()` → [hooks/hooks.md](hooks/hooks.md)
- Permission → [permissions/permissions.md](permissions/permissions.md)

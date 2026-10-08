Front Page (project `front`, module machine name `front_page`) redirects visitors from the site's front page to a different path chosen by the user's role, so different roles can land on different home pages. It also lets you rewrite where the site's Home link points.

---

The module works entirely at request time. A request subscriber (`FrontPageSubscriber`, on `KernelEvents::REQUEST`) fires only on the real front page: if the master switch `enabled` is on, it looks at the current user's roles, finds the enabled role override with the lowest `weight`, and issues a `RedirectResponse` to that role's `path` (page cache is killed for that request because the result depends on role). Administrators can be exempted globally with `disable_for_administrators`. All settings live in the `front_page.settings` config object: `enabled`, `disable_for_administrators`, `home_link_path`, and a `roles` map keyed by role id where each entry has `enabled`, `weight`, and `path`. The settings form (`/admin/config/system/front/settings`, permission `administer front page`) builds one collapsible section per role. Separately, an outbound path processor (`FrontPagePathProcessor`) rewrites links to `<front>` (or an empty path) to the configured `home_link_path`, so the theme's Home link and `url('<front>')` can point somewhere other than `/`. The module adds no fields, entities, plugins, or Drush commands — it is a small, config-driven redirect layer. Because it relies on a 301-style redirect rather than rendering a different page in place, the URL in the browser changes to the target path.

---

- Send anonymous visitors to a marketing landing page while logged-in users see a dashboard.
- Redirect authenticated users to `/user` or a personalized dashboard on login-to-home.
- Give editors a role-specific work queue as their front page.
- Point administrators at an admin dashboard, or exempt them from redirects entirely.
- Resolve conflicts between multiple role overrides using per-role weight (lowest wins).
- Replace the default `/node` front page behavior with role-aware routing.
- Rewrite the site's Home link to a specific node via `home_link_path`.
- Make `url('<front>')` and menu Home links resolve to a custom path site-wide.
- Stop returning users to a splash screen by overriding the Home link target.
- Configure a different front page per membership tier (role).
- Turn the whole feature on/off with a single `enabled` switch without losing role config.
- Exempt the administrator role from redirects while keeping them for everyone else.
- Preserve query string and language when redirecting to the role's front page.
- Set a temporary campaign landing page for anonymous users, removed by toggling one role.
- Route premium-subscriber roles to gated content on arrival.
- Provide a role-specific "getting started" page for newly registered users.
- Keep the redirect from running on CLI/cron/installer requests (guarded automatically).
- Skip redirects during maintenance mode (handled by the subscriber).
- Deploy front-page routing as exported config across environments.
- Give anonymous users a login/register page as the effective home page.
- Direct different departments (roles) to their own intranet landing pages.
- Order overlapping role redirects deterministically with weights.
- Combine a custom Home link target with role-based front-page redirects.

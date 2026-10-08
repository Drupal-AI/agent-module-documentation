Environment Indicator adds a colored banner (and optional toolbar tint and favicon change) to a Drupal site so you can tell at a glance whether you are on local, dev, staging, or production.

---

Working across multiple copies of the same site makes it dangerously easy to edit content or run destructive operations on the wrong environment. Environment Indicator solves this by displaying a configurable colored strip at the top of the page whose color and label identify the current environment. The current environment can be pinned in `settings.php` (`$config['environment_indicator.indicator']`) so each deployed copy is unambiguous, or managed as **Environment Switcher** config entities that also render a dropdown of links to your other environments for quick hopping between them. Colors are set as foreground/background pairs, and the module can additionally tint the admin toolbar (via the `environment_indicator_toolbar` submodule) and swap the favicon so the tab is distinguishable too. A settings form controls the toolbar integration, favicon behavior, and a "version identifier" (e.g. a deployment identifier or git SHA) shown alongside the environment name. Access is permission-gated so only trusted users see or administer the indicators. Everything is standard configuration, so environment definitions and colors can be exported and deployed. The optional `environment_indicator_ui` submodule adds a UI for managing per-environment toolbar settings.

---

- Show a red banner on production and a green one on local to prevent mistakes.
- Tint the admin toolbar per environment (with the toolbar submodule).
- Pin the environment name and color in `settings.php` per deployment.
- Display a git SHA or deployment identifier next to the environment name.
- Provide a dropdown of links to switch between dev, stage, and prod.
- Change the browser tab favicon color to match the environment.
- Warn editors visually before they publish on the wrong copy.
- Distinguish multiple production regions with different colors.
- Give QA a clear signal of which build/environment they are testing.
- Set foreground/background color pairs for accessible contrast.
- Restrict who can see the indicator with the "access environment indicator" permission.
- Lock down who can configure environments with the admin permission.
- Export environment definitions as config for deployment pipelines.
- Label a "hotfix" or "sandbox" environment distinctly.
- Surface the current release/version to support debugging.
- Keep the indicator out of anonymous users' view.
- Add environment cues to a decoupled/admin-only backend.
- Use `hook`/preprocess to theme the indicator markup.
- Programmatically read the active environment via the indicator service.
- Provide quick cross-environment navigation for site builders.
- Highlight a maintenance or migration environment with a bold color.
- Configure toolbar colors per environment through the UI submodule.
- Show a fallback deployment identifier when no release is set.
- Help agencies managing many client sites tell environments apart.

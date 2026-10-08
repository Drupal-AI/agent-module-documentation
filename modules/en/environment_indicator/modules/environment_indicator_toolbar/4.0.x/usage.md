Submodule of Environment Indicator that recolors the core admin **toolbar** background and text to match the current environment's colors.

---

Where the parent module shows a banner, this submodule extends the visual cue into Drupal's core Toolbar so the admin bar itself is tinted per environment. It depends on core `toolbar` and on `environment_indicator`, reads the active environment's foreground/background colors, and applies them to the toolbar via a small CSS/JS library plus provided environment marker images. This keeps the environment obvious even when the page banner is scrolled out of view, which is especially useful for editors and administrators who spend most of their time in the admin UI. Toolbar integration is toggled by the parent module's `toolbar_integration` setting. It ships no configuration or permissions of its own — enabling the module and having an active environment is enough. For managing per-environment toolbar settings through a UI, use the companion `environment_indicator_ui` submodule.

---

- Tint the admin toolbar red on production and green on local.
- Keep the environment obvious while working inside the admin UI.
- Match the toolbar color to the active environment's config colors.
- Reinforce the page banner cue with an always-visible toolbar cue.
- Help editors avoid changing content on the wrong environment.
- Give administrators a persistent environment signal across admin pages.
- Distinguish multiple production environments by toolbar color.
- Provide a clear cue for QA testing inside the toolbar.
- Recolor toolbar text for readable contrast on the tinted background.
- Show environment marker icons in the toolbar.
- Complement the favicon recoloring with a toolbar color.
- Signal a sandbox or hotfix environment in the admin bar.
- Toggle toolbar tinting via the parent module's `toolbar_integration` setting.
- Keep the cue visible when the top banner is scrolled away.
- Reduce mistakes for agencies juggling many client environments.
- Make screen recordings/screenshots clearly show the environment.
- Support dev/stage/prod color conventions in the toolbar.

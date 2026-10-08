<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Environment indicator ribbon draws a diagonal corner ribbon, fixed to the bottom-left of the viewport, that names the current environment (dev / stage / prod). It is a thin visual add-on to the `environment_indicator` module: it reuses that module's configured environment name and colours rather than defining its own.

---

The module is deliberately small. Its `.module` file implements a single hook, `hook_page_attachments()`: it checks that the current user holds the `access environment indicator ribbon` permission (returning early otherwise), reads the active environment from `environment_indicator.indicator` config — the `name`, `fg_color` and `bg_color` values that the environment_indicator settings form (route `environment_indicator.settings`) already stores — and pushes those three values into `drupalSettings.environment_indicator_ribbon`, then attaches the `environment_indicator_ribbon/environment_indicator_ribbon` library. The library ships one CSS file and one JS behaviour. The JS behaviour (`Drupal.behaviors.environmentIndicatorRibbon`, using `once` on `body`) appends a single `<div class="environment-indicator-ribbon">` to the page body, sets its `background-color`/`color` inline from the config colours, and puts the environment name inside it. The CSS pins that div `position: fixed` at `left: 55px; bottom: 55px`, rotates it 45 degrees, gives it uppercase letter-spaced text, a drop shadow, `z-index: 1500`, and `pointer-events: none` so it never blocks clicks. There is no configuration UI, config schema, or Drush command of its own — every knob (the environment name, the two colours, and which environments exist) lives in `environment_indicator`, and this module only requires `drupal/environment_indicator: ^4`. Because the ribbon is drawn from `environment_indicator.indicator` config, it shows whichever environment that config resolves to; for the ribbon to be correct per environment, that name/colour must be set per environment (typically via a settings.php override keyed off an environment variable or hostname), not shipped as identical exported config. Visibility is gated only by the ribbon permission — grant it to the roles that should see the marker.

---

- Show a persistent, always-on-screen marker naming the current environment.
- Warn a developer that they are looking at staging, not local.
- Warn an editor that they are on production before they edit.
- Distinguish three near-identical browser tabs (local / stage / prod) at a glance.
- Show the environment outside the admin toolbar, on front-end rendered pages.
- Keep an environment marker visible after the toolbar has scrolled off-screen.
- Reuse environment_indicator's already-configured name and colours for a second visual cue.
- Add a corner ribbon in addition to environment_indicator's toolbar bar.
- Put the environment *name* (not just a colour) on screen for colour-blind team members.
- Mark a client review / UAT environment distinctly.
- Flag a production-like sandbox so it is not mistaken for real production.
- Show the environment during an active deployment window.
- Reduce the chance of running a migration against the wrong site.
- Reduce the chance of deleting content on the wrong environment.
- Reduce the chance of sending test email from a real production list.
- Give a QA team a consistent per-environment badge across many sites.
- Restrict the ribbon to specific roles via the `access environment indicator ribbon` permission.
- Add an environment cue without theming work, using only CSS/JS the module ships.
- Mark a local development site with an unmistakable corner banner.
- Support a multi-environment workflow where a top bar alone is easy to miss.

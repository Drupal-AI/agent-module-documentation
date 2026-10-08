<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush: build the icon font

The module registers a Drush command (`drush.services.yml` →
`CustomBootstrapIconFontCommands`, constructed with the `custom_bootstrap_icon_font.builder` service)
to regenerate the font from the icons stored in config — the recommended path for CI/deploy.

Steps:
1. Install Fantasticon at the project root: `npm install --save-dev fantasticon`.
2. Ensure the source SVG libraries exist under `web/libraries/bootstrap-icons/icons` and/or `web/libraries/fontawesome/icons`.
3. Run the module's Drush build command after `drush cim` so the selected icon config is present.
4. The builder writes `*.woff2` + CSS to `public://custom_bootstrap_icon_font/font/` and bumps the `version` config value.

The builder validates Fantasticon availability with `Process(['npx','--no-install','fantasticon','--version'])`
before building and reports actionable errors if it is missing. Commands are executed as an argv array — no shell string is constructed.

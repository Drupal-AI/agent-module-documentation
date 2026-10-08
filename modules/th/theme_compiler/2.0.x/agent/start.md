<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theme Compiler — agent index

Compiles **theme-provided** source assets (via a `compiler` plugin such as `scss`) into files
served from their own routes. A theme declares targets in `THEME.theme_compiler.yml`; this
module builds routes, compiles on demand, and serves the result. No config UI, no
`configure` route, no permissions, no Drush, no plugins of its own.

- **Declare compiled assets in `THEME.theme_compiler.yml`; how routes/URLs are built and served** →
  [configure/theme-compiler-yml.md](configure/theme-compiler-yml.md)
- **Services, compile triggers, hooks, sandbox storage, the `Compiler` service API** →
  [api/mechanism.md](api/mechanism.md)

Key facts:
- Depends on `compiler` (uses `plugin.manager.compiler`); needs a real compiler plugin
  installed (e.g. `compiler_scss` provides `scss`).
- Dynamic routes are named `theme_compiler.<sha384-of-uri>` → `theme_compiler.controller:serve`;
  built by the route callback `theme_compiler.route_helper:routes`.
- Compiled bytes live under the sandbox `public://theme-compiler-assets/<theme>/<path>`.
- Recompiles on theme install/uninstall, on `THEME.settings` config save/delete, and on
  `OnDemandCompileEvent`.

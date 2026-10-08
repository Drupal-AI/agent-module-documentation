<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theme tools

Plugins in `src/Plugin/tool/Tool/`, all `MCP_CATEGORY = 'theme'` → permission
**`mcp_tools use theme`**. Read ops need read scope; Write ops need write scope, a
non-read-only connection, and a write-kind the connection's policy allows. Each delegates to
`mcp_tools_theme.theme` (`ThemeService`).

| Tool id | Class | Op | Write-kind | Destructive | Inputs | Does |
|---|---|---|---|---|---|---|
| `mcp_theme_get_active` | `GetActiveTheme` | Read | - | - | - | Returns active/default/admin theme plus regions and base themes. |
| `mcp_theme_list` | `ListThemes` | Read | - | - | include_uninstalled? | Lists themes; optionally includes uninstalled ones on disk. |
| `mcp_theme_get_settings` | `GetThemeSettings` | Read | - | - | theme | Returns a theme's settings plus logo/favicon config. |
| `mcp_theme_enable` | `EnableTheme` | Write | config | - | theme | Installs an on-disk theme (must already exist in the codebase). |
| `mcp_theme_set_default` | `SetDefaultTheme` | Write | config | - | theme | Sets `system.theme:default`; theme must be installed. |
| `mcp_theme_set_admin` | `SetAdminTheme` | Write | config | - | theme | Sets `system.theme:admin`; theme must be installed. |
| `mcp_theme_update_settings` | `UpdateThemeSettings` | Write | config | - | theme, settings (map) | Writes keys into `<theme>.settings` config. |
| `mcp_theme_disable` | `DisableTheme` | Write | config | yes | theme | Uninstalls a theme; refuses the default/admin theme or a base theme in use. |

## Notes

- All theme writes are config write-kind + write scope. `EnableTheme` only installs themes already present on disk (`validateThemeExists()` against the theme extension list) — it introduces no new code; it toggles which on-disk theme is active, the same operation as core's `administer themes`.
- Every mutating method re-checks `AccessManager::canWrite()`; `DisableTheme` also refuses to remove the current default, current admin, or a base theme still required by an installed theme.

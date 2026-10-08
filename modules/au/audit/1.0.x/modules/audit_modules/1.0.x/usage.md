Scores the module/theme landscape: unused/duplicate/UI modules, production readiness, and recommendations.

---

Registers the `modules` analyzer (`ModulesAnalyzer`, weight 3). It analyzes installed modules and themes: flagging not-production-ready extensions, duplicate modules, enabled UI/devel modules that should be off in production, missing recommended modules for the project profile, and removable/redundant modules and themes. `shared_hosting` adapts recommendations for constrained hosting; `ignore_ui_modules` suppresses UI-module warnings.

---

- Flag modules that are not production-ready (dev/alpha/unmaintained) still enabled.
- Detect duplicate modules providing overlapping functionality.
- Warn on enabled UI/devel modules that should be disabled in production.
- Recommend missing modules based on the site profile/`user_type`.
- List removable modules and redundant/removable themes.
- Silence UI-module warnings with `ignore_ui_modules`.
- Adapt advice for constrained hosting with `shared_hosting`.
- Read the config-file findings via `file_types: [config]` faceting in the UI.
- Run headless: `drush audit:run modules --format=json`.

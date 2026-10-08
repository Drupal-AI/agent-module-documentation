A Simple OAuth submodule that lets you define OAuth2 scopes as static YAML plugins in code instead of as UI-managed config entities, so scopes live in version control and deploy with your modules.

---

Simple OAuth's default "dynamic" scope provider stores scopes as `oauth2_scope` config entities edited in the admin UI. This submodule adds an alternative **static** scope provider: scopes are declared in a `mymodule.oauth2_scopes.yml` file at the root of any module and discovered as `Oauth2Scope` plugins. Each YAML entry mirrors the dynamic scope shape — a description, whether it is an umbrella (parent-only) scope, the grant types it is enabled for, an optional parent, and a granularity (`permission` or `role`) with the corresponding permission/role. To use it you enable this submodule and set the scope provider to "static" on the Simple OAuth settings page (`/admin/config/people/simple_oauth`, config `simple_oauth.settings.scope_provider: static`). Defined static scopes are browsable read-only at `/admin/config/people/simple_oauth/oauth2_scope/static`. This suits teams that treat access control as code — scopes are reviewed, versioned, and deployed exactly like other configuration, with no per-environment UI editing.

---

- Define OAuth2 scopes in code so they live in version control.
- Deploy scope definitions with a module instead of exporting config entities.
- Keep API access rules reviewable in pull requests.
- Ship a reusable set of scopes as part of a distribution or feature module.
- Avoid drift between environments by declaring scopes statically.
- Map a static scope to a Drupal permission via `granularity: permission`.
- Map a static scope to a Drupal role via `granularity: role`.
- Create umbrella scopes that aggregate child scopes in YAML.
- Enable a scope only for specific grant types (e.g. client_credentials).
- Build a scope hierarchy using the `parent` key.
- Switch a site from dynamic to static scope management without recoding clients.
- Browse all code-defined scopes read-only in the admin UI.
- Provide consistent scopes across many sites running the same codebase.
- Prevent editors from accidentally changing access scopes in the UI.
- Bundle scopes alongside the API module they protect.
- Document intended API access surface directly in the module's YAML.

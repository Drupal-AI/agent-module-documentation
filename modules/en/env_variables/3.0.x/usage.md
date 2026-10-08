Environment Variables provides an admin page that lists environment variables loaded from a configured `.env` file, plus an injectable service that loads that file with the PHP dotenv library.

---

Environment Variables is a small utility module for site builders and developers. It reads a `.env` file from a path you configure (relative to the docroot) using the `vlucas/phpdotenv` library, and displays the resulting environment variables in a simple two-column table (name and value) on an admin page at `/admin/config/env/list`. A settings form at `/admin/config/env/settings` lets you point the module at the `.env` file (for example `/../` for a folder outside the docroot). Two permissions are provided so you can control who reaches the list page and who edits the path setting. The module also registers a service (`env_variables`, class `DotEnvServices`) that other custom modules can inject to load the same `.env` file into the process environment, so values become available through the normal PHP environment (`$_ENV`, `getenv()`).

---

- Install with Composer so the `vlucas/phpdotenv` library is pulled in.
- Enable the module with `drush en env_variables -y`.
- View the environment variables Drupal sees at `/admin/config/env/list`.
- Point the module at a `.env` file outside the docroot with a path like `/../`.
- Point it at a `.env` file in the docroot with a path of `/`.
- Point it at a subfolder such as `/env` (a `docroot/env` directory).
- Confirm at a glance which variables a deployment actually loaded.
- Debug why an expected environment value is missing or empty.
- Verify that a newly added `.env` entry is being read by the site.
- Compare configured values across environments (dev, stage, prod) during setup.
- Give a specific non-admin role read access to the list page via the "View env_variables" permission.
- Keep the list page administrator-only by leaving the default permission assignment.
- Restrict who can change the `.env` path via the "Edit Environment Variables" permission.
- Reach the settings form from the admin Configuration menu ("Environment Settings").
- Load a project `.env` into the running process from a custom module by injecting the `env_variables` service.
- Call `DotEnvServices::loadEnvFile($path)` to make `.env` values available via `getenv()` in your own code.
- Read the module's logged error (channel `env_variables`) when a `.env` file cannot be parsed.
- Onboard a developer by showing them the environment configuration through the UI instead of shell access.
- Sanity-check a Docker/DDEV or hosting environment after a deployment.
- Confirm the docroot path resolution the module uses (`DOCUMENT_ROOT` + configured path).
- Use it as a lightweight alternative to running `printenv` on the server for quick checks.
- Theme or override the output through the `view_env_variables` theme hook and its `view-env-variables.html.twig` template.
- Document, for a team, exactly which `.env` file a site is configured to load.
- Validate that a `.env` file relocation (path change) took effect without redeploying code.
- Provide auditors a read-only, permission-gated view of the loaded environment configuration.

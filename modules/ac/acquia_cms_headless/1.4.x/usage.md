Acquia CMS Headless wires Drupal up as a progressively decoupled or purely headless backend for a Next.js front end, automating the JSON:API, OAuth2 (Simple OAuth), Consumers and OpenAPI setup.

---

Acquia CMS Headless is the decoupled-delivery layer of the Acquia CMS (now "Acquia Drupal Starter Kit") ecosystem. It composes a broad dependency set — JSON:API Extras, JSON:API Menu Items, the Next.js `next`/`next_jsonapi` modules, Consumers, Simple OAuth, RESTUI, decoupled_router and the OpenAPI ReDoc/Swagger UIs — behind a single "Headless" tour step and an API dashboard. From that dashboard an operator can enable a Next.js "starter kit" that programmatically creates an OAuth consumer, generates public/private OAuth keys, provisions a dedicated headless user and role, creates a `next_site` entity plus per-content-type `next_entity_type_config` entities, and surfaces the environment variables a Next.js app needs. A companion submodule, `acquia_cms_headless_ui`, adds "pure headless" mode that disables the Drupal front end and restructures the admin experience around the API. A Drush command set (`acms:headless:new-nextjs`, `acms:headless:regenerate-env`) offers the same provisioning from the CLI, and OpenAPI/ReDoc/Swagger give live JSON:API documentation.

Use it when you are building a Next.js (or other Node) front end against Drupal and want the JSON:API + OAuth + consumer plumbing configured for you rather than assembling those modules by hand.

---

- Turn a Drupal site into a JSON:API backend for a Next.js front end.
- Auto-provision an OAuth2 consumer, keys, user and role for a decoupled app.
- Generate a `next_site` entity and per-content-type Next.js entity type configs.
- Produce the `.env` environment variables (base URL, client ID, preview secret) a Next.js app needs.
- Run progressively decoupled: keep the Drupal front end while serving a Node app in parallel.
- Switch to pure headless mode (via `acquia_cms_headless_ui`) to disable Drupal's front end.
- Manage API consumers, users, tokens and Next.js sites from the API dashboard.
- Rotate a consumer secret from the dashboard or `acms:headless:regenerate-env` Drush command.
- Regenerate a Next.js preview secret for content preview.
- Generate a fresh public/private OAuth key pair into an out-of-docroot directory.
- Browse live JSON:API documentation with ReDoc or Swagger UI.
- Expose JSON:API menu items to the front end for navigation.
- Resolve decoupled routes (path → entity) via decoupled_router.
- Issue JSON:API subrequests for efficient multi-resource fetches.
- Scaffold a new Next.js backend from the CLI with `acms:headless:new-nextjs`.
- Configure the base API URL via JSON:API Extras from the dashboard.
- Preview unpublished/latest-revision content in the Next.js site from the node edit screen.
- Point OAuth key storage at a custom directory via `$settings['oauth_keys_directory']`.
- Reset the starter kit back to its pre-initialization state.
- Standardise headless setup across multiple Acquia CMS sites.
- Provide OpenAPI schema output for JSON:API resources.
- Assign the headless role/permissions to API users and clients.
- Support multisite deployments with per-site key directories.
- Integrate with Acquia Cloud environments for key directory placement.

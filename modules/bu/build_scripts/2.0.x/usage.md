Build scripts lets an authorized operator trigger named build "stages" on an external build daemon from the Drupal UI and watch the streamed log output.

---

Build scripts turns a manual server-side build (originally a Gatsby static-site build from Drupal content) into a one-click action inside Drupal. It ships no build logic of its own: the module is a thin HTTP client that POSTs the chosen stage name and the current interface language to a configurable build daemon (`drupal/build_scripts` pairs with the companion `oikeuttaelaimille/builder` service), and the daemon runs the actual shell script with those two values as arguments. That split keeps build/deploy OS permissions out of the web-server process. Operators see a "Build" toolbar tray listing each configured stage; clicking one POSTs to the start route, stores the returned build id in the session, and redirects to a page that streams the daemon's live log to the browser. Configuration is just a daemon base address and a free-form list of stage names, so the same UI can drive test vs. live environments or any other script the daemon exposes. Two permissions separate who may run builds (`use build_scripts`) from who may change the daemon address and stage list (`administer build_scripts configuration`).

---

- Add a one-click "build" button to Drupal that runs a server-side script (e.g. rebuild and deploy a Gatsby static site) from current content.
- Let editors trigger a static-site rebuild after publishing content without giving them shell access.
- Offer separate "test" and "live" stages so editors can preview a build on a staging environment before deploying to production.
- Rebuild a headless/decoupled front end (Gatsby, Next, Astro, Hugo, etc.) on demand from the Drupal admin toolbar.
- Stream the live build log into the browser so operators can watch progress and spot failures without SSH.
- Kick off a deploy/release script (rsync, container redeploy, cache warm) as a named stage.
- Run per-language builds — the current Drupal interface language is passed to the script as its second argument.
- Trigger a CDN cache purge or revalidation script from the UI after a content change.
- Give a marketing/editorial team a self-service "publish to production" action gated by a single permission.
- Provide a "rebuild search index" or "regenerate exports" button implemented entirely as a daemon-side shell script.
- Keep build/deploy credentials on a separate service account (the daemon) instead of the web server, for least privilege.
- Expose multiple named environments (dev/qa/staging/live) as toolbar links driven by one module.
- Let a scheduled or manual data import be followed by an operator-triggered front-end rebuild.
- Run a smoke-test or lint script as a stage and read its output inline.
- Show build success/failure to operators via streamed stdout/stderr instead of checking server logs.
- Standardize "how we deploy" as a small set of named stages that any authorized operator can run identically.
- Drive image optimization, asset compilation, or media-derivative generation scripts from Drupal.
- Trigger a backup or snapshot script before a risky deployment.
- Integrate a bespoke build pipeline where the shell script does the work and Drupal only provides the button and log view.
- Replace ad-hoc "SSH in and run the build" runbooks with an auditable in-Drupal action (each start is logged).

Disable Aggregation turns off CSS and JS aggregation for logged-in (authenticated) users while leaving the aggregated, cached version intact for anonymous visitors.

---

The module ships a single config override service that rewrites `system.performance` at runtime. When the current user is authenticated, it forces `css.preprocess` and `js.preprocess` to `FALSE`, so Drupal serves individual, unaggregated asset files to that user. Anonymous traffic is unaffected because the override's cacheable metadata varies on the `user.roles:authenticated` cache context, so anonymous users still receive the normal aggregated bundles. There is no admin UI, no settings form, no permissions, no routes, and no config schema — enabling the module is the entire configuration. It is intended as a development/debugging aid for cases where aggregated JavaScript throws errors for editors, letting you read un-minified, individual asset files (and get meaningful stack traces / line numbers) without globally disabling aggregation for the whole site.

---

- Disable JS/CSS aggregation only for logged-in users while keeping it on for anonymous visitors.
- Debug a JavaScript error that only reproduces when aggregation is enabled, by serving individual JS files to editors.
- Read un-minified, per-file CSS and JS in the browser dev tools while logged in.
- Get accurate file names and line numbers in browser console stack traces during theme/module development.
- Work around editor-only JS errors on node edit forms caused by aggregated bundles.
- Keep production performance (aggregation) for the public while giving your team unaggregated assets.
- Avoid toggling the global "Aggregate CSS/JS files" performance settings on and off during debugging.
- Inspect the exact source order in which Drupal attaches individual libraries for authenticated users.
- Diagnose a specific library/dependency that breaks only after minification/concatenation.
- Provide a lightweight, dependency-free alternative to editing `system.performance` by hand.
- Ensure anonymous page cache still serves the fast, aggregated variant while developers see raw assets.
- Reproduce a bug against individual asset URLs to isolate which file is at fault.
- Let content editors report cleaner JS errors that map to real source files.
- Use on a staging or QA environment so testers logged in see unaggregated output.
- Confirm a CSS override lands correctly by viewing the individual stylesheet rather than an aggregate.
- Speed up a debug iteration loop: change a JS file and reload without cache-busting aggregate hashes.
- Temporarily aid front-end troubleshooting without enabling full development mode / `services.yml` tweaks.
- Serve unaggregated assets to authenticated automated tests that assert on individual file requests.
- Support module authors verifying which of their attached libraries actually loads for logged-in users.
- Roll back cleanly by simply uninstalling the module — no leftover configuration to revert.

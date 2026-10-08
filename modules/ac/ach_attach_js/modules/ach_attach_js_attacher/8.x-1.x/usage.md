Adds an admin form that attaches the `ach_attach_js/ach-attach-js` library on the paths you choose, using core's Request Path visibility condition.

---

ACH Attach JS Attacher is the optional companion sub-module of ACH Attach JS. Enabling it exposes a configuration form at `/admin/config/ach_attach_js` (menu: Configuration → Development, under Services) where you specify the paths on which the helper library should load — the same "Request Path" condition UI Drupal uses to control where a block appears, including a negate toggle. The chosen paths are stored in the `ach_attach_js_attacher.settings` config object. On every page build, `hook_page_attachments()` re-creates a core `request_path` condition plugin from that config, evaluates it against the current request (honoring the negate flag via an XOR), and attaches `ach_attach_js/ach-attach-js` when the path matches. The form is protected by the dedicated, restrict-access permission `administer ach_attach_js_attacher`. Out of the box it ships a negated `/admin` + `/admin/*` rule, so the library loads everywhere except admin pages until you refine it. Requires the parent `ach_attach_js` module.

---

- Load the ACH Attach JS library only on the front-end pages where Acquia Lift is active.
- Exclude admin pages from the library (the shipped default negates `/admin` and `/admin/*`).
- Restrict the library to specific landing pages that use Lift personalization slots.
- Configure attachment paths through a familiar block-style Request Path form instead of code.
- Toggle between "attach on these paths" and "attach everywhere except these paths" with the negate option.
- Delegate control of where the library loads to a specific role via `administer ach_attach_js_attacher`.
- Keep the helper library off high-traffic or cache-sensitive paths where it is not needed.
- Avoid editing theme `.info.yml` or writing preprocess code just to attach the library.
- Export the attachment configuration (`ach_attach_js_attacher.settings`) and deploy it across environments.
- Enable Lift behavior reattachment site-wide by leaving the default negated admin-only exclusion in place.
- Scope attachment to a section of the site (e.g. `/campaigns/*`) using a wildcard path.
- Change attachment paths at runtime through the UI without a code deployment.
- Provide a self-service way for site builders (not just developers) to control the library.
- Use core's Request Path condition semantics (leading slash, `<front>`, wildcards) for path matching.
- Pair with the parent module to fix JS behaviors on Acquia Content Hub content across Drupal 9.2–11.

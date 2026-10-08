A Checklist API checklist that lets Drupal teams track the A11Y Project's accessibility best practices, with WCAG references and guidance links, and record who completed each item and when.
---
The module ports the volunteer-maintained A11Y Project accessibility checklist into Drupal. It defines a single checklist (via `hook_checklistapi_checklist_info()`) at `/admin/config/development/a11y-project-checklist`, whose items are built at cache-build time by the `a11yproject_checklist_service` service (`src/Service/A11yProjectChecklist.php`). That service fetches the A11Y Project's public `checklists.json` over the core `http_client` and each task is mapped into a Checklist API item carrying a title, description, WCAG success-criterion reference and a link to more guidance.

It depends on the contrib Checklist API module, which owns the checklist route, its access permission, the save form, and the completion state — including the date, time and username recorded when an item is checked and saved (stored as `checklistapi.progress.a11yproject_checklist` config, exportable to code). This module itself contributes only the item definitions, a form template override (`form--checklistapi-checklist-form`) with a `hook_theme_suggestions_alter()` hook, and an optional Tour. It defines no custom routes, permissions, config objects or config schema of its own, and adds no anonymous or mutating endpoints. Because item data is retrieved from a remote source, working outbound HTTPS is needed to populate the list; fetch failures are logged and messenger-reported, and the checklist renders empty.
---
- Enable the module alongside Checklist API to get a ready-made accessibility checklist.
- Visit `/admin/config/development/a11y-project-checklist` to view and work the checklist.
- Track completion of A11Y Project accessibility tasks over the life of a project.
- Check off individual accessibility tasks as they are verified against your site.
- Record which user completed each task and when, via Checklist API's save flow.
- Review the WCAG success-criterion reference attached to each checklist item.
- Follow the "more information" handbook link on each task for remediation guidance.
- Use the checklist as a pre-launch accessibility audit worksheet.
- Show stakeholders a percent-complete progress bar for accessibility work.
- Grant the Checklist API permission for this checklist to the roles that own a11y work.
- Take the built-in Tour (needs core Tour) to learn the checklist UI.
- Theme the checklist form via the provided template suggestion.
- Combine this checklist with other Checklist API checklists (e.g. SEO) in one admin area.
- Pull the latest upstream A11Y Project tasks by rebuilding caches (`drush cr`).
- Onboard content authors to accessibility by walking the annotated list.
- Export completed-item progress to configuration for repeatable, auditable reviews.
- Verify semantic markup, color-contrast and keyboard-operability items against the site.
- Audit media alternatives (alt text, captions) using the relevant tasks.
- Keep an accessibility remediation backlog visible and checkable by the team.
- Re-review after each release by continuing (or resetting) the saved progress.
- Include the exported progress as evidence in an accessibility compliance report.

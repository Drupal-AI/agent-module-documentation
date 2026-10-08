<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
FormAssembly integrates a Drupal site with the FormAssembly SaaS form platform: forms built and hosted there — typically to feed Salesforce and other CRMs — are mirrored as Drupal entities and rendered natively inside the site instead of iframed.

---

Each remote form becomes a `fa_form` content entity. The site OAuth-authorizes against a FormAssembly instance (client id/secret stored in the `formassembly.api.oauth` config or, optionally, in a Key entity), then the `formassembly.sync` service pulls the form catalog from the REST API and creates, updates or archives `fa_form` entities to match. When a form is displayed — on its own `/formassembly/fa_form/{id}` path or through an entity-reference field targeting `fa_form` — the `formassembly.markup` service fetches that form's HTML on demand and `symfony/dom-crawler` splits it so the scripts and styles load through Drupal's asset system and the form body renders inline, preserving site theming, analytics and accessibility. Per-form pre-fill query parameters can carry literal values or, with the Token module, dynamic Drupal data, and integrators can adjust them via `hook_formassembly_form_params_alter()`. Syncing runs from the settings form's batch or the `formassembly:sync` Drush command (alias `fas`) on cron. The module requires `map_widget` and core `^10 || ^11`; five permissions separate administering, editing, listing, viewing and referencing forms.

---

- Render a FormAssembly form inside a Drupal page instead of an iframe.
- Keep site theming and CSS on a hosted form.
- Preserve analytics and accessibility on an external form.
- Feed form submissions into Salesforce or another CRM.
- Manage remote FormAssembly forms as Drupal entities.
- Authorize the site against a FormAssembly instance over OAuth.
- Store OAuth client credentials in a Key entity rather than plain config.
- Sync the form catalog on cron with `drush formassembly:sync`.
- Sync forms interactively from the settings form.
- Place a form on its own dedicated path.
- Let editors embed a form via an entity-reference field.
- Restrict who can pick forms for embedding with the `reference formassembly` permission.
- Pre-fill form fields with static default values.
- Pre-fill form fields dynamically using Drupal tokens.
- Alter pre-fill parameters programmatically before the request.
- Automatically archive forms deleted upstream in FormAssembly.
- Point the site at developer, app, tfaforms.net or self-hosted FormAssembly endpoints.
- Use an Enterprise admin index to list every form in the instance.
- Inspect a form's raw HTML on the entity edit page.
- Standardize an organization on an approved external form platform.
- Show a thank-you message or redirect after submission.
- Keep form logic and validation outside Drupal.
- Give editors a simple form picker backed by synced entities.
- Support multi-page FormAssembly forms end to end.

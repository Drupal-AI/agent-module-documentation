<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Node Delete Redirect lets an administrator configure, per content type, the internal Drupal path a user is sent to after they delete a node, replacing Drupal's default "return to the front page" behavior.

---

The module adds one settings form at `admin/config/content/node-delete-settings` (route `node_delete_redirect.admin_settings_form`, permission `administer content types`), backed by the config object `node_delete_redirect.admin_settings_form`. The form has a master on/off radio (`ndr_check`), a per-content-type fieldset where each bundle gets an "enabled" checkbox and a "Redirect URL" textfield, and an alpha "language support" checkbox (`ndr_lang`). Redirect paths are validated as you save by `NodeDeleteRedirectElemPathValidate` (service `node_delete_redirect.elem_path_validate`), which requires a non-empty value beginning with a leading slash, rejects `<front>`-style tokens, and confirms the path resolves through core's path validator (`PathValidatorInterface::getUrlIfValid`) — so only valid internal paths the site can reach are stored. At delete time, `hook_form_alter` in `node_delete_redirect.module` looks at each node delete confirm form (`node_{type}_delete_form`); if redirect is globally enabled and that bundle is enabled, it stashes the configured path on the form and appends a custom submit handler, `node_delete_redirect_form_submit`. That handler reads the stored path, optionally prepends the current language prefix when `ndr_lang` is on and the current language differs from the default, ensures a leading `/`, and calls `$form_state->setRedirectUrl(Url::fromUserInput($redirect_to))` — `fromUserInput` accepts internal paths only, so the post-delete redirect always stays on-site. Settings are removed on uninstall via `hook_uninstall`. The module's only dependency is core `node`; it ships a config schema but no permissions, Drush commands, entities, or plugin types of its own.

---

- Send editors to the news listing after they delete a news article, instead of the front page.
- Configure a different post-delete landing page for each content type on the site.
- Return content authors to a bundle-specific dashboard or overview after a delete.
- Point post-delete redirects at a View page (e.g. `/admin/content` or a custom listing route).
- Redirect to a "content deleted" confirmation or thank-you page you built as a node or route.
- Keep editors inside a workflow area rather than bouncing them to the homepage on every delete.
- Set a per-type redirect only for the bundles that need it, leaving the rest at Drupal's default.
- Toggle all redirect behavior off site-wide with a single radio without losing per-type paths.
- Enable the redirect for just one content type while you pilot the behavior before wider rollout.
- Prefix the redirect with the current language code on a multilingual site (alpha language support).
- Land multilingual editors on the language-appropriate version of the target listing after a delete.
- Point deletions of an event bundle back to the events calendar or events overview page.
- Send product-node deletions back to the product catalog listing.
- Route deletions of a landing-page bundle to the site-structure or menu admin.
- Guide new editors by always returning them to a known safe listing after destructive actions.
- Standardize the post-delete experience across a team so everyone lands in the same place.
- Restrict who can change redirect behavior by gating the settings form behind `administer content types`.
- Validate redirect paths at save time so only reachable internal paths are ever stored.
- Remove all module configuration cleanly on uninstall without leaving orphaned config.
- Replace a custom `hook_form_alter` snippet in a site module with a configurable, per-type UI.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
The Siteimprove.ai Plugin connects Drupal to the Siteimprove.ai platform, surfacing content, accessibility, SEO and analytics insights inside the editing workflow and letting editors re-check a page after fixes without leaving Drupal.

---

Siteimprove is a SaaS platform that audits sites for content quality, accessibility, SEO and analytics. This module bridges Drupal to it: on configured entity routes (nodes, taxonomy terms, groups — both canonical and edit-form views) it injects the Siteimprove overlay/JS and requests a short-lived auth token from Siteimprove's token endpoint so the overlay can talk to the platform. It also provides a "prepublish" content check and a "recheck" action so editors can re-scan a page immediately after editing.

Access is controlled by three permissions — `administer siteimprove` (the settings form at `/admin/config/system/siteimprove`), `use siteimprove` (see and use the overlay), and `use siteimprove prepublish` (the prepublish check). The token is fetched server-side over HTTPS from `https://my2.siteimprove.com/auth/token` (certificate verification is left at Guzzle's secure default). Which entity routes get the overlay is defined by service parameters (`siteimprove.recheck_enabled_routes`, `prepublish_check_enabled_routes`, `other_enabled_routes`), and a Frontend Domain plugin system handles sites whose public domain differs from the editing domain (including a Domain Access-aware option).

For content teams already using Siteimprove, it puts the platform's findings where the work happens and removes the context switch. Setup is: install the dependency (`js_cookie`), enter/generate the Siteimprove token on the settings form, grant the `use siteimprove` permissions to editor roles, and pick the frontend-domain plugin that matches your setup.

---

- Show Siteimprove insights inside Drupal editing.
- Re-check a page in Siteimprove after editing.
- Run a prepublish content check on a node.
- Add the Siteimprove overlay to node pages.
- Configure the Siteimprove auth token.
- Grant editors access to the Siteimprove overlay.
- Restrict Siteimprove config to admins.
- Enable Siteimprove on taxonomy term pages.
- Enable Siteimprove on group pages.
- Handle a separate frontend domain for Siteimprove.
- Support Domain Access with Siteimprove.
- Choose which routes load the Siteimprove overlay.
- Surface accessibility issues to editors.
- Surface SEO issues during editing.
- Regenerate the Siteimprove token.
- Give the prepublish check to specific roles.
- Integrate analytics insights into the workflow.
- Recheck content quality after a fix.
- Add Siteimprove to node edit forms.
- Connect Drupal to the Siteimprove platform.
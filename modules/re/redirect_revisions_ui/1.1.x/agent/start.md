<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Redirect Revision UI (redirect_revisions_ui) — agent index

**Exposes the version-history / view / revert / delete UI for Redirect entities behind dedicated permissions.**

- **Version:** 1.1.x
- **Core:** ^10 || ^11 (dep: redirect)
- **Permissions:** `view any redirect history`, `view any redirect revisions`, `revert any redirect revisions`, `delete any redirect revisions`
- **Mechanism:** `RedirectRevisionsUiEventSubscriber` (RouteSubscriber) sets `_admin_route: TRUE` on `entity.redirect.version_history` / `.revision` / `.revision_revert_form` / `.revision_delete_form`
- **No routes of its own** — it enhances core-provided redirect revision routes.

**Security:** each revision route is gated by a dedicated permission (plus core redirect access); view/revert/delete can be granted independently to trusted roles. The subscriber only flips `_admin_route` on existing routes — it does not create endpoints or relax access. No anonymous or mutating public endpoints. No findings.

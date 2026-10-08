<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Frontend Publishing provides an API for an integrated front-end publishing workflow, letting editors publish/manage content from the front end, with a scheduler submodule.

---

Editing and publishing from the rendered front end (in-context), rather than the admin, is a modern editorial experience. Frontend Publishing provides the API for that workflow, with a `frontendpublishing_scheduler` submodule. Because it enables content management from the front end, the security consideration is that front-end publishing actions must enforce the same access as the admin: publishing, editing and scheduling from the front end are content-mutating operations, so they must be gated by the user's actual edit/publish permissions — a front-end publishing UI must not become a way to perform actions the user could not do in the admin. Confirm the workflow respects content access and permissions, and that the front-end actions are properly access-checked (not just hidden). For an in-context editorial experience it is the framework; verify the access enforcement.

---

- Publish from the front end.
- Manage content in-context.
- Provide a front-end editorial API.
- Schedule front-end publishing.
- Edit on the rendered page.
- Enforce edit/publish permissions.
- Access-check front-end actions.
- Confirm access matches the admin.
- Avoid unintended front-end actions.
- Build an in-context workflow.
- Publish in-context.
- Verify permission gating.
- Enable when needed.
- Keep disabled otherwise.
- Restrict administration.
- Confirm on your site.
- Test before production.
- Review configuration.
- Pair with related modules.
- Verify theme fit.
- Match your use case.
- Confirm compatibility.
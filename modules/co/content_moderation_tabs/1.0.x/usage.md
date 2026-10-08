<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content Moderation Tabs adds per-state tabs to the Content admin page for the Content Moderation workflow.

---

Content Moderation Tabs lets you add **local-task tabs to the Content administration page**
(`/admin/content`), one per Content Moderation workflow **state** — for example an "In progress" tab for
drafts and a "Needs signoff" tab for content in review — sitting alongside the core Overview and
Moderated content tabs. Each tab opens a **View** (page display) you choose, giving editors a dedicated,
filtered listing per moderation state instead of one combined list.

You configure it directly on each workflow state's edit form (Configuration → Workflow → Workflows):
tick *Enable tab*, set the tab title, weight, and the View the tab should open. It is a purely editorial
UX feature — moderation access still follows core Content Moderation's own permissions and the module
adds no access control of its own. It depends on core Content Moderation.

---

- Add a per-state tab to `/admin/content`.
- Point each tab at a chosen View page display.
- Configure tabs on the workflow-state edit form.
- Set tab title, weight, and enabled per state.
- Group content by moderation state for editors.
- Complement core's single "Moderated content" list.
- Depend on core Content Moderation.
- Follow core Content Moderation permissions.
- Add no access control of its own.
- Serve editorial workflow UX.

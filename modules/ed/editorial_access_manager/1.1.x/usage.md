<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Editorial access manager assigns individual users the right to edit or translate a specific content entity, per language — per-item editorial delegation that also covers translations independently of their source.

---

Drupal's editing permissions are per bundle: a role may edit all articles or none. Editorial reality is often per item — this page belongs to the finance team, that one to a named author, this translation is assigned to a particular translator. Editorial access manager takes the assignment approach. You enable participating entity types at `/admin/config/content/editorial-access-manager`, switch the feature on per bundle (a third-party setting on the node type, vocabulary, media type, etc.), and grant two kinds of permission: `assign …` permissions for the people who hand out work, and `edit assigned …` permissions for the editors who receive it — the latter need no core create/edit/translate permission. Assigners then get a "Manage editorial access" tab on each entity and, per language, an assignment form at `/editorial-access-manager/editorial-assignment/{entity_type_id}/{entity_id}/{langcode}` (the langcode in the path is what lets a translation be assigned separately from the original). Editors get an "Assigned content" page listing what is theirs, with edit/translate links. Enforcement runs through core's node access grants for nodes (realm `editorial_access_manager_assignees`) and through `hook_entity_access` plus a replacement content-translation handler for other entity types; assignments and inherited referenced-entity access are stored in the `editorial_access` and `editorial_access_references` tables. A reassign form at `/admin/content/reassign` moves one user's whole workload to another when someone leaves. Dependencies are core `node` and `content_translation`, with a wide `^8 || ^9 || ^10 || ^11` range. As with any access module, verify behaviour in Views, JSON:API and search, not only on the entity form.

---

- Assign a specific page to a named editor.
- Assign a translation to a particular translator, independent of the source language.
- Delegate editing per item rather than per bundle.
- Let editors work without granting them site-wide content-edit permissions.
- Give a department control of only its own pages.
- Reassign all of a departing editor's content to a successor in one step.
- Track who is responsible for a given page.
- Support a per-language translation workflow with explicit assignments.
- Restrict editing of a bundle to assigned users.
- Enable editorial access on nodes, taxonomy terms, media, or comments.
- Grant assignees edit access to entities referenced by their assigned content.
- Provide a "Manage editorial access" tab on selected content types.
- Show each editor an "Assigned content" dashboard.
- Avoid a role-per-team explosion of permissions.
- Avoid Group's full membership model for simple delegation.
- Assign review responsibility for a specific document.
- Delegate a microsite or landing page to its owner.
- Onboard a contractor with access to just their pages.
- Audit which users may edit a particular entity in a particular language.
- Support a federated editorial structure across teams.
- Hand a translator only the languages they are assigned.
- Enable editorial delegation on a custom contrib content entity type.

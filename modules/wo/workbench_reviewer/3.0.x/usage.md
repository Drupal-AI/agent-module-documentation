<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Workbench Reviewer lets content editors assign an individual piece of content to a named user for review, on top of Drupal core's Content Moderation.

---

Install it with `composer require drupal/workbench_reviewer` and enable it (it depends on core **Content Moderation**); there is **no settings page and no configuration** to fill in. The module adds a **Reviewer** field only to content types that are attached to a moderation workflow, so first put your content types under a workflow at `/admin/config/workflow/workflows`. When you edit a node, a **Workflow** section appears in the right-hand advanced sidebar containing the **Reviewer** autocomplete (pick any user) and the **Revision log message** box; assigning a reviewer is optional and is saved with the node revision. Reviewers find their work at **Content → Assigned to me** (`/admin/content/assigned-to-me`), a View that lists unpublished content assigned to the current user — reaching that page requires the core **`view all revisions`** permission, so grant it to the roles that should review. The assigned reviewer is also available as a token, `[node:workbench_reviewer]` (and chained user tokens such as `[node:workbench_reviewer:mail]`), on any moderated entity type — handy for notification emails. Note this is a **3.0.0-beta2** release: verify how assignments behave across your state transitions and when an assigned user is blocked or deleted before relying on it in production.

---

- Install with Composer and enable alongside Content Moderation.
- Put a content type under a moderation workflow so the Reviewer field appears.
- Assign a node to a specific person to review.
- Add a revision log note in the same Workflow sidebar section.
- Reassign content to a different reviewer.
- See the content that is waiting for me to review.
- Open the "Assigned to me" tab under the Content admin page.
- Grant reviewers the `view all revisions` permission so they can see their queue.
- Restrict the review queue to a role by editing the shipped View.
- Turn a nobody-owns-it "in review" state into "waiting for you".
- Find content still assigned to a colleague who has left.
- Send a notification email using the `[node:workbench_reviewer]` token.
- Pull the reviewer's email with a chained token like `[node:workbench_reviewer:mail]`.
- Build a custom View filtered by reviewer using the `workbench_reviewer_node_reviewer` argument.
- Show the assigned reviewer on the node display by enabling the field on Manage display.
- Read or set the reviewer from code via the `workbench_reviewer` entity-reference field.
- Track who was assigned per revision (the field is revisionable).
- Report on outstanding review workload across content.
- Evaluate the beta before depending on it in an editorial workflow.
- Verify assignment behaviour when content transitions state or the assignee is blocked/deleted.

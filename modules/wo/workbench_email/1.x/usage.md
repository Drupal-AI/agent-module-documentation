<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Workbench Email sends templated emails when content-moderation transitions occur — notify a reviewer when something moves to Needs Review, notify an author when their content is Published or sent back to Draft.

---

An editorial workflow is only useful if the right people know when the ball is in their court. A piece moving to "Needs Review" should ping the reviewers; a rejection should tell the author. Without notifications, a moderation state is just a label nobody is watching. Workbench Email attaches email templates to workflow transitions, so each state change can send a message to a configured set of recipients — roles, the author, specific users.

It depends on core **Content Moderation** and **Filter** (templates are filtered text), and it defines an `administer workbench_email templates` permission for managing the templates. The templates support tokens, so a notification can name the content, its new state and a link. The thing to get right is the recipient configuration per transition — an over-broad recipient list turns a useful notification into inbox noise, and a missing one leaves a workflow silent.

For any site running editorial moderation, it is what makes the workflow actually move. Configure a template per meaningful transition and target the recipients precisely.

---

- Email reviewers on a moderation transition.
- Notify an author when content is published.
- Notify an author when content is rejected.
- Alert reviewers of Needs Review items.
- Attach email templates to transitions.
- Send workflow notifications.
- Template a moderation email.
- Target notifications by role.
- Notify the content author.
- Notify specific users.
- Use tokens in the email.
- Link to the content in the email.
- Administer email templates.
- Keep an editorial workflow moving.
- Avoid silent moderation states.
- Configure recipients per transition.
- Prevent notification noise.
- Support a review workflow.
- Send an approval request email.
- Announce a state change.
- Drive editorial handoffs.
- Notify on send-back to draft.
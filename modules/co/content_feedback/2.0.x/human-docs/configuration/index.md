# Configuration

Content Feedback needs a little setup before the form shows up: you decide which
content types carry it, who can submit it, and who can review the results.

## Open the settings form

Go to the Content Feedback settings form (the `content_feedback.settings` route).
The quickest way to reach it is the **Configure** link next to Content Feedback on
the **Extend** page (`/admin/modules`). You'll need the permission to administer
the module's settings (an administrator has this by default).

## Choose the content types

On the settings form, select the content types that should display the feedback
form. Feedback is only offered on the types you enable here, so you can, for
example, gather feedback on your documentation pages but not on news posts. Save
the form to apply your choice.

## Set the permissions

Content Feedback provides its own permissions. Grant them at **People →
Permissions** (`/admin/people/permissions`):

- Give the **feedback form access** permission to the roles whose users should be
  able to see and submit the form. Only users with this permission get the form.
- Give the permission that controls **viewing collected feedback** to the roles
  that should review submissions in the admin list.

Decide these deliberately — the view permission is what keeps the collected
feedback (which stores each submitter's name, email, and IP address) restricted to
the right people.

## Review and resolve feedback

All submissions are collected into an administrative feedback list, **grouped by
status**. From there an admin can read each item and update its status to
**Resolved** once it has been dealt with, so the list doubles as a simple
work queue for content quality issues.

## How submission feels to the visitor

The feedback form is submitted via **AJAX**, so after a user sends feedback they
stay on the same page and can keep browsing — there's no full page reload or
redirect.

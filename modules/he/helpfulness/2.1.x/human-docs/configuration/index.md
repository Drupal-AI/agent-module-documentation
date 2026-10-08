# Configuration

Getting Helpfulness working is three steps: adjust the block's settings, place the
block on your pages, and decide who may review the feedback that comes in.

## Open the settings form

1. Log in as an administrator.
2. Go to the Helpfulness settings form (route `helpfulness.admin_form`), reachable
   from the module's entry under **Configuration**.

## Settings

The configuration page lets you tailor how the feedback block behaves:

- **Text above the comments area** — the wording shown above the comment box (for
  example an invitation to explain the rating). Customize it to match your site's
  voice.
- **Text below the comments area** — the wording shown beneath the comment box (for
  example a thank‑you note or a privacy reminder).
- **Email notification** — enable this to have the site email a notification
  whenever new feedback is submitted, so your team hears about responses without
  having to poll the report.

Adjust these to suit your content, then save.

## Place the feedback block

The feedback widget is delivered as a block:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** in the region where you want the "Was this helpful?"
   question to appear and choose the **Helpfulness** block.
3. Use the block's **Visibility** settings to limit it to the pages or content types
   where you want to gather feedback.
4. Save the block.

## Who can see the feedback

Helpfulness provides its own permission governing access to the collected feedback
report. Go to **People → Permissions** (`/admin/people/permissions`), grant the
Helpfulness permission to the roles that should be able to review submissions, and
save. Keep this limited to trusted staff, since the report can include details such
as user names, page URLs, and browser information.

## Reviewing submissions

Submitted feedback is gathered into a report where you can see, per submission, the
name of the user, the helpfulness rating, the message, the base URL, the system
path, the alias, the date and time, and browser information.

## A note on user input and spam

The comment field accepts free text. Because that is user‑supplied input, ensure it
is escaped when displayed in the report (to avoid stored cross‑site scripting), and
if the block is visible to anonymous visitors, add spam protection — the
[CAPTCHA](https://www.drupal.org/project/captcha) module integrates well for this
purpose.

# Configuration

There are three things to set up: place the feedback block, tune the wording and behavior
on the settings form, and check the permissions. Results are then reviewed on the
dashboards.

## Place the feedback block

Go to **Structure → Block layout** (`/admin/structure/block`) and place the **Admin
Feedback Block**. The block only renders on node pages (canonical node routes), and it is
shown to anyone with the **give feedback** permission — anonymous and authenticated by
default.

## The settings form

Open **Configuration → System → Admin Feedback settings** (`/admin/feedback/settings`),
behind the **Administer admin feedback** permission. All values are saved in the
`admin_feedback.settings` config object, which is translatable.

**Wording**

- **Initial question** — the heading in the block (default "Was this helpful?").
- **Yes button / No button** — the button labels (default "Yes" / "No").
- **Yes response / No response** — the thank-you text shown after each answer.
- **Feedback prompt** — the text inviting a follow-up comment.
- **Submit text** — the comment submit-button label (default "Send feedback").
- **Final response** — shown after a comment is saved (default "Thank you!").

**Follow-up comment behavior**

- **Show prompt after Yes / after No** — two independent toggles (both on by default) for
  whether to invite a comment after a Yes vote and/or a No vote.
- **Enable predefined answers** — when on, the comment step shows a radio list of preset
  answers instead of a free-text box (off by default).
- **Predefined answers** — the preset options used when the above is on (ships with four
  sample answers).
- **Custom text response on No** — optional rich text shown to a visitor who votes No.
- **Allow cancel** — an optional "undo" window after a submission, with a timeout in
  seconds.

**Limits and export**

- **Flood limit / window** — how many votes one IP address may cast per time window
  (default 20 votes per 3600 seconds). This is the main anti-abuse control.
- **Export batch size** — how many rows to process per batch during CSV export
  (default 5000). Raise or lower it for very large feedback tables.

You can also set values with Drush, for example:

```bash
ddev drush config:set admin_feedback.settings initial_question 'Was this page useful?' -y
ddev drush config:set admin_feedback.settings feedback_flood.limit 10 -y
```

## Reviewing results (dashboards)

The module ships two Views-based dashboards (both forced to the admin theme):

- **Feedback Dashboard** — `/admin/content/feedback` (also under **Content → Feedback
  Dashboard**), gated by **View admin feedback dashboard**. Lists all feedback across the
  site, and lets you mark entries "inspected", delete single entries, or purge all feedback
  for a node.
- **Per-node detail** — `/node/{nid}/feedback`, gated by **View admin feedback detail
  view**, showing the score and comments for one page.

Everything can be exported to CSV in batches (gated by **Export feedback data**).

## Permissions

None of these are marked "restrict access", but the admin ones expose and can delete all
collected feedback, so grant them only to trusted roles.

| Permission | Grants |
|------------|--------|
| **give feedback** | See and use the widget, vote, and comment. **Granted to anonymous and authenticated on install.** |
| **administer admin feedback** | The settings form. |
| **view admin feedback dashboard** | The site-wide Feedback Dashboard. |
| **view admin feedback detail view** | The per-node detail view and the mark-inspected actions. |
| **export feedback data** | The batch export and CSV download. |
| **delete feedback** | Delete a single feedback entry. |
| **delete all node feedback** | Delete all feedback for one node. |

Because **give feedback** is public by design, spam is mitigated in code — a per-page
signed vote token, strict Yes/No + real-node validation, per-IP flood control, and a signed
one-comment-per-vote token — not by the permission.

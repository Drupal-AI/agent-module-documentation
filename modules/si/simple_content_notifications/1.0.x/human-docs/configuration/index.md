# Configuration

Simple Content Notifications has two independent settings forms — one for
notifications about content changes, one for notifications about content that needs
review. Both are reachable only by users with the **Administer Content
Notifications** permission, so grant that first (**People → Permissions**).

## Content change notifications

Go to **Configuration → Content authoring → Content Notifications settings**, or
navigate directly to
`/admin/config/content/simple_content_notifications/settings`.

Here you decide:

- **Recipient email address(es)** — one or more addresses that should be emailed
  when content changes. Because these emails can include content details, choose
  recipients who are allowed to see that content.
- **Which content types generate a notification** — tick the node types you want to
  watch. Leave noisy or high‑volume types unticked so recipients are not trained to
  ignore the mail.

With this saved, adding, editing, or deleting a piece of a watched content type
sends a notification to the configured addresses.

## Content review notifications

Go to **Configuration → Content authoring → Needing review settings**, or navigate
directly to
`/admin/config/content/simple_content_notifications/needing_review_settings`.

This half decides that a piece of content "needs review" once a set amount of time
has passed since it was last reviewed. Configure:

- **The "last reviewed" field machine name** — the machine name of the date field
  on your content that stores when each item was last reviewed. Any content type
  that has this field is included in the review check. You must create this field
  yourself; the module only reads it.
- **How often the review notice is sent** — the frequency of the digest email.
  Rather than one message per overdue item, the module gathers everything that is
  due into a single notification and sends it on this schedule.

## The on‑site review listing

Regardless of email, users with the core **Administer content** permission can see
every node currently needing review at **Content → Needing review**
(`/admin/content/needing_review`). Treat this page — not the email — as the
reliable record of what is waiting, since a message can be missed or archived.

## Save

Click **Save configuration** on each form. Change notifications take effect on the
next content edit; review notifications are sent on the schedule you set.

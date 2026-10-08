# Configuration

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Navigate to `/admin/config/taxonomy_scheduler`.

## Choose the vocabularies and field

On the settings form you:

- **Choose the vocabularies** where the *"Publish on"* scheduling field should be
  added. The field is added to each vocabulary you select.
- Optionally set the **field name** to use.
- Optionally mark the field **required**, if every term in those vocabularies must
  carry a scheduled publish date.

Then click **Save** to write the settings and add the field to the chosen
vocabularies.

## Make sure cron is running

This is the essential second step: publishing happens on **cron**, not on user
action. A cron run scans the scheduled terms, queues those whose *"Publish on"* time
has passed, and a queue worker flips them from **Unpublished** to **Published** and
clears the relevant caches.

Make sure a regular cron is set up on your site so terms actually get published at
their scheduled time. If cron never runs, scheduled terms will stay unpublished no
matter what date you set.

## Using it day to day

Once the field is on a vocabulary, editors set a *"Publish on"* date and time when
adding or editing a term, and leave the term unpublished. When that moment arrives and
cron next runs, the term is published automatically — handy for seasonal or campaign
tags that should stay hidden until launch.

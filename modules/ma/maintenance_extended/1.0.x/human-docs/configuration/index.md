# Configuration

This module has no separate settings page. It adds its two fields directly to
Drupal core's maintenance-mode form, so you configure everything in one place.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Development → Maintenance mode**
   (`/admin/config/development/maintenance`).

Alongside core's usual **Put site into maintenance mode** checkbox, you'll find
the two fields this module adds.

## Title

Core hard-codes the maintenance page's title. This field lets you set your own —
for example "We'll be back shortly" or "Scheduled maintenance in progress." Leave
it as you like; whatever you enter becomes the heading visitors see on the
offline page.

## Message (rich text)

Core's maintenance message is a plain textarea. This module upgrades it to a
**formatted text field**, so you can compose the message with a rich-text editor
(such as CKEditor) — adding emphasis, links, or basic formatting. Choose a text
format from the selector below the field just as you would on any other rich-text
field.

## Save

Click **Save configuration**. Enable maintenance mode (the checkbox on the same
form) to see your custom title and formatted message on the maintenance page.

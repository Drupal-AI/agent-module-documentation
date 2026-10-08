# Configuration

Notifybar has no standalone settings page — you configure it entirely through its
**block**. Add the block once, fill in its fields, and the bar appears.

## Add the Notifybar block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Click **Place block** and choose **Notifybar**. You can place it in a specific
   region if you want it to render there, or rely on the block's own
   "Show notifybar" option (below) to pin it to the top of the page.

## The block's fields

In the Notifybar block's configuration you set:

- **Message** — the announcement text shown in the bar.
- **Button text** — the label for an optional call‑to‑action button. Leave it
  empty if you don't want a button.
- **Button link** — where the button sends visitors who click it.
- **Background colour** — the fill colour of the bar.
- **Text colour** — the colour of the message text, so you can keep it readable
  against your chosen background.
- **Show notifybar** — a dropdown controlling where the bar appears (for example
  at the top). Selecting the **none** option hides the notification bar from the
  top without removing the block.

## Save and clear caches

Save the block. Notifybar's message is cached, so after adding or editing it you
should **clear Drupal's caches** (`drush cr`, or *Configuration → Development →
Performance → Clear all caches*) before checking the site — otherwise you may
still see the old message.

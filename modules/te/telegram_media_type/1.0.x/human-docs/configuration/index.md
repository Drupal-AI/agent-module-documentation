# Configuration

Telegram Media Type has no settings form of its own. Instead you configure it by
creating a **media type** that uses the Telegram media source, then adjusting its
display and permissions. Follow these steps once after enabling the module.

## 1. Create the Telegram media type

1. Log in as an administrator and go to **Structure → Media types → Add media
   type** (`/admin/structure/media/add`).
2. Set **Name** to `Telegram`.
3. Set **Description** to something like `Telegram posts.`
4. Set **Media source** to **Telegram**.
5. Click **Save**.

## 2. Set the display formatter

Go to the new type's **Manage display** and make sure the Telegram source field is
set to use the **Telegram embed** formatter if it is not already. This is what
renders the pasted URL as an actual Telegram embed rather than plain text.

## 3. (Optional) Adjust the entry form

If you want to change which fields editors see or how the form is laid out, visit
the type's form display at
`/admin/structure/media/manage/telegram/form-display`.

## 4. Grant permissions

Go to **People → Permissions** (`/admin/people/permissions`) and give the
appropriate roles the permissions to create and edit Telegram media, so your
editors can actually add items.

## How editors use it afterwards

With the type in place, editors create Telegram media at `/media/add/telegram`, or
through Drupal core's **Media Library** when adding media to a field. They simply
paste the Telegram URL and the module generates the embed code.

## Privacy note

Each embed loads external content from Telegram via an iframe, which sets
Telegram's third‑party cookies in the visitor's browser. If you operate under
consent laws (for example in the EU), you cannot load such non‑essential cookies
before the visitor consents — pair this module with a cookie‑consent solution
where that applies.

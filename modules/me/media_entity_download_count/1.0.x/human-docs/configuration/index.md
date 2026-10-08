# Configuration

Counting is not automatic — you have to give the module a field to write into and
switch it on for each media type you care about. There are three pieces: a count
field, the per‑type toggle, and a small global settings form. This page walks
through all three plus the permissions.

## 1. Add a count field to the media type

The counter needs somewhere to store its number.

1. Go to **Structure → Media types** (`/admin/structure/media`) and choose the
   type you want to track (for example **Document**), then open **Manage
   fields**.
2. Add a field to hold the count. A **Number (integer)** field is the natural
   choice, but any non‑base `integer`, plain text (`string`), or long text
   (`string_long`) field also qualifies.
3. Save the field.

If a media type has no eligible field, the counting settings on that type show a
"no text field" notice — that is the reminder that this step is missing.

## 2. Enable counting on the media type

1. Still under **Structure → Media types**, open the type's **Edit** tab.
2. Find the **Media Download Count configuration** section.
3. Tick **Activate media download counter**.
4. In **Count field**, select the field you added in step 1.
5. Save the media type.

These choices are stored on the media type itself, so different types can count
into different fields (or not count at all).

## 3. Global settings — excluded extensions

1. Go to **Configuration → Media → Media Entity Download Count Settings**
   (`/admin/config/media/download/count/form/settings`). Reaching this form
   requires the **`administer media entity download count`** permission.
2. In **Excluded file extensions**, enter a space‑separated list of extensions
   that should never be counted — useful for skipping things like private image
   derivatives.
3. Save.

## 4. Permissions

Under **People → Permissions** (`/admin/people/permissions`) the module exposes
two permissions:

- **`administer media entity download count`** — lets a role reach the global
  settings form above. Grant it only to administrators.
- **`skip media entity download counts`** — users with this permission are **not
  counted** when they download. Grant it to admins and editors so their own
  previews and testing don't inflate the totals.

## How a download is counted

When Drupal grants a file download, the module finds the media entity that
references the file, reads its configured count field, increments it, and re‑saves
the media entity. It also writes a log entry recording the filename, the
downloading user's ID, and their IP address (visible under **Reports → Recent log
messages**). Downloads triggered while *adding* media are ignored, as are users
who hold the skip permission.

Two things to keep in mind, repeated here because they affect how you read the
numbers: every counted download re‑saves the media entity (so a revisionable type
gains a revision per download), and the increment is a non‑atomic
read‑modify‑write, so counts can drift slightly under heavy simultaneous load.

## Resetting a count

Because the total lives in an ordinary field on the media entity, you can reset or
correct it at any time by editing the media item and changing the value in the
count field.

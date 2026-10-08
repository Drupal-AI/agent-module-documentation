# Media Expire — manual setup guide

**Media Expire** (`media_expire`) automatically unpublishes media entities once a
date you've set on them passes, and can display a **fallback** media item in
place of anything that has expired. It's the media-world equivalent of scheduled
unpublishing: set a "valid until" date on a banner, a licensed image, or a
time-limited video, and the module takes it offline on schedule with no editor
action required.

You turn expiry on **per media type**. On a media type's edit form the module
adds an *Expire configuration* section where you activate expiry, choose which
datetime field on that bundle acts as the trigger, and optionally pick a fallback
media item of the same type. Those choices are stored on the media type itself
(as third-party settings), so different types can expire independently — images,
videos, and documents each on their own field.

The actual work happens on **cron**: on every run (or on demand via a Drush
command) the module finds published media of an expiring type whose date is in
the past, unpublishes them, and clears the date so they aren't reprocessed. When
someone then views an expired item, its output is swapped for the fallback
media's output (or nothing, if you didn't set a fallback). A companion access
rule and route handler make the fallback viewable to users with *view media*, and
a GraphQL data producer exposes the fallback for decoupled front ends. There is
no dedicated settings page and no permission of its own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enable expiry on a media type, pick
   the date field and fallback, and run the expiry sweep.

## Where it lives in the admin menu

There is no standalone settings page. You configure expiry on each media type's
edit form at **Structure → Media types → (your type) → Edit**
(`/admin/structure/media/manage/<type>`), in the **Expire configuration**
section.

## How to use it

1. Make sure the media type has a **datetime field** to act as the expiry
   trigger (add one at *Manage fields* if it doesn't).
2. On the media type's **Edit** form, tick **Activate media expire**, choose the
   **Expire field**, and optionally select a **Fallback media** item.
3. Let **cron** run the sweep, or force it immediately with
   `drush media:expire-check`.

See [Configuration](configuration/index.md) for the details.

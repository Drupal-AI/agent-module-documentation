# Custom add another — manual setup guide

**Custom add another** (`custom_add_another`) lets you replace the generic **"Add
another item"** and **"Remove"** button labels on multi-value fields with your own
wording. Instead of every repeating field showing the same bland "Add another
item", a gallery field can say *Add another image*, a team-members field can say
*Add another team member*, and the Remove button can read *Delete document* — small
touches that make content-entry forms clearer and friendlier for editors.

There is no admin page and nothing global to switch on. The module simply adds two
optional text boxes to the field's own edit form, and only when it makes sense to:
the labels appear **only on fields whose "Number of values" is set to Unlimited**
(and whose field storage isn't locked). On a single-value or fixed-count field
there's no "Add another" button to rename, so the options stay hidden.

Whatever you type is saved with the field itself (as a third-party setting on the
field configuration), which means it is **per field, per content type**. The same
field reused on two bundles can carry different button text, and the labels travel
with your exported configuration for deployment. Leave a box empty and Drupal's
default wording comes back. The custom labels also apply to the upload and remove
buttons on multiple **file** and **image** fields.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

There is no settings page. You set the labels on each field's edit form, reached
from a bundle's **Manage fields** screen — for example **Structure → Content types
→ Article → Manage fields** (`/admin/structure/types/manage/article/fields`).

## How to use it

1. Go to the **Manage fields** screen for your content type (or other entity
   bundle) and click **Edit** on a multi-value field whose **Number of values** is
   **Unlimited** — for example an image gallery field on Article.
2. Scroll to the two new options:
   - **Custom add another item button** — the text for the button that adds a new
     value, e.g. `Add another image`.
   - **Custom remove button** — the text for the button that removes a value, e.g.
     `Remove image`.
3. Fill in one or both, then click **Save settings**. Leaving a box empty restores
   the default label for that button.

The new labels appear immediately on any content form that uses that field. Because
the setting lives on the field instance, you can give the *same* field different
wording on different content types, and you can manage the labels through exported
configuration if you deploy config between environments.

A note on where the options are: if you don't see them on a field's edit form,
check that the field's **Number of values** is set to **Unlimited** — that is the
condition that makes the customization available.

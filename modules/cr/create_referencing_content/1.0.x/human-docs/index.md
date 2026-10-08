# Create Referencing Content button — manual setup guide

**Create Referencing Content button** (`create_referencing_content`) makes it easy to
give site users a button that creates new content **referencing the content they were
just looking at**. From an article, a visitor clicks a button and lands on a node-add
form for a different content type — with a reference field already pointing back at the
article they came from.

The everyday examples make the idea clear. An academic-articles site adds a "Leave a
review" button on each article that opens a form to create a *Review* which references
that article — richer than comments, and able to go through a moderation workflow. A
recipe site adds a "Post your take on this recipe" button that opens a recipe form with
the "inspired by" reference already filled in. In both cases the editor doesn't have to
remember which article they were responding to — the back-reference is prepopulated for
them.

It works by exposing an **extra field** you place on the display of the content type
being referenced, so this is a **site-builder** feature configured through the Extra
Field admin UI rather than a settings page of its own. It relies on **Entity
Prepopulate (EPP)** to seed the reference field from the URL, plus **Extra Field Plus**
and **Extra Field Configuration** behind the scenes — all three are installed
automatically. It provides its own permission and works with Drupal 8 through 11. (At
the time of writing the module is an alpha release.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (which brings the
   EPP / Extra Field dependencies) and enable the module.

There is **no standalone settings page** — you configure the button through the Extra
Field admin UI and each content type's display, described below.

## How to use it

1. **Create an extra-field display.** Go to **Structure → Extra fields → Add**
   (`/admin/structure/extra-field/add`). Choose **"Create Referencing Content button"**
   as the Extra Field Provider, and under **Enable On** pick the content type(s) that
   will be *referenced* (the content people are viewing when they click the button).
2. **Enable and configure the field on the display.** Go to the referenced content
   type's **Manage display** (for example, for an *Employer* type,
   `/admin/structure/types/manage/employer/display`). Enable the field you just created,
   then click its **gear icon** to set:
   - **Button label** — the text on the button (e.g. "Leave a review").
   - **Tooltip** — hover text.
   - **Classes** — any CSS classes for styling.
   - **Target field** — the reference field on the *referencing* content type that
     should be prepopulated with a link back to the current content.
3. **Save the display** — remember to press **Update** for the button's display
   settings *and* **Save** for the whole page.

The module updates the Entity Prepopulate settings for the target field automatically,
so once saved, the button appears on the referenced content and opens the create form
with the back-reference already filled in. Created content still goes through the normal
node-add access checks.

## Permissions

The module provides its own permission — grant it under **People → Permissions**
(`/admin/people/permissions`) to the roles that should be able to use the button to
create referencing content.

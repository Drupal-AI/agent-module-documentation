# Starry Rating — manual setup guide

**Starry Rating** (`starry_rating`) provides a star-rating **field widget** for
Drupal, built on the vanilla-JavaScript Starry Rating library. Rather than a block
you place, it gives you a widget you attach to a field so editors and visitors can
collect and display star ratings on content. It works on Drupal 10 and 11.

Because it is a field feature, you configure it the way you configure any field
widget — on the field's form-display settings — not through a dedicated admin
settings page. There is no configuration form of its own and no access-control
role; it simply renders a star-rating control for a field.

One thing to keep in mind: ratings are **user-submitted** data. If you expose the
widget where visitors can submit ratings, add anti-abuse measures such as flood
control so the ratings can't be gamed, and think about how you present aggregate
ratings back to your audience.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Starry Rating surfaces as a **field widget**. To use it:

1. Add (or edit) a field on your content type at **Structure → Content types →
   [your type] → Manage fields**.
2. On the content type's **Manage form display** page
   (`/admin/structure/types/manage/[type]/form-display`), set the field's widget
   to the Starry Rating star widget.
3. Adjust how the value displays on **Manage display** as needed.

There is nothing else to configure centrally — the star-rating behavior lives in
the field's widget settings.

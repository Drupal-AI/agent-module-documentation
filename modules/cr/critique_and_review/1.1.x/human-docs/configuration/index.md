# Configuration

Setting up Critique and Review Content happens in two stages: first configure the
module's settings and define your Review Items, then place the review block where
reviewers will use it and restrict it to the right people and pages.

## Open the settings form

1. Log in as an administrator.
2. Go to **Configuration → Content authoring → Critique and Review Module Settings**.

## The settings form, field by field

- **Enabled content types** — select which content types reviews are enabled for.
  (This can be overridden later in the block settings.)
- **Add css from this module** — tick this if you intend to place the Review Form
  block in the sidebar and want the module's own styling, unless you plan to theme
  the display yourself.
- **Allow users to add more Review Items** — when checked, reviewers can create extra
  Review Item sections (and delete existing ones) on the fly, building their review as
  best fits the content. Leave it unchecked to restrict reviewers to exactly the
  Review Items you define below. Even when it is checked, providing a few default
  items is useful for guiding reviewers.
- **Review Help text** — instructions shown to reviewers to explain how you want them
  to approach the review.

## Add Review Items

Below the settings, add one or more **Review Items** — the named sections that give a
review its structure (for example "Intro", "Body", "Conclusion"). Each item should
carry instructions or guidelines for completion. A few notes:

- If "Allow users to add more Review Items" is **unchecked**, only the items you
  define here are available to reviewers.
- If it is **checked**, these items act as a starting point that reviewers can extend
  or trim. The fewer items you define, the more freedom reviewers have.
- A common pattern is to include an "Intro" item first, where the reviewer says hello
  and outlines the approach their review will take.

Save the form when you are done.

## Place the review block

The review form reaches your content through a block:

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. In the region you want, click **Place block** and choose the **Critique and Review
   Block**. The **Sidebar** is a good choice so the form sits beside the content being
   reviewed; **Content Below** works well if you need a wider form. If you place it in
   the sidebar, make sure you ticked **Add css from this module** on the settings
   form (or supply your own CSS).

## Restrict who sees the block, and where

In the block's configuration, tighten its visibility:

- **By role** — restrict which roles can see the block. A good approach is to grant it
  only to a dedicated reviewer role (for example "Sub-editor") or to content editors.
- **By page** — the review block only makes sense on content pages, so on the
  **Pages** tab choose **Show for the listed pages** and enter `/node/*` so it does not
  appear elsewhere.

## Security note

Critiques are user-submitted content tied to their authors. Sanitize the text as you
would any user input, decide carefully who may see and leave critiques through the
role and page restrictions above, and moderate submissions to prevent abuse.

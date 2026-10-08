# Configuration

Setting up Type Tray has two parts: define your **categories** once, globally, then
style each **content type** individually. This page walks through both, plus
layouts and favorites.

## Part 1 — Define categories (global settings)

1. Log in as a user with the **Administer Type Tray** permission (an administrator by
   default).
2. Go to **Configuration → Content authoring → Type Tray Settings**, or navigate
   directly to `/admin/config/content/type-tray/settings`.

The form has three fields:

- **Categories** *(required)* — the groups your content types will be sorted into.
  Enter **one category per line**. You can write just a label (`Editorial`) and the
  machine key is derived for you, or specify both with a pipe:
  `tt_editorial|Editorial`. **The order of these lines is the order the groups
  appear on the tray** — put the most important category first.
- **Fallback category** *(required)* — the label for the catch-all group that holds
  any content type you haven't assigned to a category (default *Uncategorized*).
  Rename it to something like "Other content" if you prefer.
- **Extended description format** *(required)* — which text format editors may use
  when writing the rich, extended descriptions on each content type.

Click **Save configuration**.

> **You can't delete a category that's still in use.** If a content type is still
> assigned to a category, the form refuses to remove it and tells you which
> categories are in use — reassign those types first, then delete the category.

On a fresh install there are no categories yet, so this is the first thing to do.

## Part 2 — Style each content type

For every content type you want to appear nicely in the tray:

1. Go to **Structure → Content types**, and click **Edit** on a type (or navigate to
   `/admin/structure/types/manage/<type>`).
2. Open the **Type Tray** vertical tab at the bottom of the form.
3. Fill in:
   - **Category** — pick one of the categories you defined above. If left empty (or
     pointing at a category that no longer exists), the type lands in the fallback
     group.
   - **Icon** — a webroot-relative path to an icon (for example
     `/themes/custom/foo/icons/article.svg`). Shown in the **grid** layout. If you
     leave it blank, a bundled default icon is used.
   - **Thumbnail** — a webroot-relative path to a larger preview image, shown in the
     **list** layout. A bundled demo thumbnail is used if empty.
   - **Extended description** — a longer, formatted explanation of when to use this
     type, shown in the **list** layout. If empty, the type's normal core
     description is used instead.
   - **Existing content link text** — the wording of a link to the filtered content
     list for this type (e.g. "View existing Article content"). Leave it empty to
     hide the link. (When you first install the module, this is pre-filled for every
     existing type.)
   - **Weight** — the sort order *within* its category; lower numbers rise to the
     top. Use it to put the most-used types first.
4. Save the content type.

> Icons and thumbnails are **paths**, not uploaded files — point them at assets that
> already exist under your web root (for example in your theme).

## Layouts — grid vs list

The tray offers two views a visitor can switch between:

- **Grid** *(default)* — compact cards showing each type's icon and its short (core)
  description.
- **List** — roomier rows showing the thumbnail and the full extended description.

You can deep-link a specific layout by adding a query parameter to the URL, e.g.
`/node/add?layout=list`.

## Favorites

Logged-in users can **star** the content types they use most. Their starred types
are gathered into a synthetic **Favorites** group shown first on their tray.
Favorites are personal — each user has their own set — and don't affect anyone
else's view.

## Ordering recap

Groups render in this order: the user's **Favorites** (if any) first, then your
categories in the exact order you listed them on the settings form, with the
fallback/uncategorized group always last. Within each group, types are sorted by
their **Weight**.

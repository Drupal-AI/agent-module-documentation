# Configuration

Group Media Library Extra is configured by choosing a **media item source** — the
rule that decides which media items appear in the Media Library picker. You set
this in two places: once per group type (for media chosen while working inside a
group) and once globally (for content created outside any group).

## Set the media source for a group type

1. Log in as a user who can administer group types.
2. Go to **Groups → Group types**, choose the group type you want, and open its
   **Media library** tab.
3. Pick the **media item source** that should apply when the Media Library is
   opened in that group's context. The built-in choices are:
   - **Own media items** — the user only sees media items they own.
   - **Group's media items** — the user only sees media associated with the
     current group. *(Requires the Group Media / `groupmedia` module.)*
   - **Media without group** — used to restrict the picker to media that does not
     belong to any group. *(Requires the Group Media module.)*
   - Any custom source plugin you have added.
4. Save.

Repeat for each group type that needs its own rule.

## Set the media source for global (non-group) content

Content that is created outside any group needs its own rule, so that media
belonging to a group is not offered where it should not be used.

1. Go to **Groups → Settings → Media Library Extra Settings**.
2. Choose the **media item source** to apply to global content. The **Media
   without group** source is the natural choice here, as it keeps group-owned
   media out of non-group content.
3. Save.

## A note on access

Choosing a source here changes **which items are listed** in the Media Library
picker — it is a convenience and hygiene control, not an access decision. The
underlying question of who may actually view or use a media item is still governed
by the Group and Group Media Library access model. Configure those as well if you
need group media to be genuinely restricted, not merely hidden from the picker.

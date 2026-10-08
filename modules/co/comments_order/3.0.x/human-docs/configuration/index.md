# Configuration

Comments Order has no central settings page. Instead it adds three options to the
edit form of each **comment field**, and you set them per field. This page walks
through those three options and where they live.

## Open the comment field's settings

1. Log in as a user who can administer the entity's fields (an administrator by
   default).
2. Go to the bundle's field list — for a content type that is **Structure →
   Content types → *(your type)* → Manage fields**
   (e.g. `/admin/structure/types/manage/article/fields`).
3. Click **Edit** on the **Comments** field (its machine name is usually
   `comment`).
4. The three Comments Order options appear on that field's settings form.

The options only show for fields whose type is actually *comment*, so you will not
see them on ordinary text or reference fields.

## Comments order

This is the main switch. Choose between:

- **Oldest first (ascending order)** *(default)* — the classic order, with the
  first comment at the top. Best for discussions where reading order matters.
- **Newest first (descending order)** — the most recent comment appears first.
  Best for a "latest activity" feel on a busy article or news post.

Everything below only changes behavior in combination with this setting.

## Natural order for children

This checkbox only appears when **Comments order** is set to *Newest first* **and**
the field is displayed as a **threaded** discussion. It decides what "newest first"
means once you have replies nested under a comment:

- **Ticked** *(default)* — reverse only the top-level comments, but keep each reply
  chain in its natural, chronological order. You get the newest conversations at
  the top while each thread still reads top-to-bottom.
- **Unticked** — reverse the replies too, so the whole tree reads newest-first
  everywhere, parents and children alike.

## Order by "Authored On" field

This checkbox only appears when the field is displayed as a **flat** (non-threaded)
list. By default a flat list is ordered by the comment's internal id, which matches
the order comments were created. Tick this to sort by the comment's **Authored on**
date instead — useful when comments were imported or backdated and their creation
order does not match their real dates.

## Save

Click **Save settings** on the field form. The new order takes effect on the next
page load (clear caches if you do not see the change immediately). When newest-first
is active, anyone who posts a new comment is sent back to the first page so they
land on their freshly added comment.

## Where the settings are stored

The three options are saved as third-party settings on the comment field's config
entity — `field.field.<entity_type>.<bundle>.<comment_field>` — so they export and
deploy with the rest of your configuration. You can read the current values with:

```bash
drush cget field.field.node.article.comment third_party_settings.comments_order
```

Because each comment field carries its own settings, you can give different content
types (or even different comment fields on the same entity) completely different
ordering.

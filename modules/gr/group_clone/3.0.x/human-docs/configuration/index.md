# Configuration

Group Clone is configured centrally under Group's settings, where you decide which
group types may be cloned and how each type of group content behaves when a group
is duplicated.

## Open the cloning settings

1. Log in as a user with the **Administer group** permission (`administer group`).
2. Go to **Groups → Settings → Cloning settings**.

## Choose which group types can be cloned

The settings let you define **which group types can be cloned**. Enable cloning
only for the group types where duplicating a group makes sense. As soon as cloning
is enabled for a group type, every group of that type gains a **Clone** tab.

## Set the default cloning behaviour per group content type

For each **group content type**, you set the default behaviour used when a group is
cloned — that is, what should happen to each kind of related content during the
clone. This is where you decide which content and referenced entities are copied
along with the group entity itself, rather than only the empty group.

Review these defaults carefully for group content types that may hold sensitive
data, since cloned content inherits the source group's data.

## Save

Save the form. New **Clone** tabs appear on the group types you enabled, and
cloning follows the per‑content‑type defaults you set here.

## Reverting a clone

Cloning is reversible. After a group has been cloned, open the **Clone** tab on the
cloned group and choose to revert it. Reverting deletes all the entities that were
created by the clone and does **not** affect the source group in any way.

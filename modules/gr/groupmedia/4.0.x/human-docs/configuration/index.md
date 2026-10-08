# Configuration

Group Media has **no single settings page**. Instead you configure it per group
type, by installing the Group media relation plugin, turning on tracking if you
want it, and granting permissions. This page walks through that workflow.

## Enable media as group content on a group type

1. Log in as an administrator and go to **Administration → Groups → Group types**
   (`/admin/group/types`). Make sure you have a group type to work with, or create
   one.
2. From the group type's dropbutton, choose **Set available content**. This shows
   the list of relation plugins you can install on that group type.
3. Each media type appears as its own plugin, named **Group media (<Type>)** — for
   example "Group media (Image)". Click **Install** on the media types you want
   groups of this type to manage.
4. Installing shows a short configuration form:
   - **Enable media tracking** — a checkbox (off by default). Leave it off to
     require members to relate/create media by hand; turn it on to have media that
     is referenced by the group's content attached to the group automatically when
     the content is saved.
   - **Entity cardinality** — locked to **1** (a media item belongs to one group
     through this relation). You cannot change this.
   - **Group cardinality** — editable; controls how many groups a media item can
     be related to.
   - A group creation‑wizard toggle inherited from the Group module.

Repeat for each media type you want available in groups.

## The Media tab

Once at least one Group media plugin is installed on a group type and a user has
the **Access group media overview** permission, every group of that type shows a
**Media** tab. It lists the group's media and offers **Relate media** (attach an
existing item) and **Create media** (make a new item inside the group) action
links.

## Automatic tracking

If you ticked **Enable media tracking** for a relation, Group Media watches
content as it is saved and attaches any media it finds — media reference fields,
CKEditor media embeds, Entity Embed, and (with the `groupmedia_paragraphs`
submodule) media inside Paragraphs — to the relevant group. Manually relating or
creating media is unaffected by this flag; it only governs the automatic
attachment. You can enable tracking for some media types and leave it off for
others.

## Permissions

Set permissions per group type at
**Administration → Groups → Group types → *(your type)* → Permissions**
(`/admin/group/types/manage/<group_type>/permissions`):

- **Access group media overview** — lets a group role see the group's Media tab.
- **Create / View / Update / Delete** for each Group media plugin — the standard
  per‑plugin group permissions that control what members may do with each media
  type inside the group.

There is also one global permission, **Administer groupmedia**, on the main
Drupal permissions page (`/admin/people/permissions`). It is marked as a
restricted, security‑sensitive permission — grant it only to trusted roles.

## Bulk actions

Group Media provides two content actions — **Assign media to a Group** and
**Remove media from Group** — usable from the media overview
(`/admin/content/media`). With the `groupmedia_vbo` submodule enabled, Views Bulk
Operations versions let you choose the target group at the time you run the
action.

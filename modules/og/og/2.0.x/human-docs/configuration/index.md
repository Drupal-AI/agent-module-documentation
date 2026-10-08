# Configuration

Setting up Organic Groups is a few conceptual steps: decide which content type is
a **group**, make another content type **group content** by giving it a group
audience field, then manage the **roles, permissions, and memberships** within
those groups. The og_ui submodule provides the screens for most of this; a couple
of operations (marking a bundle as a group, adding the audience field) are done in
code or through og_ui's per‑bundle options.

This page summarises the workflow. For the exact service calls and config keys, see
the [`agent/`](../agent/start.md) docs.

## Step 1 — Make a bundle a group

Marking a content type (or any bundle) as a group is a single change. In code:

```php
use Drupal\og\Og;
Og::groupTypeManager()->addGroup('node', 'team');   // "Team" nodes are now groups
```

(The og_ui submodule exposes this as an "Organic Groups" option on the bundle's
settings.) When a bundle becomes a group, OG automatically:

- registers the bundle in the group registry (`og.settings`), and
- creates three **OG roles** for it — **member**, **non‑member**, and
  **administrator**. The first two are required and can't be deleted; the
  administrator role holds all group permissions. Each group's members are assigned
  these (or additional) roles independently of their site‑wide Drupal role.

## Step 2 — Make another bundle group content

Group content is any bundle that carries an **OG audience field** referencing a
group. In code:

```php
use Drupal\og\Og;
use Drupal\og\OgGroupAudienceHelperInterface;
Og::createField(OgGroupAudienceHelperInterface::DEFAULT_FIELD, 'node', 'post');
```

This adds the **Groups audience** field (`og_audience`) to the bundle and wires it
into the add/edit form and the display. The field is multi‑value, so one piece of
content can belong to several groups at once. Once any audience field exists on a
bundle, that bundle is group content, and creating an item in a group ties it to
that group.

You can point the audience field at a different entity type, or use a custom field
name, via overrides — and you can even make **users** or **taxonomy terms** group
content by attaching an audience field to them.

## Step 3 — Membership types (optional)

The link between a user and a group is an `og_membership` entity, and its bundle is
a **membership type**. OG ships one, **default**. To model, say, free vs premium
membership, add another membership type at **Structure → Membership types → Add**
(`/admin/structure/membership-types/add`), then set which membership type new
members of a given group bundle get. Because memberships are fieldable, you can add
fields (join reason, expiry date, notes) to a membership type.

## Step 4 — Roles and group‑level permissions

OG permissions are **per group**, not global. They attach to the OG roles (member,
non‑member, administrator, plus any you add). With og_ui you manage them at:

- **Configuration → Group → Roles** (`/admin/config/group/roles`), and
- **Configuration → Group → Permissions** (`/admin/config/group/permissions`).

The shipped group‑level permissions include **administer group**, **update group**,
**delete group**, **manage members**, **add user**, **subscribe**, **subscribe
without approval**, **approve and deny subscription**, and **administer
permissions**. By default the *administrator* role gets the management ones and
*non‑member* gets **subscribe** (so people can join). In addition, for each group
content bundle OG derives create/edit/delete permissions (e.g. *create post
content*, *edit own post content*, *delete any post content*) that you grant to
group roles — this is how you let members create content inside a group but not
elsewhere.

There is also one **global** Drupal permission, **Administer Organic groups**
(security‑sensitive), on People → Permissions, which grants everything in every
group — reserve it for site administrators.

## Step 5 — Memberships, subscribing, and moderation

Users join a group by **subscribing**. OG provides subscribe/unsubscribe links
(the `og_group_subscribe` field formatter renders a Subscribe/Leave link on the
group). Whether a new membership is immediately **active** or held as **pending**
depends on the group's permissions and the site setting for approval — this is how
you implement open, moderated, or closed membership. A troublesome member can be set
to **blocked** without deleting their membership.

Each group's members are managed from that group's admin tabs, and the bundled
**members overview** view offers bulk actions to add/remove roles, approve pending
requests, and block/unblock members.

## Site‑wide settings

With og_ui enabled, the site‑wide options are at **Configuration → Group →
Settings** (`/admin/config/group/settings`). The main ones:

- **Group manager full access** — the person who created a group gets every
  permission in it (on by default).
- **Strict node access** — enforce OG access on node create/update/delete instead
  of Drupal's global node permissions.
- **Deny subscribe without approval** — joining a private group always starts as a
  pending request.
- **Auto‑add group owner membership** — creating a group makes you a member of it.
- **Delete orphans** — when a group is deleted, whether to delete (or orphan) its
  group content, and how (simple, batch, or via cron queue). On big sites the batch
  and cron options queue the work; process it with
  `drush queue:run og_orphaned_group_content`.
- **Group resolvers** — the ordered list of strategies OG uses to work out "the
  current group" from the route, the group content, a query argument, or the user.

## Extending OG

Developers can add group‑level permissions from their own module via the
`og.permission` event, and implement OG's three plugin types — `og_fields`,
`og_delete_orphans`, and `og_group_resolver`. See the [`agent/`](../agent/start.md)
plugin and hooks docs.

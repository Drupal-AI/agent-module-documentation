# Configuration

Simplify hides nothing until you tell it what to hide. Configuration comes in two
layers: a **global** settings form that applies site-wide per entity type, and
optional **per-bundle overrides** you set on individual content types,
vocabularies, and so on. On top of that, two permissions decide who actually sees
the simplified forms.

## Open the settings form

1. Log in as a user with the **Administer Simplify** permission (an administrator
   by default).
2. Go to **Configuration → User interface → Simplify**, or navigate directly to
   `/admin/config/user-interface/simplify`.

The form is a set of checkboxes grouped by entity type — **Nodes**, **Users**,
**Comments**, **Taxonomy terms**, **Blocks**, **Media**, **Menu links**, and so
on. A group only appears if the module that provides that entity type is enabled
(the Users group needs the User module, Comments needs Comment, and so on). Tick
the fields you want hidden in each group.

## What you can hide

The available rows depend on your enabled modules, but the common built-in ones
are:

- **Nodes** — *Authoring information* (author and date), *Text format* selectors,
  *Promotion options* (Promoted to front page / Sticky), *Revision information*,
  *Status metadata*, plus *Menu settings*, *URL path settings*, *Comment
  settings*, and *Book outline* when those modules are on.
- **Users** — *Text format*, *Status* (blocked/active), *Locale settings*
  (timezone/language), and *Contact settings*. These apply to both the account
  form and the registration form.
- **Taxonomy terms** — *Relations*, *Revision information*, *URL alias*, and text
  format.
- **Comments / Blocks / Media / Menu links** — text-format selectors, revision
  information, name and author (media), parent link and description (menu links),
  and similar.

Third-party fieldsets such as *Meta tags* (Metatag), *URL redirects* (Redirect),
and XML Sitemap rows also appear here when those modules are installed.

## The "hide from admin users" switch

By default, User 1 and anyone with an administrator role always see hidden fields
(because they implicitly have every permission, including *View hidden fields*).
If you want the simplified forms to apply to administrators too, tick **Hide
fields from admin users** on the settings form. With that on, even admins get the
decluttered forms.

## Save

Click **Save configuration**. Changes take effect immediately — open a matching
edit form (as a user without *View hidden fields*) and the chosen fields should be
gone. If a form was already open, reload it.

## Per-bundle overrides

Beyond the global settings, you can hide fields on just one bundle. Each
content type, comment type, vocabulary, and custom block type edit form gains its
own **Simplify** section (visible to users with *Administer Simplify*). For
example, to hide *Promotion options* only on the *Article* content type, edit that
content type at **Structure → Content types → Article** and tick the box in its
Simplify section — the other content types are unaffected.

The effective hidden set on any form is the **union** of the global settings and
that bundle's overrides. Fields already hidden globally show up as
checked-and-disabled on the bundle form, so you can see what is inherited.

## Who sees the simplified forms

Visibility is governed by the **View hidden fields** permission (see
[Installation](../installation/index.md#grant-permissions)):

- Users **without** *View hidden fields* get the simplified forms — the chosen
  fields are hidden from them.
- Users **with** it see every field as normal.
- Administrators and User 1 see everything by default, unless you enabled *Hide
  fields from admin users* above.

## A note on hidden vs removed

Most fields are hidden with a "visually hidden" CSS class — they remain in the
page and are still submitted, so no data is lost. A few, notably *URL path
settings*, are fully removed from the form instead. Either way, existing field
values are preserved.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Drupal.org Links provides three field formatters that render an integer/decimal/string field value as a hyperlink to the matching user, node or comment page on drupal.org.

---

Drupal.org Links (`drupalorg_links`) is a tiny, dependency-free display module by Damien McKenna / Mediacurrent. It ships three `@FieldFormatter` plugins — `drupal_uid_link`, `drupal_nid_link` and `drupal_cid_link` — that each take the numeric value stored in a field and turn it into a link to `https://www.drupal.org/user/N`, `/node/N` or `/comment/N` respectively. All three apply to core `integer`, `decimal` and `string` field types, cast the value with `intval()` (so a decimal or numeric string is reduced to its integer part), and render the link with the label `#N`. There is nothing to configure: the formatters have no settings form, no permissions, no routes, no config schema and no submodules. You select one of them per field on a bundle's *Manage display* page (or via a `core.entity_view_display.*` config export). Empty or non-numeric (zero) values render nothing. It is useful whenever a Drupal site stores drupal.org identifiers (issue node IDs, user IDs, comment IDs) as plain numbers and you want them displayed as clickable links back to drupal.org.

---

- Display a stored drupal.org **issue/node ID** as a link to that issue with the "Drupal.org node link" formatter.
- Display a contributor's **drupal.org user ID** as a link to their profile with the "Drupal.org user link" formatter.
- Link a stored **comment ID** to its comment permalink on drupal.org with the "Drupal.org comment link" formatter.
- Turn a "Related drupal.org issue" integer field on a bug-tracking content type into a clickable link.
- On a "Module" content type, link a `field_project_nid` value to the module's drupal.org project node.
- On a team/staff directory, link each person's `field_dorg_uid` to their drupal.org profile.
- Build a changelog or release-notes node that lists issue numbers, each rendered as a link to the drupal.org issue.
- Link a "sponsored fix" comment ID to the drupal.org comment where the work was discussed.
- Show a maintainer's drupal.org profile link in a Views field output (any integer/string field using the formatter).
- Convert a legacy numeric column imported from drupal.org (uid/nid/cid) into live links without writing custom code.
- Render a decimal or string field that happens to hold an integer identifier as a drupal.org link (value is `intval()`-cast).
- Add a "Discuss on drupal.org" node link to a documentation page that tracks an upstream issue.
- Surface the drupal.org node for a case study or success story stored as a number.
- Display a "credits" field of drupal.org user IDs, each linking to a contributor profile.
- Link a "porting issue" node ID on a module-upgrade tracker to the drupal.org issue queue entry.
- Provide clickable drupal.org profile links in an editorial workflow that references reviewer UIDs.
- Show a "first reported in comment #" value as a direct link to that drupal.org comment.
- Link a "meta issue" node ID from a project-management content type to its drupal.org node.
- Present a numeric "project node" reference in a partner/agency directory as a drupal.org link.
- Hide the raw number and show a tidy `#N` link instead, keeping display consistent across content.

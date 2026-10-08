# Configuration

Configuring Menu Position is a matter of creating **rules** — each one saying
"pages matching these conditions belong at this spot in a menu" — ordering them,
and choosing one site-wide **display mode** that decides how a match is shown.

## Creating a rule

1. Go to **Structure → Menu position rules**
   (`/admin/structure/menu-position`) and click **Add rule**.
2. Give the rule a descriptive **label** (for example "Articles under News").
3. Choose the **Parent menu item** — the menu and the specific item beneath which
   matching pages should sit. You must pick an actual item within a menu, not a
   bare menu.
4. Add one or more **conditions** that describe which pages the rule applies to
   (see below).
5. Save.

The rule is enabled by default. You can untick a rule's **Enabled** box later to
switch it off temporarily without deleting it.

### Conditions

A rule's conditions come straight from Drupal core's standard condition system,
so you get the same building blocks used elsewhere in Drupal:

- **Content types** — match nodes of chosen content types (e.g. all Articles).
- **Pages** — match by path, including wildcards like `/news/*`. There is a
  show/hide toggle so you can match everything *except* the listed paths.
- **Roles** — apply the placement only for users in chosen roles.
- **Theme** and **Language** — apply only under a given theme or in a given
  language.
- Any additional condition plugins provided by other contrib modules.

Each condition you configure is saved with the rule. Note that a rule with **no
conditions always matches** — useful for a catch-all, but easy to trigger by
accident, so add conditions unless you truly want it to apply everywhere.

## Ordering rules — first match wins

Back on the rules list, drag the rules into the order you want. Rules are
evaluated top to bottom and **the first matching rule wins** for a given menu, so
put your most specific rules (for example a precise path rule) *above* broader
ones (like a whole-content-type rule). Save the ordering.

## The global display mode

Go to the **Settings** tab (`/admin/structure/menu-position/settings`) to choose
what happens when a rule matches. There is one setting, **Link display**, with
three options:

- **Parent** *(default)* — the rule's parent menu item is marked active, so it is
  highlighted and drives the breadcrumb trail. Nothing new is added to the menu.
- **Child** — the current page is inserted into the menu tree as a real child
  link under the parent, showing the page's own title.
- **None** — no menu item is marked active for matched rules (you keep the rules
  but suppress the visual highlighting).

This setting is site-wide — it applies to all rules. After changing it, clear
caches (`drush cr`) so the derived menu links are rebuilt.

## Deleting a rule

Use the **Delete** link next to a rule on the rules list. Deleting a rule also
removes the menu link it derived, so nothing is left behind.

## Deploying rules

Because each rule is stored as configuration, you can export your rules and
import them into another environment with the usual configuration workflow
(`drush config:export` / `drush config:import`), keeping menu placement
consistent across environments.

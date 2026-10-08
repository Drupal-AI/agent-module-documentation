# Configuration

Everything Theme Switcher Rules does is driven by the *rules* you create here. A
rule pairs a theme with a set of conditions; the first enabled rule (in weight
order) whose conditions match decides the theme for that request.

## Open the rule list

1. Log in as a user with permission to manage rules (an administrator by default —
   see [Permissions](#permissions) to delegate).
2. Go to **Configuration → System → Theme Switcher Rules**, or navigate directly to
   `/admin/config/system/theme_switcher`.

The list shows every rule with its weight (drag handle), status, and links to edit
or delete. You can enable or disable a rule inline without opening it, and drag rows
to reorder them.

## Add a rule

Click **Add theme switcher rule** and fill in the form:

- **Label** — a human-friendly name for the rule (e.g. "Campaign pages"). This is
  just for your own reference in the list.
- **Theme** *(required)* — the theme to apply on normal (non-admin) pages when this
  rule matches. The dropdown lists every installed theme, plus a *- None -* option.
- **Admin Theme** *(optional)* — the theme to apply on admin pages when this rule
  matches. Leave it as *- None -* unless you specifically want this rule to take
  over the admin interface. A rule only affects admin pages if you set this.
- **Conditions** — a set of vertical tabs, one per available condition plugin. This
  is where you decide *when* the rule applies. See [Conditions](#conditions) below.
- **Condition conjunction** — choose how the conditions combine:
  - **AND** — every condition you configured must match.
  - **OR** — at least one configured condition must match.

Save the form and you're returned to the list.

> The **weight** (evaluation order) isn't set on this form — you control it by
> dragging rows on the list page.

## Conditions

The condition tabs are the same building blocks Drupal uses for block visibility,
so they'll feel familiar. The common ones:

- **Pages** (`request_path`) — the most-used condition. Enter one path per line;
  `*` is a wildcard and `<front>` matches the front page. For example
  `/campaign` and `/campaign/*` together match the campaign section.
- **Content types** — match when viewing a node of the chosen bundle(s). This only
  applies on routes that actually have a node (like a node page), so a
  content-type rule simply won't fire on, say, a Views listing.
- **Roles** — match visitors who have one of the selected roles.
- **Languages** — match the selected language(s). This tab only appears on
  multilingual sites.

Every condition also has a **Negate the condition** checkbox, which flips its
meaning to "everywhere except these." Note that the module deliberately hides the
"Current theme" condition (it would create a loop) and hides "Languages" entirely
on single-language sites.

## Ordering rules — first match wins

This is the key mental model: on each request the module evaluates enabled rules
from **lowest weight to highest** and stops at the **first** one that matches. So:

- Drag your **most specific** rules to the top (lowest weight).
- A disabled rule, or a rule whose theme is empty for the current context, is
  skipped.
- Because a content-type or language rule can't match on a route that lacks that
  context, it's automatically passed over there — no special handling needed.

If a page isn't picking up the theme you expect, check the ordering first, then
confirm the rule is enabled, then double-check the condition values. You can
disable rules one at a time from the list to narrow down which one is winning.

## Permissions

The module defines five permissions so you can delegate rule management:

| Permission | What it allows |
|-----------|----------------|
| **Administer theme switcher rules** | Full control — create, view, edit, delete, enable/disable every rule. |
| **View theme switcher rules** | See the rule list (read-only auditing). Combined with the administer permission it also opens the list route. |
| **Create theme switcher rules** | Add new rules. |
| **Edit theme switcher rules** | Edit existing rules and use the inline enable/disable toggle. |
| **Delete theme switcher rules** | Delete rules. |

Grant them under **People → Permissions**, or from the command line:

```bash
drush role:perm:add editor 'administer theme switcher rules'
```

Note that the general "Administer site configuration" permission does **not** by
itself grant per-rule access — the module uses its own access check, so assign one
of the permissions above to anyone who needs to manage rules.

# Configuration

EcoIndex works for measurement as soon as you add its field to a content type, so
the settings here are mostly about **setting a target score** and deciding what
happens when a page doesn't reach it.

## Open the settings form

1. Log in as a user with permission to administer the site's configuration.
2. Go to the EcoIndex settings page under **Administration → Configuration** (the
   `ecoindex.settings` route).

## Set a target EcoIndex score

The main setting is a **target (minimum) EcoIndex score** for your pages. EcoIndex
scores run from 0 to 100 (higher is better), with a corresponding letter grade
from G (worst) to A (best). Choose the score you want your content to reach.

## Behavior when the target isn't reached

When a page's measured score falls below your target, the module can:

- **Show an alert message** — a warning is displayed so the contributor knows the
  page hasn't met the target and can improve it.
- **Block publication** — optionally, prevent the content from being published at
  all until its score reaches the target. Use this if you want the target to be a
  hard requirement rather than just advice.

Choose whichever combination matches how strict you want to be: a gentle nudge
(alert only) or a firm gate (block publication).

## Save

Save the form to apply your settings. From then on, when contributors refresh a
page's EcoIndex score, the alert (and, if enabled, the publication block) applies
against the target you set.

## Related display options

The settings page governs targets and publication behavior; where and how the
score itself appears is controlled elsewhere:

- Add the **ecoindex** field to a content type's **Manage fields**, and configure
  it on **Manage form display** (to get the *Refresh EcoIndex score* action) and
  **Manage display** (to show the score/grade).
- Add the field to a **View** to show EcoIndex scores across a content listing.
- With the optional **Diff** module enabled, you can compare EcoIndex scores
  between revisions of a piece of content.

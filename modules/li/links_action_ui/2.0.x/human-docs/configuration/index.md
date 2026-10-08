# Configuration

Links Action UI is configured entirely from its own admin screen, where each
"action link" is a configuration entity you create and edit.

## Open the management screen

1. Log in as a user with the module's action-links management permission.
2. Go to **Configuration → System → Local actions**
   (`/admin/config/system/local-actions`).

You'll see the list of action links you have defined, with an option to add a new
one.

## Create an action link

Add a new action and fill in its fields:

- **Action button text** — the label shown on the button (for example
  *Add item*, *Import data*).
- **Target URL / route** — where the button takes the user when clicked. The
  module validates that this is a real Drupal route.
- **Appears on** — one or more pages (admin routes) where the button should be
  displayed. A single action can be assigned to several pages, so you can reuse
  the same button across related screens.
- **Weight** — controls the order in which actions appear when more than one is
  shown on the same page. Lower weights sort earlier.

Save the action. The module clears the relevant caches itself, so the button
appears (or updates) immediately — no manual `drush cr` needed.

## Managing and deploying

Because each action link is a **configuration entity**, it is exportable with the
rest of your site configuration. Create your actions on one environment, export
config, and import it elsewhere to roll the same buttons out across staging and
production. Edit or delete existing actions from the same **Local actions**
screen.

# Configuration

Feature Toggle is managed from a single admin screen where you define features and
flip them on and off. This page walks through both, explains the two permissions,
and covers the one thing that surprises people: where the on/off status is stored.

## Open the Feature Toggle screen

1. Log in as a user with **Administer feature toggle** (or **Modify feature toggle
   status** — see [Permissions](#permissions)).
2. Go to **Configuration → System → Feature Toggle**, or navigate directly to
   `/admin/config/system/feature_toggle`.

You'll see the list of features, each with a checkbox that represents its current
on/off status.

## Add a feature

1. On the Feature Toggle screen, click **Add feature** (or go to
   `/admin/config/system/feature_toggle/add`).
2. Fill in:
   - **Feature Name** — the human-readable label (e.g. *Beta Checkout*).
   - **Machine name** — the identifier your code, Twig, and Drush use (lowercase
     letters, numbers, and hyphens, e.g. `beta_checkout`).
   - **Description** *(optional)* — a note about what the feature covers.
3. Click **Save**.

Creating a feature only *defines* it; a new feature starts switched off until you
toggle it on.

## Turn features on and off

On the main list, tick the checkbox next to a feature to enable it (or untick to
disable it), then click **Save**. That is the whole toggle workflow. You can also
edit a feature's label/description or delete it from its row (both require the
**Administer feature toggle** permission).

## Toggling from the command line

Developers and deploy scripts can flip a feature without the UI:

```bash
drush feature_toggle:set beta_checkout 1   # turn on  (alias: drush ftset beta_checkout 1)
drush feature_toggle:set beta_checkout 0   # turn off
```

The value must be `1` or `0`, and the feature must already exist. This runs exactly
the same code path as the UI, so it fires the update event and clears the relevant
caches too. There is no Drush command to *create* features — define those in the UI.

## Where the status is stored (important)

Feature Toggle deliberately splits its data into two places:

- **Feature definitions** (name, label, description) live in **configuration**
  (`feature_toggle.features`), so they are exported and deployed with the rest of
  your config.
- **The on/off status** lives in Drupal's **key-value store**, *not* in
  configuration.

The practical consequence: **toggling a feature is not a config change.** It will
not appear in `drush config:export`, and different environments (production,
staging, local) can keep the same feature in different states. This is intentional —
it lets you enable a feature on production without a code deployment, and it keeps
per-environment toggles from fighting your config workflow.

## Consuming a feature elsewhere

Defining and toggling features is only half the story — the point is to gate things
on them. Feature Toggle offers several ways to do that, all set up in the usual place
for each (no extra config here):

- **Blocks** — on a block's **Visibility** tab, use the **Feature Toggle** condition
  to show the block only when chosen features are enabled.
- **Views** — under a view display's **Access** setting, choose one of the Feature
  Toggle access plugins: *Feature (Unrestricted)*, *Permission + Feature*, or *Role +
  Feature*.
- **Routes and Twig and JavaScript** — developers can gate a route with a
  `_feature_toggle` requirement, check a flag in a template with
  `feature_toggle_status('my_feature')`, or read the enabled list in JS from
  `drupalSettings.feature_toggle.enabled`.

See the [`agent/`](../agent/start.md) docs for the exact syntax of the developer
integrations.

## Permissions

Grant these at **People → Permissions**:

- **Administer feature toggle** (`administer feature_toggle`) — full control: add,
  edit, and delete features, plus toggle them. Reserve for site administrators.
- **Modify feature toggle status** (`modify feature_toggle status`) — flip existing
  features on and off only, with no ability to create, edit, or delete them. A good
  fit for trusted editors.

A typical setup gives editors the *modify status* permission so they can flip
features on the list page, while administrators keep the *administer* permission to
define the feature set. Note these permissions govern **administering** the toggles;
gating actual site behavior on a feature is done through the block/Views/route/Twig
integrations above.

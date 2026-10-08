# Configuration

Feature flags are managed at **Configuration → Development → Feature Flags**
(`/admin/config/development/featureflags`). The page lists every flag currently
defined on the site. Access requires the *administer featureflag entities*
permission — grant it only to people you trust to switch features on and off, since
a flag may be hiding something that is not yet ready.

## Create a feature flag

1. On the Feature Flags page, click **Add feature flag**
   (`/admin/config/development/featureflags/add`).
2. Give the flag a human‑readable **label** and a **machine name** — the machine
   name is what code, Twig, and conditions refer to.
3. Save. The flag now exists as a configuration entity, ready to be exported and
   deployed with the rest of your configuration.

## Turn a flag on or off

From the flag list, activate or deactivate each flag. Remember the distinction: the
flag's **definition** lives in configuration (exportable, diffable), while its
**active/inactive state** is stored in Drupal's state system — so you can flip a
flag per environment without a config change, and even override it in
`settings.php` if staging and production should differ.

## Use a flag to gate a block

The module provides a condition plugin, so any block's visibility can depend on a
flag:

1. Place or edit a block at **Structure → Block layout**
   (`/admin/structure/block`).
2. In the block's visibility settings, find the **feature flag** condition and
   choose the flag that should control the block.
3. Save. The block now appears only when that flag is active.

## Using a flag in code and templates

- **In code**, check a flag through the flag manager service (for example
  `FeatureFlag::isActive('my_feature_flag')`) and branch on the result.
- **When you render flag‑dependent output, declare the module's cache context** so
  the render cache varies on the flag's state. This is the single most common
  mistake: without the context, the first response is cached and shown to everyone
  regardless of the flag, and the flag will appear to do nothing.

## Lifecycle

Once a feature becomes permanent, retire its flag to keep the control surface tidy.
Because flags are configuration, add and remove them through your normal config
review and deployment process — a flag change is a reviewable diff.

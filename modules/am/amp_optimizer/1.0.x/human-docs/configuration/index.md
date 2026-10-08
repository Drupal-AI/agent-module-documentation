# Configuration

AMP Optimizer works as soon as it is enabled — it starts optimizing HTML
responses for anonymous visitors automatically. The settings form lets you
review and adjust how the optimizer behaves.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Web services → AMP → Optimizer**, or navigate
   directly to `/admin/config/services/amp/optimizer`.

## What it does

The form (route `amp_optimizer.settings`) controls the optimizer's behavior.
The heavy lifting — server-side rendering of AMP components and streamlining
assets — is done by the underlying `ampproject/amp-toolbox` library; the settings
here tune how that library is applied to your responses.

Keep in mind:

- Optimization only runs for **anonymous users** and only on **HTML responses**;
  logged-in previews are never optimized.
- Optimizer errors are logged to the **`amp_optimizer`** log channel — check
  there (Reports → Recent log messages) if AMP output does not look right.
- You can effectively turn the optimizer on or off by enabling or disabling the
  module.

## Save

Save the form to apply your changes. Because the optimizer runs on anonymous,
often-cached responses, rebuild caches if you want to see the effect immediately.

# Configuration

Setting up Simple ActiveCampaign is a two-step job: first connect Drupal to your
ActiveCampaign account, then place and tailor the subscription block.

## Step 1 — Enter your API credentials

1. Log in as an administrator.
2. Go to **Configuration → Web services → ActiveCampaign**.
3. Enter your **API URL** and **API key** from your ActiveCampaign account.
4. Save.

Because the API key is a credential that lets your site write to your
ActiveCampaign account, store it securely — prefer keeping the value in an
environment variable (or a Key entity) rather than a plain configuration value that
ends up in an exported, version-controlled config file.

Once valid credentials are saved, the module can load your ActiveCampaign contact
lists over the API, which the block settings below rely on.

## Step 2 — Place and configure the block

1. Go to **Structure → Block layout** (`/admin/structure/block`).
2. Find the **ActiveCampaign** block and place it into the region where you want the
   sign-up form to appear.
3. Open the block's configuration. Because the form is customizable per block
   instance, you can set up several blocks differently. The settings let you:
   - **Choose the default contact list** that new subscribers are added to.
   - **Optionally allow visitors to pick an extra list** to join, in addition to the
     default.
   - **Re-label, hide, and reorder** the contact lists that were loaded from
     ActiveCampaign, so visitors see only the choices you want, with friendly names.
   - **Customize the form field labels** and the **success** and **failure**
     messages shown after a submission.
4. Save the block.

## Permissions

The module provides its own permission controlling who may use the subscription
form. Review it at **People → Permissions** and grant it appropriately — typically
you want anonymous visitors to be able to submit the sign-up form.

## Test it

Visit a page showing the block, submit the form with a test email, and confirm the
success message appears and that a matching contact shows up in the chosen list
inside your ActiveCampaign account.

# Configuration

Setting up a paywall is a few steps: pick the entity types that hold premium
content, choose how items are marked premium, pick the fields to hide and the roles
that may see them, and (optionally) place a "subscribe to continue" block.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Content authoring → Role Paywall**
   (`/admin/config/content/role_paywall`).

## 1. Select the entity types with premium content

On the main settings form, tick the entity types that contain premium content and
save. The module supports content entities that have a canonical URL (nodes and
similar), with the exception of a few core entities. After saving, a **tab appears
for each entity type** you selected — open the relevant tab to configure it.

## 2. Configure each entity type

Within an entity type's tab:

- **If the entity type has bundles** (for example content types), first choose which
  **bundles** the paywall should apply to and save — the rest of the form then
  appears.
- **Premium content field** — choose a boolean field on the entity that marks an
  individual item as premium, or configure the paywall to apply to *all* items of the
  bundle. Using a boolean field lets editors flip a single article between free and
  premium.
- **Fields to hide** — select which fields sit behind the wall. The list is drawn
  from the fields shown in the **Full** (or Default) view mode.
- **Roles / access rules** — the form lists the available access-rule plugins and
  the roles that may see the premium fields, alongside the **Access premium
  content** permission. Each access-rule plugin has its own settings form and must
  be configured, then ticked **Enabled**, before it takes effect.

Save the tab.

## 3. Add the subscribe block (optional but recommended)

To prompt non-subscribers to sign up, place a block using Drupal's standard **Block
layout**:

1. Add your subscribe/marketing block to a region.
2. Under the block's **visibility** settings, choose **Role Paywall** and select the
   entity type it relates to, so the block only appears on content that was actually
   paywalled.
3. It is also worth setting a **Pages** visibility path to scope it further.

## 4. Keep the access-model limits in mind

Remember what was covered on the [overview page](../index.md): in this release the
paywall is enforced at the **render layer** for the *full* view mode only. It hides
the premium fields on the article page, but it does **not** place an access control
on the data itself. Practically, when you configure the paywall:

- **Do not add the paywalled fields to a teaser or listing view mode**, or they will
  render there for everyone — the paywall does not act on those view modes.
- **Be cautious about exposing paywalled entities over JSON:API/REST**, which can
  return the field values in full.
- **Do not rely on this alone for legally or contractually sensitive content** —
  use it as the presentation "wall" and combine it with a proper subscription/access
  mechanism for anything that must be genuinely inaccessible.

## Payments

Role Paywall handles only the wall. To take payment and manage subscriptions and
renewals, pair it with Drupal Commerce (for example Commerce License) and grant the
subscriber role on purchase.

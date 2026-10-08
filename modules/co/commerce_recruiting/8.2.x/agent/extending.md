<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extending Commerce Recruiting

## Bonus-resolver plugin type

A campaign selects how a recruiter's bonus is computed via a
**`commerce_recruiting_bonus_resolver`** plugin (Commerce plugin item field
`recruitment_bonus_resolver`).

- **Annotation**: `@RecruitmentBonusResolver` (`src/Annotation/RecruitmentBonusResolver.php`).
- **Interface**: `RecruitmentBonusResolverInterface` — key method
  `resolveBonus(CampaignOptionInterface $option, OrderItemInterface $order_item): \Drupal\commerce_price\Price|null`.
- **Base class**: `RecruitmentBonusResolverPluginBase` (config form scaffolding).
- **Manager**: `plugin.manager.commerce_recruiting_bonus_resolver`
  (`RecruitmentBonusResolverPluginManager`, parent `default_plugin_manager`).
- **Directory**: `src/Plugin/Commerce/RecruitmentBonusResolver/`.

### Built-in: `DefaultBonusResolver` (id `default_bonus_resolver`)
Reads the campaign option: `fix` → the option `bonus`; `percent` →
`unit_price * bonus_percent / 100`. Config option `bonus_quantity_multiplication` multiplies the
bonus by the order-item quantity. Returns `NULL` when a percentage cannot be computed (missing unit
price), which causes the caller to skip creating a recruitment.

### Writing a resolver
```php
namespace Drupal\my_module\Plugin\Commerce\RecruitmentBonusResolver;

use Drupal\commerce_order\Entity\OrderItemInterface;
use Drupal\commerce_price\Price;
use Drupal\commerce_recruiting\Entity\CampaignOptionInterface;
use Drupal\commerce_recruiting\Plugin\Commerce\RecruitmentBonusResolver\RecruitmentBonusResolverPluginBase;

/**
 * @RecruitmentBonusResolver(
 *   id = "my_tiered_resolver",
 *   label = @Translation("Tiered bonus"),
 *   description = @Translation("Bonus scales with order total."),
 * )
 */
class MyTieredResolver extends RecruitmentBonusResolverPluginBase {

  public function resolveBonus(CampaignOptionInterface $option, OrderItemInterface $order_item) {
    // Derive the amount from admin config + the order item; return a Price or NULL.
    return new Price('10.00', $order_item->getUnitPrice()->getCurrencyCode());
  }
}
```
Compute the amount only from the campaign option and server-side order data — the resolver's return
value becomes the recruiter's bonus, and it is re-invoked at order placement.

## Alter hooks (`commerce_recruiting.api.php`)

- `hook_recruitment_reward_recruitments_alter(array &$recruitments, CampaignInterface $campaign)` —
  alter the set of recruitments added to a reward (invoked in `RewardManager::createReward()`).
- `hook_recruitment_summary_recruitments_alter(array &$recruitments, CampaignInterface $campaign)` —
  alter the recruitments used to build a summary
  (`RecruitmentManager::getRecruitmentSummaryByCampaign()`).

## Events

- `RecruitmentSessionEvent::SESSION_SET_EVENT`
  (`commerce_recruiting_recruitment_session_event`) — dispatched by
  `CampaignManager::saveRecruitmentSession()` after the recruiting session is stored; carries the
  `RecruitmentSessionInterface`. `RecruitmentCheckoutSubscriber` uses it to back-fill order items in
  existing carts.

Standard integration points also fire through Commerce Cart's `CartEvents::CART_ORDER_ITEM_ADD` and
the order `commerce_order.place.post_transition` transition, plus the `state_machine.guard` tag
(group `recruitment`) used by `RecruitmentGuard`.

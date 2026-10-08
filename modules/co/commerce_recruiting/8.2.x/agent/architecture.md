<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Architecture & flow

## The referral lifecycle

1. **Share** — a recruiter shares `/code/{option-code}--{recruiter}`. `recruiter` is the recruiter's
   uid or their personal `code` (User base field). If a user has no custom code, the uid is used.
   `Code` (`src/Code.php`) is the value object; `Code::createFromCode()` splits the string on `--`
   (`X--Y` → option code `X`, recruiter `Y`), and `Code::url()` builds the link.

2. **Capture** — `RecruitmentCodeController::code()` (route `commerce_recruiting.recruitment_url`,
   `_permission: access content`) resolves the option and recruiter via `CampaignManager`, blocks
   self-recruit (unless `allow_self_recruit`), calls `CampaignManager::saveRecruitmentSession()`, then
   redirects to the option's `redirect` link or the option product's canonical page. The page cache is
   killed for this route. Alternatively, if `use_recruitment_code_url_parameter` is on,
   `RequestSubscriber::onRequest()` captures the same code from a `?code=...` query parameter on any
   request.

3. **Session** — `RecruitmentSession` (`@commerce_recruiting.recruitment_session`) stores exactly
   **one** recruiter + one campaign option in the PHP session
   (`commerce_recruitment_rid` / `commerce_recruitment_coid`). A second code overwrites the first —
   one recruiter per order. `CampaignManager::saveRecruitmentSession()` dispatches
   `RecruitmentSessionEvent::SESSION_SET_EVENT`.

4. **Match to cart** — `RecruitmentCheckoutSubscriber` listens to `CART_ORDER_ITEM_ADD` and the
   session-set event. `RecruitmentManager::sessionMatch()` compares session option product(s) against
   cart order items (honouring the campaign's `bonus_any_option` flag), resolves the bonus, and writes
   a **`recruitment_info`** field value (campaign_option, recruiter, number, currency) onto matching
   order items so the attribution survives a new session. Matching works in either order (add product
   first, then hit the link, or vice-versa).

5. **Placement** — on `commerce_order.place.post_transition`,
   `RecruitmentCheckoutSubscriber::onOrderPlace()` walks order items with `recruitment_info`,
   **re-resolves** the bonus from the current campaign option (not the stored number), and creates a
   `commerce_recruitment` per item via `RecruitmentManager::createRecruitment()` (state `created`).
   If no info-based recruitment was created, it checks **auto re-recruit**: if the buyer was recruited
   before in a campaign whose `auto_re_recruit` is on and the order contains a matching campaign
   product, it creates a follow-up recruitment (once per campaign).

6. **Accept** — `hook_cron` → `RecruitmentManager::applyTransitions('accept')` transitions every
   `created` recruitment via the `accept` transition. `RecruitmentGuard` (a `state_machine.guard` in
   group `recruitment`) allows `accepted` only once the linked order has reached `completed`.

7. **Reward** — the recruiter visits `/user/rewards/collect/{campaign}`
   (`RewardController::createReward()`). `RewardManager::createReward()` loads the **current user's**
   `accepted` recruitments for that campaign (`RecruitmentManager::findRecruitmentsByCampaign(...,
   'accepted', $recruiter)`), attaches them to a new `commerce_recruitment_reward`, and
   `Reward::preSave()` sums their bonuses into the reward `price`. Reward + its recruitments start
   `paid_pending`; an admin later transitions them to `paid`.

## Bonus computation

`RecruitmentManager::resolveRecruitmentBonus($option, $order_item)` → the campaign's
`recruitment_bonus_resolver` plugin (see [extending.md](extending.md)). `DefaultBonusResolver`:
- `fix` → the option's `bonus` price.
- `percent` → `unit_price * bonus_percent / 100` in the order-item currency.
- optional `bonus_quantity_multiplication` multiplies by order-item quantity.

All inputs come from the admin-configured campaign option and the order item's own price — no
request-supplied amount is used, and placement re-resolves so a later config change is honoured.

## Services (`commerce_recruiting.services.yml`)

| Service | Class | Role |
|---|---|---|
| `commerce_recruiting.recruitment_manager` | `RecruitmentManager` | create/match/summarise recruitments, resolve bonus, apply transitions |
| `commerce_recruiting.campaign_manager` | `CampaignManager` | resolve option/recruiter from a `Code`, save session, find campaigns |
| `commerce_recruiting.reward_manager` | `RewardManager` | build rewards from accepted recruitments |
| `commerce_recruiting.recruitment_session` | `RecruitmentSession` | one-slot session store |
| `commerce_recruiting.recruitment_checkout_subscriber` | event subscriber | cart/placement → order-item info & recruitment creation |
| `commerce_recruiting.request_subscriber` | event subscriber | `?code=` query-param capture |
| `commerce_recruiting.recruitment_guard` | `RecruitmentGuard` | gate `accepted` on order completion |
| `commerce_recruiting.plugin_item_deriver_subscriber` | event subscriber | derive `commerce_plugin_item` for the resolver field |
| `plugin.manager.commerce_recruiting_bonus_resolver` | plugin manager | bonus-resolver plugins |

## Workflows (`commerce_recruiting.workflows.yml`)

- `recruitment_default` (group `recruitment`, entity `commerce_recruitment`): states `created`,
  `accepted`, `canceled`, `paid_pending`, `paid`; transitions `accept`, `cancel`, `pay_request`, `pay`.
- `reward_default` (group `reward`, entity `commerce_recruitment_reward`): states `paid_pending`,
  `paid`; transition `pay`.

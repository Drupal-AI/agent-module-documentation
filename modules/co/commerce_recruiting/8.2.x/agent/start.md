<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Recruiting — agent index

Referral / affiliate marketing for **Drupal Commerce**. A **recruiter** shares a personalised
link (`/code/{option-code}--{recruiter}`); when a recruited buyer purchases a qualifying product,
a **Recruitment** is recorded on checkout, promoted to *accepted* by cron once the order completes,
and collected into a payable **Reward**. Version **8.2.2**, core `^10 || ^11`, package Commerce.

- **End-to-end flow (link → session → order item → recruitment → reward), services, events, cron, workflows** →
  [architecture.md](architecture.md)
- **Entities, fields, routes, permissions, blocks, and the settings form** →
  [entities-and-config.md](entities-and-config.md)
- **Extending: the bonus-resolver plugin type and the alter hooks** →
  [extending.md](extending.md)

## Key facts

- **Dependencies** (`info.yml`): `commerce_cart`, `commerce_product`, `commerce_promotion`,
  `dynamic_entity_reference` (`^3.0`, the only `composer require`), `state_machine`, `views`.
- **Content entities**: `commerce_recruitment` (a recorded referral), `commerce_recruitment_reward`
  (a redeemable payout), `commerce_recruitment_camp_option` (a product + bonus rule), plus the
  config entity `commerce_recruitment_campaign` (groups options). Managed under
  `/admin/commerce/recruitment`.
- **Referral URL**: `/code/{campaign_code}` where `campaign_code` = `{option-code}--{recruiter-uid-or-code}`
  (`Code::createFromCode()` splits on `--`). Sets a single-slot recruiting **session**, then redirects
  to the option's product (or its configured `redirect`).
- **Bonus is computed server-side** from the campaign option (`bonus_method` = `fix` or `percent`) via
  a **`commerce_recruiting_bonus_resolver`** plugin (`DefaultBonusResolver`), and **re-resolved at order
  placement**. The reward total is summed in `Reward::preSave()`.
- **Workflows** (`state_machine`): `recruitment_default` (created → accepted / canceled →
  paid_pending → paid) and `reward_default` (paid_pending → paid). `RecruitmentGuard` gates the
  `accepted` transition on the order state; cron (`hook_cron`) applies `accept`.
- **Codes** are CSPRNG-generated (`CampaignOption::getDefaultCode()`, `random_int`, 7 chars) with a
  `CodeUnique` constraint; a per-user `code` base field is added to the User entity.
- **Blocks** (logged-in only): FriendBlock (share link on a product page), RecruiterBlock (my campaign
  links), RecruitmentSummaryBlock, RewardsBlock, RecruitmentSessionBlock (debug). Reward/summary data
  is scoped to the current/context user.
- **Permissions**: entity-API generated (`administer recruitment entities`, `administer reward
  entities`, `administer recruitment campaign entities`, `administer recruitment option entities`, plus
  per-op view/update/delete own/any from the `entity` module). No `*.permissions.yml`.
- **Settings** (`commerce_recruiting.settings`, form at `/admin/commerce/config/recruiting/settings`):
  `use_recruitment_code_url_parameter`, `recruitment_code_url_parameter_name` (default `code`,
  lowercase a–z), `write_recruitment_transition_log`.

## Security posture (positive)

The bonus is derived server-side from admin-configured campaign options and re-resolved at order
placement (stored per-item amounts are not trusted); reward totals are summed server-side. Referral
codes are unguessable (CSPRNG) and unique. Self-referral is blocked unless the campaign explicitly
enables `allow_self_recruit`, and reserved campaigns enforce a recruiter allow-list. Rewards and
recruitments are scoped to the owning recruiter — collection acts only on the current user's own
accepted recruitments, and reward pages use the standard entity access handler. Recruitment
acceptance is gated on the order reaching the completed state.

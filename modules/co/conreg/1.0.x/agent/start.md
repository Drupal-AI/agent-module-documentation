<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ConReg — Convention Registration (conreg) — agent index

`name: ConReg - Convention Registration`. Version **1.0.0-beta2**. Core `^11.2 || ^12`.
License GPL-2.0-or-later. **Not** covered by Drupal's security advisory policy.

A membership **registration and management system for conventions/events** (built for SF
conventions). Attendees register — one lead member plus additional group members in a single
form — choosing a **membership type**, optional **day selection**, customisable **field
options/preferences**, and paid **add-ons**. Prices are computed by a pluggable pricing engine,
paid through **Stripe Checkout**, and the resulting members are stored, approved, checked in,
emailed and reported on by organizers. Data lives in **custom database tables** (not entities —
entity migration is a v2 roadmap item), so most storage/logic is in plain services, not the
entity API.

Hard dependencies (`conreg.info.yml`): **`key`**, **`token`**, **`easy_email`**, plus the
**`stripe/stripe-php`** PHP library (Composer; `hook_requirements` blocks install if
`\Stripe\Stripe` is missing). Optional runtime extras (`simplenews`, mailer, navigation tools)
are dev/suggested.

## Solution docs

- **Public registration & the member lifecycle** — the multi-member `Registration` form, member
  data model (`conreg_members`), portal, magic-link login, check-membership, public member list
  → [registration.md](registration.md)
- **Pricing & Stripe payment** — pricing plugin engine, `conreg_payments` flow, `Checkout` form,
  `StripeService` (Key-module keys), reconcile-from-Stripe-events model
  → [payment.md](payment.md)
- **Admin / organizer management** — event config, member management, check-in, fan table, bulk
  & per-member email, mailout export, permissions → [admin.md](admin.md)
- **Submodules** — 9 optional submodules (badges, lookup, mailing-list framework + providers,
  airtable, clickup, discord, planz) → [submodules.md](submodules.md)

## What it provides (from source)

- **Public/member routes** (`conreg.routing.yml`): `members/register/{eid}` (`Form\Registration`,
  perm `convention registration`), `members/checkout/{payid}/{key}` (`Form\Checkout`),
  `members/thanks/{eid}`, `members/list/{eid}` (public list, perm `view public members`),
  `members/check/{eid}` (`Form\CheckMember`), `members/login/{mid}/{key}/{expiry}`
  (`LoginController`, **`_access: TRUE`**), `members/portal/{eid}` + `members/portal/edit/{eid}/{mid}`
  (perm `member portal`), `members/badge/upload/{eid}` (`BadgeUploadController`),
  `members/email-check` (JSON, flood-limited).
- **Admin routes** under `admin/config/conreg/*` (event list/clone/config, member classes, member
  types, add-ons) and `admin/members/*` (manage/add/edit/delete/transfer/email members, bulk email,
  check-in, fan table, mailout + CSV export, options/add-ons/summary reports).
- **~24 permissions** (`conreg.permissions.yml`) + dynamic per-field-option permissions
  (`FieldOptionPermissions::permissions`). Key ones: `convention registration`,
  `view public members`, `member portal`, `configure convention registration`,
  `manage convention members`, `view membership details`, `bulk email sending`,
  `check in convention members`, `fan table registration`.
- **Services** (`conreg.services.yml`, autowired): `StripeService`, `MemberStorage`,
  `EventStorage`, `AddonStorage`, `PaymentStorage`, `UpgradeStorage`, `MemberRepository`,
  `PricingService`, `ConregEmailSender`, `RegistrationConfirmationMailer`, `EmailTokenContext`,
  `MemberPresenter`, `MemberDetailsFormatter`, `CountryService`, and two pricing plugin managers.
- **Plugin types**: `MemberPricingRule` and `PricingAdjustment` (attribute-based, in `src/Pricing/`);
  ships `BaseTypePricingRule`, `AddonPricingRule`, `NthMemberFreeAdjustment`. The
  `conreg_mailing_list` submodule adds a `MailingListProvider` plugin type.
- **Block**: `conreg_price_availability` (`PriceAvailabilityBlock`).
- **Hooks** (OOP `#[Hook]` classes in `src/Hook/`): help, page_attachments, user_login (adds an
  event role to a matching member on login), theme + preprocess (member-type cards, day options),
  token_info/tokens (member/event/login-link tokens), Easy Email field & template-validation hooks.
- **hook_theme** templates: `member-type-cards`, `member-day-options`, badges page, email body.
- **DB tables** (`conreg.install`): `conreg_events`, `conreg_members`, `conreg_upgrades`,
  `conreg_payments`, `conreg_payment_sessions`, `conreg_payment_lines`, `conreg_member_options`.
  On install a default open event is auto-created.
- **API** (`conreg.api.php`): `hook_convention_member_added|updated|deleted($member)`.
- **Config schema**: `conreg.settings.*` (per-event settings, keyed by event id), plus block
  settings and a planz submodule schema.

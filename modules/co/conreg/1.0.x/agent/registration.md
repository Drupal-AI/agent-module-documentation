<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Registration & member lifecycle

## Registration form
`Form\Registration` (`members/register/{eid}`, perm `convention registration`; the same form also
serves `members/portal/register/{eid}` and admin `admin/members/fantable/register/{eid}`). One
submission registers a **group**: a lead member plus any number of additional members. Each member
picks a **member type**, optionally **days** (`MemberDayOptions` element / `member-day-options`
template), a **badge name** and public-display choice (`F` full name / `B` badge name / `N`
withheld), plus configurable **field options** (`FieldOptions`/`FieldOption`, stored in
`conreg_member_options`) and **add-ons** (`Addons`). AJAX recomputes the running price as choices
change. On submit the members are written to `conreg_members` and a `conreg_payments` record (+
`conreg_payment_lines`) is created; the user is redirected to `Checkout` (see
[payment.md](payment.md)). The as-you-type email uniqueness check calls
`EmailCheckController::check` (`members/email-check`, JSON, flood-limited to 120 lookups/60s per
uid-or-IP).

## Member data model (`conreg_members`)
Custom table (not an entity). Columns include `mid`, `eid`, `lead_mid` (group link), `random_key`
(secures payment/login URLs), `member_no` (assigned on approval), `member_type`, `days`,
`communication_method` (E/P/B), `is_approved`, `first_name`/`last_name`/`badge_name`/`badge_type`,
`display`, `email`, full postal address + `country` (ISO-2) + `phone`, `birth_date`/`age`,
`is_volunteer`, `member_price`/`member_total`/`add_on_price`, `is_paid`/`payment_method`/
`payment_amount`/`payment_id`, `comment`, `join_date`/`update_date`, check-in fields
(`is_checked_in`/`check_in_date`/`check_in_by`), `login_exp_date`, `is_deleted` (soft delete).
`Member` (`src/Member.php`) is the row wrapper (`loadMember`, `loadMemberByEmail`, `saveMember`);
`MemberStorage`/`MemberRepository` are the query services (all reads use bound `->condition()`
parameters). `MemberPresenter`/`MemberDetailsFormatter` format members for display and email tokens.

## Member portal
`Form\MemberPortal` (`members/portal/{eid}`, perm `member portal`) lists the logged-in user's group
members and links to `Form\MemberEdit` (`members/portal/edit/{eid}/{mid}`) for self-service edits
and to outstanding-payment checkout. Portal/edit list cells are escaped with `Html::escape()`.

## Magic-link login
`LoginController::memberLoginAndRedirect` (`members/login/{mid}/{key}/{expiry}`, `_access: TRUE`).
Loads the member by `mid` + `random_key` (`key`) + `login_exp_date` (`expiry`), rejecting expired
links; if a Drupal user with the member's email exists it logs them in, otherwise it creates and
activates one, then redirects to the portal. Login links (and their `random_key`/`login_exp_date`)
are generated and mailed via `MemberPresenter` and the `[conreg:member:login-link]` token family
(`ConregTokenHooks`). `hook_user_login` (`conreg.module`) additionally grants the event's
configured `member_portal.add_role` to a logging-in user who matches a member.

## Check membership & public list
- `Form\CheckMember` (`members/check/{eid}`, perm `check membership`) lets a user confirm they are
  registered and request a fresh login link.
- `ConregController::memberList` (`members/list/{eid}`, perm `view public members`) renders opted-in
  members (respecting each member's `display` choice) as a `#type => table` with a country
  breakdown. Both permissions have no role by default — grant them for a public convention.

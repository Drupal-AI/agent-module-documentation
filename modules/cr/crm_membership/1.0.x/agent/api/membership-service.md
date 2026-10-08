<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CRM Membership — service & extension API

## MembershipService (`crm_membership.service`)
Autowired; also aliased to the class name for type-hinted injection.

- `isMember(Contact $contact, Contact $target): bool` — TRUE if `$contact` is an active member
  of `$target`. Checks direct memberships (status active + term-plugin `isActiveFor()`), then
  indirect memberships via the target, then dispatches `MembershipEvents::IS_MEMBER` for custom logic.
- `getMemberships(Contact $contact): array` — active memberships where the contact is a member.
- `getMembershipsForTarget(Contact $target): array` — active memberships whose target is `$target`.

These methods run entity queries with `accessCheck(FALSE)` (internal membership computation);
callers are responsible for access when surfacing results.

## Event: `MembershipEvents::IS_MEMBER`
Dispatched with a `MembershipIsMemberEvent($contact, $target)`. Subscribers may call
`setIsMember(TRUE)` to declare membership through custom relationships (e.g. households).
Default answer is FALSE unless a direct/indirect membership matched earlier.

## Writing a MembershipTerm plugin
Extend `MembershipTermBase` and annotate with the `#[MembershipTerm(...)]` attribute
(id, label, and flags such as `allowOverrideStartDate`, `allowOverrideEndDate`, `timeGapKey`).
Key overridable methods: `buildConfigurationForm()`, `saveConfiguration()`, `isActiveFor()`,
`expire()`, `cancel()`, `allowRenewal()`. Use `addMembershipPeriod()` and
`calculateNextEndDate()` helpers from the base class. Register nothing extra — the
`plugin.manager.crm_membership_term` manager discovers attributed classes automatically.

## Membership entity accessors
`getContacts()/addContact()`, `getTargetContact()/setTargetContact()`,
`getMembershipStatus()/setMembershipStatus()`, `getCurrentPeriods()`,
`getCurrentPeriodsForContact()`, `isActiveFor(Contact)`, `getMembershipTerm()`.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Membership - agent index

Framework for site memberships: revisionable `membership` content entity + `membership_type` config
bundles, each driven by a `@MembershipProvider` plugin. Hard deps: `state_machine`, `entity`, `commerce`.

Key pieces:
- Entities: `src/Entity/Membership.php`, `MembershipType.php` (+ interfaces).
- Provider plugins: `src/Plugin/MembershipProvider/ManualOnsite.php`, `*ProviderBase`, capability interfaces
  (`SupportsCreation*`, `SupportsCancellation*`, `Configurable*`); manager `plugin.manager.membership_provider`.
- Access: `src/MembershipAccessControlHandler.php` - `createAccess()` checks provider supports creation, then
  delegates to Entity-API per-bundle permissions.
- Service `membership.repository` (`MembershipRepository`). `MembershipEntityController::addPage()` filters
  add-links / redirects to off-site creation.

Payments are delegated to Commerce; module has no gateway code. Version dir `2.0.x`.

<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple OAuth Claims maps user fields to configurable OIDC/private JWT claims for Simple OAuth.

---

Simple OAuth Claims provides a 'Claim' config entity (managed at `/admin/structure/claims`, `administer claims` permission) that maps a user field to a named claim of type OIDC, private, or undetermined. It implements `hook_simple_oauth_private_claims_alter` and `hook_simple_oauth_oidc_claims_alter` to add the enabled claims (converted per field type) to access tokens and OpenID Connect responses, and registers OIDC claim names via a service provider. Depends on Simple OAuth. Note: enabled claims are added for the token's user regardless of client or requested scope — an admin who maps a sensitive field exposes it to every client, so configure claims carefully.

---

- Add custom claims to Simple OAuth tokens.
- Map a user field to an OIDC claim.
- Map a user field to a private JWT claim.
- Manage claims as config entities.
- Enable/disable individual claims.
- Convert field values by type for claims.
- Expose profile data to OAuth clients.
- Register OIDC claim names for discovery.
- Populate the iss claim when requested.
- Administer claims behind a permission.
- Integrate with the simple_oauth provider.
- Extend tokens without custom code.
- Support Drupal 9.3 and 10.
- Rebuild the container when claims change.
- Choose claim availability (OIDC vs private).
- Drive claims from user field data.

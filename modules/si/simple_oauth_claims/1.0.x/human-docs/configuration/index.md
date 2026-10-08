# Configuration

Simple OAuth Claims does nothing until you create at least one **Claim**. Claims
are configuration entities you manage entirely in the admin UI.

## Open the Claims listing

1. Log in as a user with the **Administer claims** permission (an administrator
   by default).
2. Go to **Manage → Structure → Claims**, or navigate directly to
   `/admin/structure/claims`.

You'll land on the **Claims** collection page. It lists every claim you have
created, shows whether each is enabled, and gives you links to add, edit, and
delete claims.

## Add a claim

Click **Add claim** and fill in the form. Each claim maps one user field to one
named claim:

- **The user field** — pick which field on the user account supplies the value.
  This can be a built-in field or any custom field you have added to user
  accounts. The module converts the field's value to a claim value according to
  the field's type.
- **The claim name** — the name the value appears under in the token or OIDC
  response (for example `given_name` or `department`). Clients read the claim by
  this name, so choose something they expect or something you have agreed on.
- **The claim type** — where the claim is made available:
  - **OIDC** — the claim is returned from the OpenID Connect endpoints, and its
    name is registered so it can be advertised in OIDC discovery.
  - **Private** — the claim is embedded as a private claim inside the JWT access
    token itself.
  - **Undetermined** — left unspecified if you don't need to pin it to one
    channel.
- **Enabled** — a toggle so you can turn an individual claim on or off without
  deleting it. Only enabled claims are injected into tokens.

Save the form and the claim appears on the listing.

## What happens after you save

When you add, change, or remove claims, Drupal rebuilds its service container so
that any new OIDC claim names are registered for discovery. This is part of a
normal cache rebuild — if a newly added OIDC claim doesn't appear in discovery
straight away, clear caches (`drush cr`) and check again.

From then on, every token Simple OAuth issues carries the enabled claims for
whichever user the token belongs to.

## The important caveat, restated

Enabled claims are added for the token's user **regardless of which client asked
for the token or what scope was granted**. There is no per-client or per-scope
filtering here. So:

- Only map fields you are comfortable exposing to **every** OAuth client.
- Treat any sensitive user field (personal data, internal identifiers, private
  notes) with care — mapping it to a claim makes it broadly visible.
- Review your enabled claims periodically, and disable any you no longer need.

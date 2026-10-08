# Recurring Events Registration — permissions

Source: `recurring_events_registration.permissions.yml`; enforced by
`src/RegistrantAccessControlHandler.php`.

## Registrant entity
`view registrant entities`, `add registrant entities`, `edit registrant entities`,
`edit own registrant entities`, `delete registrant entities`, `delete own registrant entities`,
`edit registrant entities anonymously`, `delete registrant entities anonymously`,
`modify registrant waitlist`, `modify registrant author`, `resend registrant emails`,
`contact registrants`, `access registrant overview`.
- `administer any registrant` — **restrict access: true** (create/update/delete any registrant;
  short-circuits the access handler to allow everything).
- `administer registrant entity` — **restrict access: true** (settings form).
- `administer registrant types` — **restrict access: true**.

## Anonymous UUID access (edit/delete without login)
`edit/delete registrant entities anonymously` are NOT `restrict access: true` — they are meant to be
grantable to the anonymous role so guests can manage their own RSVP. They are safe because
`checkAnonymousAccess()` gates them tightly:
1. The registrant must be owned by anonymous (`getOwnerId() === '0'`) — else forbidden.
2. The URL `{uuid}` must be a valid UUID **and exactly equal** to `$registrant->uuid->value`.
3. Only then is the `anonymous` permission checked.
The registrant's UUID is a random v4 value delivered only in the confirmation email link, so it acts as
an unguessable capability token. Not a security finding.

## Waitlist / author overrides
`modify registrant waitlist` and `modify registrant author` let a role set/override those fields on a
registrant (used on the registrant form); grant to staff roles that manage registrations.

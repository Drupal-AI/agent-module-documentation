# Protocol endpoints, tickets, and events

All routes below are `_access: 'TRUE'` (the protocol itself is public; authorization is via
credentials, tickets, and service matching). Must run over HTTPS.

## Endpoints (from `cas_server.routing.yml`)
| Route / path | Controller | Purpose |
|---|---|---|
| `cas_server.login` `/cas/login` | `UserActionController::login` | Show login form / issue a service ticket and redirect back to `service`. Honors `gateway` and `renew`. |
| `cas_server.logout` `/cas/logout` | `UserActionController::logout` | Destroy the CAS session + all tickets for the session, clear `cas_tgc`, then (if `service=` present) redirect to it. |
| `cas_server.validate1` `/cas/validate` | `TicketValidationController::validate` (type 0) | CAS 1.0 plain-text ST validation (`yes\n<user>` / `no`). |
| `cas_server.validate2` `/cas/serviceValidate` | type 1 | CAS 2.0 ST validation (XML/JSON, attributes, optional `pgtUrl`). |
| `cas_server.proxy_validate2` `/cas/proxyValidate` | type 2 | CAS 2.0 proxy-ticket validation. |
| `cas_server.validate3` `/cas/p3/serviceValidate` | type 3 | CAS 3.0 ST validation. |
| `cas_server.proxy_validate3` `/cas/p3/proxyValidate` | type 4 | CAS 3.0 proxy-ticket validation. |
| `cas_server.proxy` `/cas/proxy` | `ProxyController::proxy` | Exchange a proxy-granting ticket (`pgt`) + `targetService` for a proxy ticket. |

## Login flow (`/cas/login?service=<url>`)
1. Anonymous → `UserLogin` form. Validates username/password (via `UserAuthInterface`), the service URL
   (`ConfigHelper::loadServiceFromUri`), and `accountPermitted()`.
2. On success a single-use **service ticket** (`ST-…`) is created for the service and the user is
   redirected to `service?ticket=ST-…` (core `TrustedRedirectResponse`, only after the service matched).
3. `renew=true` forces credential re-entry (ST marked `renew`); `gateway=true` redirects an
   unauthenticated user straight back without prompting.
4. With SSO (`ticket.ticket_granting_ticket_auth` + service `sso`), a returning user with a valid
   `cas_tgc` gets a new ST without re-entering credentials.

## Validation flow (`/cas/serviceValidate?ticket=ST-…&service=<url>`)
`TicketValidationController::validate()` loads the ticket, and fails (protocol-specific error) unless:
ticket exists and is the right type, not expired, and `service` **exactly equals** the ticket's stored
service string. On success the ST is deleted (single use) and the username + released attributes are
returned. `format=JSON` switches XML→JSON. `renew=true` requires the ticket came from a direct login.

`pgtUrl=` triggers `proxyCallback()`: the URL must be `https` and pass TLS verification, then the server
GETs it with `pgtIou`/`pgtId` to hand over a proxy-granting ticket.

## Ticket types (`src/Ticket/*`, table `cas_server_ticket_store`)
`LoginTicket` (LT), `ServiceTicket` (ST), `ProxyTicket` (PT), `ProxyGrantingTicket` (PGT),
`TicketGrantingTicket` (TGT). All IDs are `Crypt::randomBytesBase64(32)` (256-bit CSPRNG) with a type
prefix. Created by `TicketFactory`, stored by `DatabaseTicketStorage`, purged on cron
(`cas_server_cron`). Proxy chains are stored serialized and read back with
`unserialize(..., ['allowed_classes' => FALSE])`.

## Events (alter hooks for other modules)
- `CasServerTicketAlterEvent` (`CasServerTicketAlterEvent::CAS_SERVER_TICKET_ALTER_EVENT`) — dispatched
  by `TicketFactory` for every ticket it creates; subscribe to inspect/alter the ticket object.
- `CASAttributesAlterEvent` (`CASAttributesAlterEvent::CAS_ATTRIBUTES_ALTER_EVENT`) — dispatched in
  `generateSuccessResponse()` with the user account, ticket, and attributes array; subscribe with
  `->getAttributes()` / `->setAttributes()` to add or transform released attributes. This is what the
  `cass_attributes` submodule demonstrates.

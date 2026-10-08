<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ActiveTickets Client provides an injectable SOAP client service for the ACTIVE Network ActiveTickets ticketing/events web service.

---

ActiveTickets Client is a thin developer integration layer around the ActiveTickets SOAP/WSDL API. It
registers one client service (`activetickets_client.client`) plus a member-scoped variant
(`activetickets_client.member_client`), each wrapping a `\SoapClient` built from admin-configured WSDL
URLs. Through the service you call typed methods that map to ActiveTickets SOAP operations — program
(event/show) listings and details, genres, subgenres, locations, characteristics, routes, passes, and a
large set of visitor (customer) read/write operations. Every call returns a PHP array parsed from the
service's XML response. The module ships only a settings form (client name, language code, WSDL URLs,
ticket URL, API token) at `/admin/config/system/activetickets_client`; it adds no entities, blocks,
permissions, routes or Drush commands of its own, so you build the actual site behaviour in your own code.
It requires the `ext-soap` PHP extension and an ActiveTickets account/token.

---

- Inject `activetickets_client.client` into a custom service or controller to talk to ActiveTickets.
- List the current program/event schedule between two dates with `getProgramList($from, $to, $genreId)`.
- Cache a program list in the default cache bin via `getCachedProgramList($from, $to, $genreId)`.
- Pull a large program listing (`getProgramListBig`) or a lightweight one (`getProgramListLight`).
- Fetch programs with seat capacities and sold counts (`getProgramListWithCapacitiesAndSold`).
- Retrieve full detail for one event with `getProgramDetail($programId)`.
- Get a program's current status or pre-sale window (`getProgramStatus`, `getProgramPresale`).
- Enumerate genres, subgenres, locations and characteristics for building filters and navigation.
- Map subgenres to program IDs and back (`getProgramIdsViaSubgenresList`, `getSubgenresViaProgramList`).
- List deleted/inactivated programs to keep a local mirror in sync (`getProgramDeletedAndinActives`).
- Read visitor (customer) records by ID or email (`getVisitor`, `getVisitorByEmail`, `getVisitorBig`).
- Authenticate a visitor against ActiveTickets by email + password (`getVisitorByCredentials`).
- Create, update or delete visitor accounts (`setVisitorNew`, `setVisitorUpdate`, `setVisitorDelete`).
- Fetch a visitor's order history (`getVisitorOrderHistory`).
- Find visitor IDs who ordered in the last 48 hours or last N minutes (capped at 1440).
- Manage visitor interests and characteristics (add/remove/list).
- Toggle a visitor's newsletter subscription by email (`setVisitorNewsLetterByEmail`).
- Obtain a web-service login key for single sign-on style flows (`getVisitorWebserviceLoginKey`).
- List passes and a visitor's passes (`getPassList`, `getVisitorPassesList`).
- List event routes and routes-with-shows for touring/route-based programming.
- Drive scheduled imports (cron/queue in your own code) of ActiveTickets events into Drupal content.

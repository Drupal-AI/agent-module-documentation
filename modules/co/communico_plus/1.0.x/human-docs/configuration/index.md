# Configuration

Configuring Communico Plus is a short sequence: connect to the Communico API,
build the filter options, run an import, and place the events block.

## 1. Enter your API credentials

1. Log in as a user with the **administer communico_plus** permission.
2. Go to the API configuration form at **`/admin/config/communico_plus/api`**
   (in some releases this is `/admin/config/communico_plus/config`).
3. Fill in:
   - **API URL** — the Communico v3 API base URL for your environment.
   - **Link URL** — the public URL used when building links back to Communico.
   - **Access key** — your Communico API access key.
   - **Secret key** — your Communico API secret key.

   The connector uses the key/secret to request an OAuth client‑credentials token
   (Basic auth) from Communico, and caches it until it expires.
4. **Tick "Rebuild the filter block select element values" and save.** This step
   is required to populate the library‑locations dropdown used by the filter
   block.

## 2. Run an import

Go to the import form at **`/admin/config/communico_plus/import`** and trigger an
import. Imports are **queue‑driven**: one queue creates/updates `event_page`
nodes and another removes stale ones. Process the queues via **cron** or through
the **Queue UI**. You can import one month of events, from the present through the
end of the following month. A cron job automatically unpublishes event nodes once
their event has ended.

## 3. Place the events block

Place one of the module's blocks via **Structure → Block layout**:

- a configurable **events feed** block, or
- a filterable **"wall"** events display.

An optional **calendar** view can be enabled/toggled, built from the imported
event nodes. Single events render at `/event/{eventId}`.

## Credentials and transport

- Prefer supplying secrets through an environment variable and referencing them
  via a Key where possible, and keep the exported config out of public
  repositories:

  ```bash
  ddev dotenv set .ddev/.env --communico-secret-key=<value>
  ddev restart
  ```

- Serve the site over **HTTPS**.

## For developers

The `communico_plus.connector` service exposes methods such as `getEvent`,
`getEventsFeed`/`getFeed` (feed data is cached for 5 minutes), `getReservation`,
`getAllReservations`, `getAllRoomNames`, `getLibraryLocations`, `getEventTypes`,
and `getEventAgeGroups` for custom integrations.

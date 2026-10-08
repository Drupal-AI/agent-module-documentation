# Configuration

Setting up Moodle Sync happens in two places: **in Moodle** (enable web services,
create a service and a token, and authorise the functions the module calls) and
**in Drupal** (paste the token, set the safety site path, and map the fields you
want synced).

## Step 1 — configure Moodle

In your Moodle site:

1. **Enable web services** (Admin → Advanced features, or
   `/admin/search.php?query=enablewebservices`).
2. **Enable the REST protocol**
   (`/admin/settings.php?section=webserviceprotocols`).
3. **Add an external service** (`/admin/settings.php?section=externalservices`)
   with short name `moodle_sync`, **Enabled = true**, and **Authorized users only
   = true**.
4. **Authorise a user** for that service (a system admin or any account with
   sufficient permissions).
5. **Create a token** for that user and service
   (`/admin/webservice/tokens.php`) — you'll paste this into Drupal.
6. **Add the required functions** to the service. Add the functions matching the
   submodules you enabled, for example: `core_course_create_courses`,
   `core_course_update_courses`, `core_course_get_courses_by_field`,
   `core_course_create_categories`, `core_course_get_categories`,
   `core_user_create_users`, `core_user_update_users`,
   `core_user_get_users_by_field`, `core_enrol_get_enrolled_users`,
   `enrol_manual_enrol_users`, `enrol_manual_unenrol_users`, and the
   `core_cohort_*` functions (only if you use `moodle_sync_cohorts`). The
   module's project page lists the full set; add the ones your enabled submodules
   need.

## Step 2 — configure Drupal

Go to **Configuration → Moodle Sync → Settings**
(`/admin/config/moodle_sync/settings`) and set:

- **Moodle URL** — the base URL of your Moodle site. Use **HTTPS** so the token
  and data are encrypted in transit.
- **Web-service token** — paste the token you created in Moodle. This is a
  **secret**: it grants API access to your Moodle site. Prefer supplying it from
  an environment variable or the **[Key](https://www.drupal.org/project/key)**
  module rather than typing it where it lands in exported configuration. With
  DDEV you can store it with
  `ddev dotenv set .ddev/.env --moodle-sync-token=<value>` (restart DDEV
  afterwards) and reference it via a Key entity or environment lookup.
- **Current Drupal path (safety setting)** — a **required** safety measure: enter
  this site's path. The module refuses to write to Moodle unless the running
  site's path matches this value, so if the database is copied to another site
  (for example a test clone) it will **stop syncing** rather than overwrite your
  live Moodle data. Set it deliberately for each environment.
- **Field mappings** — for courses and users you can configure which Drupal
  fields map to which Moodle fields, beyond the always-synced `idnumber` /
  `field_moodle_id` pair. (Categories always sync `field_description` to the
  Moodle category description.)

## How the sync behaves (good to know)

- On **create**, the matching Moodle component is created and its Moodle ID is
  written back to the entity's `field_moodle_id`.
- On **update**, the module finds the Moodle component via `field_moodle_id`; if
  it's empty, it tries to create a new one.
- To **stop a single entity from syncing**, put an invalid value such as
  `ignore` into its `field_moodle_id`.

## After changing configuration

Save the form, then create or edit a test entity and confirm the corresponding
component appears/updates in Moodle. Watch **Reports → Recent log messages** for
any web-service errors (for example a missing authorised function).

## Privacy

This exchanges user and enrolment data (PII) with Moodle. Keep the token secret,
use HTTPS, and handle the personal data in line with your privacy obligations.

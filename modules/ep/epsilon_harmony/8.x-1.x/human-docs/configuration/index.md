# Configuration

Configuring Epsilon Harmony is chiefly about giving Drupal your Harmony **API account
credentials** so it can authenticate, mapping your Epsilon list and message IDs to friendly
names, and knowing where the debug logs live. All admin pages sit under **Configuration →
Epsilon Harmony** (`/admin/config/epsilon_harmony`).

## Enter the connection details

Open **Configurations** (`/admin/config/epsilon_harmony/configurations`) and fill in the account
credentials Epsilon issued you:

- **Client ID**
- **Secret Key**
- **Username**
- **Password**
- **X-OUID**
- **Region** — choose **US** or **Canada**; this selects which Epsilon API base URLs the module
  talks to.

All fields are required — the module will not make an API call until every connection field is
set. The values are saved into the module's own configuration (`epsilon_harmony.settings`).
Because they are stored in configuration, keep the site's exported configuration out of any
public repository, and grant the *Administer Epsilon Harmony* permission only to trusted roles.

## Map your list and message IDs

- **List configurations** (`/admin/config/epsilon_harmony/list_configuration`) — add one or more
  rows pairing a friendly **List Identifier** with the **List ID** Epsilon gave you. Your
  integration code then refers to the list by its friendly identifier. Use **Add another list
  ID** to add more rows before saving.
- **Message configurations** (`/admin/config/epsilon_harmony/message_configuration`) — same idea
  for real-time messages: pair a **Message Identifier** with the **Message ID** from the Epsilon
  team. `sendMessage()` uses these identifiers.

## Test the connection

Use the **Test** link (`/admin/config/epsilon_harmony/test`). It performs a live token request
with your credentials and redirects you to the log listing, where you can confirm the call
succeeded before relying on the integration.

## The debug log

Every request the module sends to Harmony and every response it receives is **logged to the
database** and listed at **Logs** (`/admin/config/epsilon_harmony/logs`); open any row to see the
full detail. Because these records capture what was exchanged with Epsilon, treat access to the
log pages as sensitive: grant *View epsilon logs* only to roles that need it, and clear old logs
with the **Clear logs** action (`/admin/config/epsilon_harmony/logs/clear`) as part of routine
housekeeping.

## Data-handling note

The data you push through this module — profile records and real-time messages — **leaves your
site for Epsilon's platform**. Disclose this egress in your privacy policy and make sure your
data-processing agreements cover it.

## Control who can use it

At **People → Permissions** (`/admin/people/permissions`) the module provides two permissions:
**Administer Epsilon Harmony** (configure the integration, clear logs) and **View epsilon logs**.
Grant them only to the roles that should manage the integration or inspect its logs.

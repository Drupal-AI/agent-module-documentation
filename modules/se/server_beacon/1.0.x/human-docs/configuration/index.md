# Configuration

Configuring Server Beacon means building the reports it will transmit and making
sure they can reach — and be understood by — your reporting station.

## Store the station credentials in the Key module

Before building a report, set up the credential the module will use to
authenticate with the reporting station. Server Beacon relies on the **Key**
module for this, so create a Key entity holding the station credential (for
example an environment-variable-backed key), rather than pasting a secret into
plain configuration. This keeps the credential out of your exported config.

## Build and manage reports

1. Go to **`/admin/config/services/server-beacon`** (or follow the **Server
   Beacon Reports** link on the admin web-services page).
2. **Add a report.** A report defines what server information is gathered and
   transmitted. The available information includes:
   - **PHP, web-server, and Linux versions.**
   - **PHP Composer audits**, when Composer is available on the server.
   - **Drupal module update information**, via core's Update Manager module.
   - Additional data if other plugins are installed to extend the report set.
3. **Match the transmitter protocols to the receiver.** This is the step most
   worth double-checking: the protocols your report transmits with must match the
   receiving configuration on the target report station, or the station will not
   accept the beacon.
4. Save the report. Edit or add further reports from the same screen.

## Keep the egress trusted

Remember that everything a report contains — versions, audit results, update
status — leaves your site and lands on the station. Send beacons only to a station
you control or trust, keep the connection over HTTPS, and hold the station
credential in the Key module.

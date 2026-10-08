# Configuration

Scan code - Barcode is configured on its own settings page (route
`scan_code.admin_config`), and the scan capability is then added to the text
fields where you want barcode entry.

## Settings page

Open the module's configuration page (route `scan_code.admin_config`) to adjust
the scanning behaviour. Access is controlled by the permissions the module
provides, so grant them to the roles that should manage scanning.

## Adding scanning to a field

The module extends the standard text form widget, so barcode scanning becomes
available on text fields you enable it for. When an editor works on such a field,
a scan option appears: they start the scan, the browser asks for camera
permission the first time, they point the camera at a barcode (or provide an
image), and the decoded value is written into the field automatically.

## Keep the input safe

A scanned value is user‑supplied input, exactly like text an editor types. Treat
it the same way — validate and escape it wherever you display or process it, and
apply the appropriate field validation so only well‑formed values are accepted.
The module has no access‑control role of its own beyond the permission that gates
its settings.

# Configuration

The upstream documentation for this module is sparse, so this page describes the
setup in general terms — confirm the exact field names and location against your
installed release.

## Read this first: what an age gate can and cannot do

Before you configure anything, be clear about the security model. AB Age Gate is
a **cookie-based, client-side compliance measure — not access control.** It
remembers a "confirmed" flag (typically a cookie) and can be bypassed by anyone
who clears or sets that cookie, or who requests resources directly. Use it to
satisfy a legal or UX requirement to ask visitors to confirm their age — and
**never** as the thing that protects restricted content or files. Anything that
genuinely must be restricted needs real access control (permissions, private
file handling, and so on).

## Configure the gate

After enabling the module, open its settings under **Configuration** and set up:

- **Appearance** — the look and wording of the age-gate splash: the prompt shown
  to visitors, and whether they confirm with a simple yes/no or by entering a
  birthdate.
- **Logging** — whether confirmations are recorded. Records can be exported (the
  module uses CSV Serialization and Views Data Export for this), which is useful
  for demonstrating that the compliance prompt was shown.

Save the settings and load the site as an anonymous visitor to see the gate. Once
you confirm, the cookie is set and the gate steps aside on subsequent visits.

## A note on logged data

If you enable logging and export, remember that confirmation records may count
as personal data depending on what you capture (for example a birthdate).
Collect only what you need, protect the export, and keep it in line with your
privacy obligations.

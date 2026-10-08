# Aadhaar Number Widget — manual setup guide

**Aadhaar Number Widget** (`aadhaar_number_widget`) provides a field widget for
entering an Indian **Aadhaar number**. When someone types a number, the widget
checks that it is a well-formed 12-digit Aadhaar with a correct **Verhoeff
checksum** — the official Aadhaar check digit — so that structurally invalid
numbers are rejected at entry rather than stored. It depends on core's **Text**
module and applies as a widget to text fields.

The validation is the easy part, and the module does it correctly. The part that
matters far more is **how you handle the data**, and this is not optional:
an Aadhaar number is highly sensitive, legally regulated personal data under
India's UIDAI rules and the DPDP Act. The bare widget validates the format —
it does **not** encrypt, mask, or restrict access on its own. Collecting Aadhaar
numbers without those protections in place is a serious compliance and security
risk.

If you collect Aadhaar numbers, you should:

- **Encrypt the value at rest** (for example with the Encrypt / Field Encrypt
  modules).
- **Restrict field access** to a very small number of roles (for example with
  the Field Permissions module).
- **Mask it in display** — show only the last four digits.
- **Avoid logging or exporting it**, and keep it out of ordinary reports.
- **Prefer storing a reference or token** rather than the raw number, wherever
  your process allows, and only store it at all where you have a lawful basis.

There is no settings form, no permissions, and no Drush commands — you enable
the module and choose the widget on a field, then add the encryption and access
protections yourself.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Add a **text** field to the relevant entity, or use an existing one, via
   **Manage fields**.
3. On **Manage form display**, set that field's **Widget** to the Aadhaar
   Number widget and save. Entered values are now validated for the 12-digit
   format and Verhoeff checksum.
4. **Before collecting any real data**, apply the protections above — encryption
   at rest, tightly restricted field access, and masked display. The widget's
   validation does not make the field safe to store on its own.

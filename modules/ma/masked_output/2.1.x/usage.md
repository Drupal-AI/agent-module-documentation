<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Masked Output allows fields to display as masked strings like ******9845.

---

Masked Output **displays field values as masked strings** — showing only part of a value (e.g. `******9845`)
in the rendered output for privacy/shoulder-surfing reasons. It depends on core User and provides its own
permissions.

Use it to visually mask sensitive-looking fields (partial card/account numbers, etc.). Understand its scope
precisely: this is **display-only masking**. The **real, unmasked value is unchanged** in the database, in the
entity/Field API, in Views/JSON:API/REST output, and in exports — masking happens only in the specific rendered
formatter. So it is a **UI convenience, not a data-access control**: anyone with access to the field's data through
any other path (API, another display, the edit form, the database) sees the true value. Do not use it as the
protection for genuinely sensitive data — for that, use field-level access control, encryption, or not storing the
data. Configure the masked formatter.

---

- Display field values masked (******9845).
- Show only part of a value.
- Reduce shoulder-surfing exposure.
- Depend on core User + provide permissions.
- Serve content display.
- Mask the rendered output.
- MASK display only (real value unchanged).
- LEAVE the true value in DB/entity API/JSON:API/exports/edit form.
- BE a UI convenience, NOT a data-access control.
- Not be relied on to protect sensitive data (use field access/encryption instead).
- Configure the masked formatter.
- Handle masked display.
- Mask fields.
- Configure the formatter.
- Display masks.
- Handle the masking.
- Hide values visually.
- Configure display.
- Handle the output.
- Mask output.
- Provide masked display.

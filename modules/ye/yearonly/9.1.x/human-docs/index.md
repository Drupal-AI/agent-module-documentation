# Year Only — manual setup guide

**Year Only** (`yearonly`) provides a field type that collects and stores just a
year — no month, no day, no time. Editors see it as a simple **Select Year**
dropdown, and the value is saved as a single integer, so it sorts and filters
cleanly in Views.

It is handy any time a full date would be overkill: a person's birth year, a
vehicle's model year, a company's founding year, the release year of a book or
film, a copyright year, or a graduation year. Because the value is a plain
integer, downstream reporting and filtering stay simple.

Each field defines its own valid **range** with two settings. The start year
(`yearonly_from`) is a plain number like `1900`. The end year (`yearonly_to`)
can be a specific year like `2030`, the literal word `now` for the current year,
or a PHP relative expression like `+5 years` or `-1 year` — so a "target year"
field can float forward automatically without you editing it each January. The
dropdown can list years ascending or descending.

Year Only has no admin settings page and adds no permissions — everything is
configured on the field itself through the standard Field UI. It also ships a
Feeds target so a year‑only field can be populated during a Feeds import, if the
Feeds module is installed.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Year Only has **no configuration page of its own**. You add and configure a
Year Only field wherever you manage fields — for example **Structure → Content
types → (your type) → Manage fields** (`/admin/structure/types`).

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Go to the entity you want to add the field to — for a content type, that is
   **Structure → Content types → (your type) → Manage fields → Add field**.
3. Choose the **Year Only** field type and give it a label (e.g. *Founded year*).
4. On the field settings, set the range:
   - **Start year** (`yearonly_from`) — a plain number, e.g. `1900`.
   - **End year** (`yearonly_to`) — a specific year (`2030`), `now` for the
     current year, or a relative expression (`+5 years`, `-1 year`). The start
     year must resolve to less than the end year, or you'll get a validation
     error.
5. Save. The field now appears on the content form as a **Select Year**
   dropdown.
6. (Optional) Under **Manage form display** you can set the widget's sort order
   to **ascending** (default, oldest first) or **descending** (newest first) —
   handy for things like a "purchase year" where recent years are picked most
   often.
7. Under **Manage display**, the default **Year only** formatter prints the plain
   year on the rendered page.

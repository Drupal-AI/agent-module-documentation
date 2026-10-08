# Configuration

Once the module is enabled, the setup work happens in the Commerce BAT settings
area plus your product‑variation form displays. Here is the recommended order.

## 1. Open the settings overview

Go to **Administration → Commerce → Configuration → BAT / Availability**
(`/admin/commerce/config/commerce-bat`). This overview is where you connect your
variation types to BAT booking behaviour.

## 2. Map variation types to a booking mode

For each product‑variation type you want to sell as bookable inventory, choose a
mode:

- **Rentals** — sold as **date ranges** (for example, a room or a piece of
  equipment booked from one date to another).
- **Timeslots** — sold as **time slots** (for example, a lesson or appointment at
  a specific time).

Variation types you don't map stay as ordinary Commerce products.

## 3. Choose calendar plugins and defaults

Still in the settings, pick which calendar the add‑to‑cart form uses and set its
defaults:

- **FullCalendar** — the richer calendar UI, best for both date ranges and
  timeslots.
- **Flatpickr** — a lighter‑weight date picker.

## 4. Configure capacity defaults and presets

Set your capacity defaults here, and create reusable **capacity presets** at
**Configuration → BAT / Availability → Capacity Presets** (`/admin/commerce/config/commerce-bat/capacity-presets`).
Presets let you define how much inventory a bookable product has and whether
capacity is **shared** across variations (a shared pool) or **separate** per
variation. Getting capacity right is what keeps availability accurate.

## 5. Add the BAT Date/Time widget to the add‑to‑cart form

On each bookable variation type, go to **Manage form display** and confirm the
**BAT Date/Time** widget is used on the add‑to‑cart form so shoppers get the
availability calendar when choosing dates or slots.

## 6. Manage blockouts

Use the admin **blockout calendar** at
`/admin/commerce/config/commerce-bat/blockout` to reserve inventory (for maintenance,
holidays, private use, etc.) and to see orders against your bookable inventory.

## 7. (Optional) Bulk‑sync existing orders

If you're adding Commerce BAT to a store that already has orders, run the **bulk
order sync** once to rebuild BAT events from those orders.

## A note on availability integrity

Availability and pricing are computed from BAT's events and units and layered on
Commerce's normal access controls. Because bookable inventory is finite, make
sure availability is checked **authoritatively at the point of purchase** so two
customers cannot book the same date or slot — treat BAT's availability as the
source of truth at checkout, not just a display hint.

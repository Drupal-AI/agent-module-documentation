Bee Hotel VertiCal is a vertical units-by-days availability calendar for daily hotel operations, with AJAX cell toggles that write BAT availability events.

---

This submodule gives staff a dense operational calendar at /admin/beehotel/vertical: rows are units, columns are days, and each cell is a flip-card showing availability, occupancy state, price/season and order details. Clicking a cell fires an AJAX callback that toggles the night's state or saves a chosen state, persisting it as a BAT availability_daily event. A rich set of services (TableBuilder, RowGenerator, HeaderGenerator, CellContentBuilder/Renderer, StateManager, OrderItemBuilder, SeasonResolver, AjaxHandlers) composes the table; a settings form and a permissions callback (BeehotelVerticalPermissions) control display and access. Requires the access_vertical_basic or access_vertical_full permission to open the calendar.

---

- See all units and their day-by-day availability on one screen.
- Toggle a room available/unavailable for a given date from the calendar.
- Save an explicit availability state per night as a BAT event.
- Show occupancy, order and guest details inline per day.
- Display price and season context alongside availability.
- Manage daily operations (who is in which room, which nights are blocked).
- Restrict calendar access with basic vs full vertical permissions.
- Restrict who can change the vertical settings form.
- Edit an event from a modal dialog opened over the calendar.
- Drive housekeeping and front-desk workflows from a single grid.
